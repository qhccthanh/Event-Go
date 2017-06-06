//
//  EVReactNetwork.h
//  EventGoNetwork
//
//  Created by Quach Ha Chan Thanh on 3/19/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjc/ReactiveObjc.h>

typedef enum : NSInteger {
    EVReactNetworkMethod_GET,
    EVReactNetworkMethod_POST,
    EVReactNetworkMethod_PUT,
    EVReactNetworkMethod_DELETE,
} EVReactNetworkMethod;

@interface EVReactNetwork : NSObject

+ (RACSignal *)requestWithMethod:(EVReactNetworkMethod)method
                          header:(NSDictionary *)headers
                       urlString:(NSString *)urlString
                          params:(NSDictionary *)params;

@end
