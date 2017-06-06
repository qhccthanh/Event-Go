//
//  EVNetworkState.h
//  EventGoNetwork
//
//  Created by Quach Ha Chan Thanh on 3/19/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjc/ReactiveObjc.h>

@interface EVNetworkState : NSObject

@property (nonatomic, readonly) BOOL isReachable;
@property (nonatomic, readonly) RACSignal *networkSignal;

+ (instancetype)sharedInstance;

@end
