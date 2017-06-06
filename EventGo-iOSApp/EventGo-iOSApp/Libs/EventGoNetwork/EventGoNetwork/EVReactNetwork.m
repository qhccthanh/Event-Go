//
//  EVReactNetwork.m
//  EventGoNetwork
//
//  Created by Quach Ha Chan Thanh on 3/19/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import "EVReactNetwork.h"
#import "AFNetworking.h"
#import "NSError+EVAPI.h"

@interface EVReactNetwork ()

@property (nonatomic, strong) NSURLSession *client;

@end

@implementation EVReactNetwork

+ (NSURLSession *)client {
    static NSURLSession *client = NULL;
    if (!client) {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.timeoutIntervalForRequest = 10.;
        client = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    }
    return client;
}

+ (NSString *)stringFromEnumMethod:(EVReactNetworkMethod)method {
    
    switch (method) {
        case EVReactNetworkMethod_GET:
            return @"GET";
        case EVReactNetworkMethod_POST:
            return @"POST";
        case EVReactNetworkMethod_PUT:
            return @"PUT";
        case EVReactNetworkMethod_DELETE:
            return @"DELETE";
            
    }
}

+ (RACSignal *)requestWithMethod:(EVReactNetworkMethod)method
                          header:(NSDictionary *)headers
                       urlString:(NSString *)urlString
                          params:(NSDictionary *)params {
    
    NSString* nMethod = [self stringFromEnumMethod:method];
    NSURLRequest *request = [self urlRequestWithMethod:nMethod
                                                header:headers
                                             urlString:urlString
                                                  body:params];
    
    if ([nMethod isEqualToString:@"GET"]) {
        request = [self urlRequestWithMethod:nMethod
                                      header:headers
                                   urlString:urlString
                                      params:params
                                        body:nil];
    }
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [self.client dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSError *paraseError;
            if (!data) {
                [subscriber sendError:nil];
                return;
            }
            
            NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&paraseError];
            NSLog(@"error : %@",error);
            NSLog(@"data = %@",dictData);
            
            if (error) {
                [subscriber sendError:error];
                return;
            }
            
            if (paraseError) {
                NSString *errorStr = [[NSString alloc] initWithData:data encoding
                                                                   :NSUTF8StringEncoding];
                if (errorStr) {
                    [subscriber sendError:
                     [NSError errorWithDomain:@"evgo.com" code:-120 userInfo:@{NSLocalizedDescriptionKey:errorStr}]
                     ];
                    return;
                }
                
                [subscriber sendError:paraseError];
                return;
            }
            
            [subscriber sendNext:dictData];
            [subscriber sendCompleted];
        }];
        [task resume];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

+ (NSURLRequest *)urlRequestWithMethod:(NSString *)method
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

+ (NSURLRequest *)urlRequestWithMethod:(NSString *)method
                          header:(NSDictionary *)headers
                       urlString:(NSString *)urlString
                            body:(NSDictionary *)body {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    if ([headers isKindOfClass:[NSDictionary class]] && headers.count > 0) {
        request.allHTTPHeaderFields = headers;
    }
    
    if (![method isKindOfClass:[NSString class]] || method.length == 0) {
        method = @"GET";
    }
    
    request.HTTPMethod = method;
    request.timeoutInterval = 10.0;
    NSError *error;
    if ([body isKindOfClass:[NSDictionary class]] && body.allKeys.count > 0) {
        NSData *dataFromDict = [NSJSONSerialization dataWithJSONObject:body
                                                               options:NSJSONWritingPrettyPrinted
                                                                 error:&error];
        [request setHTTPBody:dataFromDict];
    }
    
    return request;
}

//+ (NSError *)errorFromNetworkError:(NSError *)error {
//    NSDictionary *userInfo = [self userInforFromError:error];
//    return [[NSError alloc ] initWithDomain:@"Zalo Pay" code:error.code userInfo:userInfo];
//}

+ (NSDictionary *)userInforFromError:(NSError *)error {
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

+ (NSInteger)eventIdFromUrlString:(NSURL *)url {

    return -1;
}


@end
