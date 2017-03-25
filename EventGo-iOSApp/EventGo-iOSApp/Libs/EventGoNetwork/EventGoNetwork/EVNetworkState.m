//
//  EVNetworkState.m
//  EventGoNetwork
//
//  Created by Quach Ha Chan Thanh on 3/19/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import "EVNetworkState.h"
#import "AFNetworking.h"

@interface EVNetworkState ()

@property (nonatomic, strong) RACSubject *internalSignal;

@end

@implementation EVNetworkState

+ (instancetype)sharedInstance {
    static EVNetworkState *_return;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _return = [[EVNetworkState alloc] init];
    });
    return _return;
}

- (id)init {
    self = [super init];
    if (self) {
        _internalSignal = [RACSubject subject];
        [self startMonitorNetwork];
    }
    
    return self;
}

- (RACSignal *)networkSignal {
    
    return _internalSignal;
}

- (BOOL)isReachable {
    
    return [AFNetworkReachabilityManager sharedManager].isReachable;
}

- (void)startMonitorNetwork {
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSNumber *connected = @([AFNetworkReachabilityManager sharedManager].isReachable);
        [_internalSignal sendNext:connected];
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

@end
