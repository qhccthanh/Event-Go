//
//  NSError+EVAPI.h
//  EventGoNetwork
//
//  Created by Quach Ha Chan Thanh on 3/19/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (EVAPI)
+ (instancetype)errorFromDic:(NSDictionary *)dic;
- (NSString *)apiErrorMessage;

- (BOOL)isNetworkConnectionError;
- (BOOL)isRequestTimeout;
@end
