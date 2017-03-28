//
//  NSError+EVAPI.m
//  EventGoNetwork
//
//  Created by Quach Ha Chan Thanh on 3/19/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import "NSError+EVAPI.h"
#import "EventGoErrorCode.h"
#import <EventGoCommon/EventGoCommon.h>

@implementation NSError (EVAPI)

+ (instancetype)errorFromDic:(NSDictionary *)dic {
    int errorCode = [dic intForKey:@"returncode"];
    
    return  [NSError errorWithDomain:@"API Return Error"
                                code:errorCode
                            userInfo:dic];
}

- (BOOL)isNetworkConnectionError {
    
    return self.code == NSURLErrorNetworkConnectionLost ||
           self.code == NSURLErrorNotConnectedToInternet;
}

- (BOOL)isRequestTimeout {
    
    return self.code == NSURLErrorTimedOut;
}

- (NSString *)apiErrorMessage {
    
    NSDictionary *userInfo = self.userInfo;
    NSString *message = [userInfo stringForKey:@"returnmessage"];
    if (message.length > 0) {
        return message;
    }
    
    if ([self isNetworkConnectionError]) {
        return @"Vui lòng kiểm tra kết nối mạng.";
    }
    
    if ([self isRequestTimeout]) {
        return @"Hết thời gian kết nối đến đến máy chủ. Bạn vui lòng thử lại.";
    }
    
    return @"Có lỗi xảy ra bạn vui lòng thử lại sau.";
}

@end
