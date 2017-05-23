//
//  ZPLocationManager.m
//  ZaloPay
//
//  Created by thanhqhc on 3/16/17.
//  Copyright © 2017 VNG Corporation. All rights reserved.
//

#import "EVLocationManager.h"
#import "EVCache.h"
#import "Macro.h"

@interface EVLocationManager () <CLLocationManagerDelegate>

@property (nonatomic, copy) void(^requestLocationCallback)(NSError *error,NSArray<CLLocation *> *locations);
@property (nonatomic, copy) void(^updateLocationCallback)(NSError *error,NSArray<CLLocation *> *locations);
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) RACDisposable *disposeUpdatingLocation;
@property (nonatomic) CLLocationCoordinate2D lastCoordinate;

@end

@implementation EVLocationManager

+ (instancetype)shareManager {
    
    static dispatch_once_t instanceDispatch;
    static EVLocationManager *instance;
    dispatch_once(&instanceDispatch, ^{
        instance = [EVLocationManager new];
    });
    
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        CLLocationCoordinate2D lastLocationInit;
        lastLocationInit.latitude = 0;
        lastLocationInit.longitude = 0;
        self.lastCoordinate = lastLocationInit;
    }
    return self;
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        _locationManager.distanceFilter = 2;
    }
    return _locationManager;
}

- (void)updateLocation {
    @weakify(self);
    [[self getCurrentPositionInfo]
     subscribeNext:^(NSArray<CLLocation *> *locations) {
         @strongify(self);
         if (locations && locations.lastObject) {
             // F1. Lấy thông tin tọa độ từ hệ thống:
             self.lastCoordinate = locations.lastObject.coordinate;
             [self storageLocation];
         }
     }];
}

- (RACSignal *)getCurrentPositionInfo {
    
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        // Check eligibility for get location
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse ||
            [CLLocationManager locationServicesEnabled] == NO) {

            [subscriber sendError:NULL];
        } else {
            @weakify(self);
            self.requestLocationCallback = ^(NSError *error,NSArray<CLLocation *> *locations) {
                @strongify(self);
                if (error) {
                    [subscriber sendError:error];
                } else if (locations && locations.lastObject) {
                    CLLocation *lastLocationGet = locations.lastObject;
                    double deltaLng = fabs(self.lastCoordinate.latitude - lastLocationGet.coordinate.latitude);
                    double deltaLat = fabs(self.lastCoordinate.longitude - lastLocationGet.coordinate.longitude);
                    if ( deltaLng > 0.00001 || deltaLng > 0.00001) {
                        [subscriber sendNext:locations];
                        self.lastCoordinate = locations.lastObject.coordinate;
                        [self storageLocation];
                    }
                } else {
                    [subscriber sendError:NULL];
                }
            };
            
            [self.locationManager startUpdatingLocation];
        }
        return NULL;
    }];
}

#pragma mark - Public's

- (void)setConfigureLocationManager:(CLLocationManager *)manager {
    self.locationManager = manager;
}

- (RACSignal *)didUpdateLocation {
    
    [self stopUpdating];
    [_locationManager startUpdatingLocation];
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        
        self.updateLocationCallback = ^(NSError *error, NSArray<CLLocation *> *locations) {
            if (error) {
                [subscriber sendError:error];
            } else if (locations) {
                [subscriber sendNext:locations.lastObject];
            } else {
                [subscriber sendError:NULL];
            }
        };
        
        // GET STORAGE LOCATION
        CLLocationCoordinate2D coordinate = [self getCoordinate];
        CLLocation *locationTemp = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        [subscriber sendNext: locationTemp];
        
        return [RACDisposable disposableWithBlock:^{
            [self.locationManager stopUpdatingLocation];
            self.updateLocationCallback = NULL;
        }];
    }];
}

- (CLLocationCoordinate2D)getCoordinate {
    [self startUpdating];
    if (self.lastCoordinate.latitude != 0 || self.lastCoordinate.longitude != 0) {
        return self.lastCoordinate;
    }
    
    return [self getCoordinateFromStorage];
}

- (void)startUpdating {
    // First Time update location
    // Khởi tạo 1 background task để thực hiện lấy thông tin tọa độ từ hệ thống
    if (self.disposeUpdatingLocation) {
        [self.disposeUpdatingLocation dispose];
    }
    [self updateLocation];
    RACSignal *repetitiveEventSignal = [RACSignal interval:UPDATE_LOCATION_TIME
                                               onScheduler:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground]
                                                withLeeway:0];
    @weakify(self);
    self.disposeUpdatingLocation = [repetitiveEventSignal subscribeNext:^(NSDate *currentDate) {
        @strongify(self);
        [self updateLocation];
    }];
}

- (void)stopUpdating {
    if (self.disposeUpdatingLocation &&
        ![self.disposeUpdatingLocation isDisposed]) {
        [self.disposeUpdatingLocation dispose];
    }
}

# pragma mark - Storage

- (void)storageLocation {
    
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(backgroundQueue, ^{
        NSString *locationString = [NSString stringWithFormat:@"%.8f - %.8f",
                                    self.lastCoordinate.latitude,
                                    self.lastCoordinate.longitude];
        [EVCache disk_setObject:locationString forKey: @"user_location"];
    });
}

- (CLLocationCoordinate2D)getCoordinateFromStorage {
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(0, 0);
    NSString *locationString = [EVCache disk_objectForKey:@"user_location"];
    if ( !locationString || ![locationString isKindOfClass:[NSString class]]) {
        return coordinate;
    }
    
    NSArray<NSString *> *components = [locationString componentsSeparatedByString:@" - "];
    
    if(components.count != 2) {
        return coordinate;
    }
    
    double latitude, longitude;
    [[NSScanner scannerWithString:components[0]] scanDouble:&latitude];
    [[NSScanner scannerWithString:components[1]] scanDouble:&longitude];
    coordinate.latitude = latitude;
    coordinate.longitude = longitude;
    
    return coordinate;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    if (self.requestLocationCallback) {
        self.requestLocationCallback(NULL, locations);
    }
    
    if (self.updateLocationCallback) {
        self.updateLocationCallback(NULL,locations);
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    if (self.requestLocationCallback) {
        self.requestLocationCallback(error, NULL);
    }
    if(self.updateLocationCallback) {
        self.updateLocationCallback(error,NULL);
    }
}

@end
