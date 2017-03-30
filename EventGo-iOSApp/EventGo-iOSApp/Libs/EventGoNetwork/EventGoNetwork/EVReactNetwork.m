//
//  EVReactNetwork.m
//  EventGoNetwork
//
//  Created by Quach Ha Chan Thanh on 3/19/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import "EVReactNetwork.h"
#import <EventGoCommon/NSCollection+JSON.h>
#import "AFNetworking.h"
#import "NSError+EVAPI.h"

@interface EVReactNetwork ()

@property (nonatomic, strong) NSURLSession *client;

@end

@implementation EVReactNetwork

- (NSURLSession *)client {
    if (!_client) {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.timeoutIntervalForRequest = 10.;
        _client = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    }
    return _client;
}

- (RACSignal *)requestWithMethod:(NSString *)method
                          header:(NSDictionary *)headers
                       urlString:(NSString *)urlString
                          params:(NSDictionary *)param
                            body:(NSString *)bodyString {
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSURLRequest *request = [self urlRequestWithMethod:method
                                                    header:headers
                                                 urlString:urlString
                                                     params:param
                                                      body:bodyString];
        
        NSInteger eventId = [self eventIdFromUrlString:request.URL];
//        double startTime = eventId <= 0 ? 0 : [[NSDate date] timeIntervalSince1970] * 1000;
        
        NSURLSessionDataTask *task = [self.client dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSString *stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            DDLogDebug(@"error : %@",error);
//            DDLogDebug(@"data = %@",stringData);
            if (error) {
                NSError *zaloPayError = [self errorFromNetworkError:error];
                [subscriber sendError:zaloPayError];
                return;
            }
            
            if (eventId > 0) {
//                double endTime = [[NSDate date] timeIntervalSince1970] * 1000;
                //NSNumber *value = @(endTime - startTime);
//                [[ZPAppFactory sharedInstance].eventTracker  trackTiming:eventId value:value];
            }
            
            [subscriber sendNext:stringData];
            [subscriber sendCompleted];
        }];
        [task resume];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }] replayLazily];
}

- (NSURLRequest *)urlRequestWithMethod:(NSString *)method
                                header:(NSDictionary *)headers
                             urlString:(NSString *)urlString
                                 params:(NSDictionary *)param
                                  body:(NSString *)bodyString {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    if ([headers isKindOfClass:[NSDictionary class]] && headers.count > 0) {
        request.allHTTPHeaderFields = headers;
    }
    
    if (![method isKindOfClass:[NSString class]] || method.length == 0) {
        method = @"GET";
    }
    
    request.HTTPMethod = method;
    request.timeoutInterval = 10.0;
    
    if ([bodyString isKindOfClass:[NSString class]] && bodyString.length > 0) {
        [request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if ([param isKindOfClass:[NSDictionary class]] && param.count > 0) {
        NSString *query = AFQueryStringFromParameters(param);
        request.URL = [NSURL URLWithString:[[request.URL absoluteString] stringByAppendingFormat:request.URL.query ? @"&%@" : @"?%@", query]];
    }
    
    return request;
}

- (NSError *)errorFromNetworkError:(NSError *)error {
    NSDictionary *userInfo = [self userInforFromError:error];
    return [[NSError alloc ] initWithDomain:@"Zalo Pay" code:error.code userInfo:userInfo];
}

- (NSDictionary *)userInforFromError:(NSError *)error {
    NSString *message;
    NSInteger code = error.code;
    if ([error isRequestTimeout]) {
        message = @"Hết thời gian kết nối";
        code = 0;
    } else if (error.code >= 2) {
        message = @"Máy chủ đang bị lỗi. Vui lòng thử lại sau";
    } else if (error.code <= -1) {
        message = @"Mạng kết nối không ổn định. Vui lòng kiểm tra kết nối và thử lại";
    } else {
        message = @"Có lỗi xảy ra bạn vui lòng thử lại sau";
    }
    
    return @{
             @"error_code": @(code),
             @"error_message": message
             };
}

- (NSInteger)eventIdFromUrlString:(NSURL *)url {
//    NSString *urlString = url.relativeString;
    
//    if ([urlString hasSuffix:@"/esale/zalopayshop/v4/getshopitemlist"]) {
//        return EventAction_esale_api_v4_getshopitemlist;
//    }
//    if ([urlString hasSuffix:@"/esale/zalopayshop/v4/createorder"]) {
//        return EventAction_esale_api_v4_createorder;
//    }
//    if ([urlString hasSuffix:@"/esale/zalopayshop/v4/gethistory"]) {
//        return EventAction_esale_api_v4_gethistory;
//    }
//    if ([urlString hasSuffix:@"/esale/zalopayshop/v4/getresult"]) {
//        return EventAction_esale_api_v4_getresult;
//    }
//    if ([urlString hasSuffix:@"/esale/zalopayshop/v4/carddetail"]) {
//        return EventAction_esale_api_v4_carddetail;
//    }
//    if ([urlString hasSuffix:@"/esale/zalopayshop/v4/getproviders"]) {
//        return EventAction_esale_api_v4_getproviders;
//    }
//    if ([urlString hasSuffix:@"/esale/zalopayshop/v4/querybill"]) {
//        return EventAction_esale_api_v4_querybill;
//    }
    return -1;
}


@end
