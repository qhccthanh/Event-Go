//
//  EVLocationManager.h
//  Event Go
//
//  Created by thanhqhc on 3/16/17.
//  Copyright © 2017 VNG Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <ReactiveObjc/ReactiveObjc.h>

#define UPDATE_LOCATION_TIME 2.0f

typedef void(^LocationCompletionBlock)(NSArray<CLLocation *>* locations);

@interface EVLocationManager : NSObject

+ (instancetype)shareManager;

- (CLLocationCoordinate2D)getCoordinate;

- (void)stopUpdating;

- (void)startUpdating;

- (void)setConfigureLocationManager:(CLLocationManager *)manager;

- (RACSignal *)didUpdateLocation;

@end
