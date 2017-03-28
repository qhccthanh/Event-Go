//
//  EVNetworkManager.m
//  EventGoNetwork
//
//  Created by Quach Ha Chan Thanh on 3/19/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import "EVNetworkManager.h"
#import "AFNetworking.h"
#import "NSError+EVAPI.h"

NSString *kBaseUrl = @"";
NSString *kZaloPayClientAppId = @"";
NSString *kUploadUrl = @"";

#define kRequestTimout      10.0
#define kRequestRetry       3

static NSString *checkPath = @"/v001/tpe/getbalance";

@interface EVNetworkManager ()

@property (nonatomic, strong) AFHTTPSessionManager *client;
@property (nonatomic, copy) PrehandleServerError prehandleError;
@property (nonatomic, copy) AccessTokeUpdateHandle accesstokeUpdateHandle;

@end

@implementation EVNetworkManager

+ (instancetype)sharedInstance {
    static EVNetworkManager *instane;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instane = [[EVNetworkManager alloc] initWithBaseUrl:kBaseUrl];
    });
    
    return instane;
}

- (id)initWithBaseUrl:(NSString *)baseUrl {
    self = [super init];
    
    if (self) {
        self.allDurations = [NSMutableDictionary new];
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.timeoutIntervalForRequest = kRequestTimout;
        
        NSMutableOrderedSet *mutableClass = [NSMutableOrderedSet orderedSetWithArray:sessionConfiguration.protocolClasses];
        
        [mutableClass insertObject:[EVNetworkManagerRecorderProtocol class] atIndex:0];
        sessionConfiguration.protocolClasses = [mutableClass array];
        
        self.client = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]
                                               sessionConfiguration:sessionConfiguration];
        if (self.client) {
            NSMutableSet *contentType = [[NSMutableSet alloc] initWithSet:self.client.responseSerializer.acceptableContentTypes];
            [contentType addObject:@"text/plain"];
            [contentType addObject:@"text/html"];
//            self.client.requestSerializer = [AFJSONRequestSerializer serializer];
            self.client.responseSerializer.acceptableContentTypes = contentType;
            self.client.completionQueue = dispatch_queue_create("zalopay.network.queue", DISPATCH_QUEUE_CONCURRENT);
        }
    }
    
    return self;
}

- (void)prehandleError:(PrehandleServerError)handle {
    self.prehandleError = handle;
}

- (void)accessTokenChangeHandle:(AccessTokeUpdateHandle)handle {
    self.accesstokeUpdateHandle = handle;
}


- (void)cancelAllRequest {
    [self.client.operationQueue cancelAllOperations];
}

#pragma mark - Public Function

- (NSDictionary *)requestParamWithParam:(NSDictionary *)params {
    
    NSMutableDictionary *requestParams = [NSMutableDictionary dictionary];
    if (params) {
        [requestParams addEntriesFromDictionary:params];
    }
    if (![requestParams objectForKey:@"appid"]) {
        [requestParams setObject:kZaloPayClientAppId forKey:@"appid"];
    }
     NSString *appVersion = [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    
    [requestParams setObjectCheckNil:appVersion forKey:@"appversion"];
    [requestParams setObjectCheckNil:[EVNetworkManager sharedInstance].accesstoken forKey:@"accesstoken"];
    [requestParams setObjectCheckNil:[EVNetworkManager sharedInstance].paymentUserId forKey:@"userid"];
    
    return requestParams;
}

- (RACSignal *)requestWithPath:(NSString *)path parameters:(NSDictionary *)params {
    return [self requestWithPath:path parameters:params requestEventId:0];
}

- (RACSignal *)requestWithPath:(NSString *)path parameters:(NSDictionary *)params requestEventId:(NSInteger)requestEventId {
    return [self requestWithPath:path parameters:params requestRetry:kRequestRetry requestEventId:requestEventId];
}

- (RACSignal *)requestWithPath:(NSString *)path parameters:(NSDictionary *)params requestRetry:(int)retryCount requestEventId:(NSInteger)requestEventId {

    NSDictionary *requestParams = [self requestParamWithParam:params];
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        double startTime = requestEventId <= 0 ? 0: [[NSDate date] timeIntervalSince1970] * 1000;
        [self retryWithPath:path
                     params:requestParams
                  subsciber:subscriber
               requestRetry:retryCount
                  startTime:startTime
              requestEventId:requestEventId];
        
        return nil;
    }] replayLazily];
}

- (void)retryWithPath:(NSString *)path
               params:(NSDictionary *)requestParams
            subsciber:(id<RACSubscriber>)subscriber
         requestRetry:(int)retryCount
            startTime:(double)startTime
        requestEventId:(NSInteger)requestEventId {
    
   /* NSURLSessionDataTask *requestTask = */[self.client GET:path
                                              parameters:requestParams
                                                progress:nil
                                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                                              DDLogInfo(@"<-- %@", task.currentRequest.URL);
//                                              DDLogInfo(@"<-- %@", responseObject);
                                              NSError *error = [self preHandleResult:responseObject
                                                                               error:nil
                                                                          subscriber:subscriber];
                                              if (error) {
                                                  [self logError:error request:task.currentRequest];
                                              } else if (requestEventId > 0) {
                                                  double currentTime = [[NSDate date] timeIntervalSince1970] * 1000;
                                                  double requestTime = currentTime - startTime;
                                                  if ([task.originalRequest.URL.path isEqualToString:checkPath]) {
                                                      requestTime = [task.originalRequest getTimeDurationRequest];
                                                      
//                                                      DDLogInfo(@"abc");
                                                  }
                                                  
//                                                  [[ZPAppFactory sharedInstance].eventTracker trackTiming:requestEventId value:@(requestTime)];
                                              }
                                          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                                              DDLogInfo(@"<-- %@", task.currentRequest.URL);
//                                              DDLogInfo(@"<-- error : %@", error);
                                              [self logError:error request:task.currentRequest];
                                              int remainRetry = retryCount - 1;
                                              if ([error isRequestTimeout] && remainRetry > 0) {
                                                  [self retryWithPath:path
                                                               params:requestParams
                                                            subsciber:subscriber
                                                         requestRetry:remainRetry
                                                            startTime:startTime
                                                        requestEventId:requestEventId];
                                                  return;
                                              }
                                              
                                              [self preHandleResult:nil
                                                              error:error
                                                         subscriber:subscriber];
                                              
                                          }];
    
//    DDLogInfo(@"request retry count :%d",retryCount);
//    DDLogInfo(@" --> %@", requestTask.originalRequest.URL);
}


- (RACSignal *)postRequestWithPath:(NSString *)path
                    parameters:(NSDictionary *)params
                 requestEventId:(NSInteger)requestEventId {
    
    NSDictionary *requestParams = [self requestParamWithParam:params];
    //double startTime = requestEventId <= 0 ? 0: [[NSDate date] timeIntervalSince1970] * 1000;
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        /*NSURLSessionDataTask *requestTask = */[self.client POST:path
                                                   parameters:requestParams
                                                     progress:nil
                                                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                                                          DDLogInfo(@"<-- %@", task.currentRequest.URL);
//                                                          DDLogInfo(@"<-- %@", responseObject);
                                                          NSError *error = [self preHandleResult:responseObject
                                                                                           error:nil
                                                                                      subscriber:subscriber];
                                                          if (error) {
                                                              [self logError:error request:task.currentRequest];
                                                          } else if (requestEventId > 0) {
                                                              //double currentTime = [[NSDate date] timeIntervalSince1970] * 1000;
//                                                              double requestTime = currentTime - startTime;
//                                                              [[ZPAppFactory sharedInstance].eventTracker trackTiming:requestEventId value:@(requestTime)];
                                                          }

                                                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                                                          DDLogInfo(@"<-- %@", task.currentRequest.URL);
//                                                          DDLogInfo(@"<-- error : %@", error);
                                                          [self logError:error request:task.currentRequest];
                                                          [self preHandleResult:nil
                                                                          error:error
                                                                     subscriber:subscriber];
                                                          
                                                      }];
        
//        DDLogInfo(@" --> %@", requestTask.originalRequest.URL);
        
        return nil;
    }] replayLazily];
}



- (void)logError:(NSError *)error request:(NSURLRequest *)request {
    
    if ([error isNetworkConnectionError] || [error isRequestTimeout]) {
        return;
    }
//    DDLogError(@"error [%@] in request [%@]",error,request.URL);
}

- (NSError *)preHandleResult:(NSDictionary *)responseData
                  error:(NSError *)error
             subscriber:(id<RACSubscriber>)subscriber {
    
    if (error) {
        [subscriber sendError:error];
        return error;
    }
    
    if (![responseData isKindOfClass:[NSDictionary class]] || responseData.count == 0) {
        NSError *dataError = [NSError errorWithDomain:@"ResponseDataError" code:-1 userInfo:nil];
        [subscriber sendError:dataError];
        return dataError;
    }
    
    NSString *accesstoken = [responseData stringForKey:@"accesstoken"];
    if (accesstoken.length && ![accesstoken isEqualToString:self.accesstoken])
    {
        self.accesstoken = accesstoken;
        if (self.accesstokeUpdateHandle) {
            self.accesstokeUpdateHandle(accesstoken);
        }
    }
    
    int errorCode = [responseData intForKey:@"returncode"];
    if (errorCode != EVENTGO_ERRORCODE_SUCCESSFUL) {
        NSError *returnError = [NSError errorFromDic:responseData];
        
        if (self.prehandleError) {
            self.prehandleError(errorCode,[returnError apiErrorMessage]);
        }
        
        [subscriber sendError:returnError];
        return returnError;
    }
    
    [subscriber sendNext:responseData];
    [subscriber sendCompleted];
    return nil;
}

- (RACSignal *)uploadWithPath:(NSString *)path
                       param:(NSDictionary *)params
                   formBlock:(void (^)(id <AFMultipartFormData> formData))block
               requestEventId:(NSInteger)requestEventId {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSDictionary *requestParam = [self requestParamWithParam:params];
//        double startTime = requestEventId <= 0 ? 0: [[NSDate date] timeIntervalSince1970] * 1000;
        NSURL *url = [NSURL URLWithString:path relativeToURL:[NSURL URLWithString:kUploadUrl]];
        NSString *urlString = url.absoluteString;
        
//        DDLogInfo(@"upload url string :%@",urlString);
        
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                                                                  URLString:urlString
                                                                                                 parameters:requestParam constructingBodyWithBlock:block
                                                                                                      error:nil];
//        DDLogInfo(@"--> %@",request.URL);
        NSURLSessionUploadTask *uploadTask = [self.client
                                              uploadTaskWithStreamedRequest:request
                                              progress:nil
                                              completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                  if (error) {
//                                                      DDLogInfo(@"<-- error : %@", error);
                                                  }else {
//                                                      DDLogInfo(@"<-- %@", responseObject);
                                                    if (requestEventId > 0) {
//                                                          double currentTime = [[NSDate date] timeIntervalSince1970] * 1000;
//                                                          double requestTime = currentTime - startTime;
//                                                          [[ZPAppFactory sharedInstance].eventTracker trackTiming:requestEventId value:@(requestTime)];
                                                      }
                                                  }                                                  
                                                  [self preHandleResult:responseObject
                                                                  error:error
                                                             subscriber:subscriber];
                                              }];
        
        [uploadTask resume];
        return nil;
    }];
}

- (NSURLSessionDownloadTask* )downloadFileWithUrl:(NSString *)urlString
                                   saveToFilePath:(NSString *)savePath
                                         progress:(DowloadProgressBlock)progress
                                         complete:(DowloadCompleteBlock)complete {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)    {
        [self IOS7downloadFileWithUrl:urlString saveToFilePath:savePath progress:progress complete:complete];
        return nil;
    }
    
    id progressHandle = nil;
    if(progress) {
        progressHandle  = ^(NSProgress * _Nonnull downloadProgress) {
            float current = (float)downloadProgress.completedUnitCount;
            float total = (float)downloadProgress.totalUnitCount;
            progress(current/total);
        };
    }
    
    NSURLSessionDownloadTask *downloadTask = [self.client downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]
                                                                         progress:progressHandle
                                                                      destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                                                                          return [NSURL fileURLWithPath:savePath];
                                                                      } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                                                                          if (complete) {
                                                                              complete([filePath resourceSpecifier], error);
                                                                          }
                                                                      }];
    [downloadTask resume];
    return downloadTask;
}

- (void)IOS7downloadFileWithUrl:(NSString *)urlString
                 saveToFilePath:(NSString *)savePath
                       progress:(DowloadProgressBlock)progress
                       complete:(DowloadCompleteBlock)complete{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        NSError *error = nil;
        if (data) {
            [data writeToFile:savePath atomically:true];
        } else {
            error = [NSError errorWithDomain:@"ZaloPay" code:-1 userInfo:nil];
        }
        if (complete) {
            complete(savePath,error);
        }
    });
}


- (RACSignal *)requestWithUrlString:(NSString *)urlString userAgent:(NSString *)userAgent {
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        defaultConfiguration.timeoutIntervalForRequest = kRequestTimout;

        NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfiguration];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: urlString]];
        if (userAgent) {
            [request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
        }        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                NSString *stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSDictionary *json = [stringData JSONValue];
                if ([json isKindOfClass:[NSDictionary class]]) {
                    [subscriber sendNext:json];
                    [subscriber sendCompleted];
                    return;
                }
            }
            [subscriber sendError:error];
        }];
        [task resume];
        return nil;
    }] replayLazily];
}

@end

#pragma mark - Record Protocol
@interface EVNetworkManagerRecorderProtocol()<NSURLSessionDataDelegate>
@property (copy, nonatomic) NSString *currentPath;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSURLSessionDataTask *currentTask;
@end

@implementation EVNetworkManagerRecorderProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    // Check only get balance
    NSString *path = request.URL.path;
    return [path isEqualToString:checkPath];
}

+ (BOOL)canInitWithTask:(NSURLSessionTask *)task {
    NSString *path = task.originalRequest.URL.path;
//    DDLogInfo(@"----------------path : %@", path);
    return [path isEqualToString:checkPath];
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    self.currentPath = self.request.URL.absoluteString;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = kRequestTimout;
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.name = @"com.zalopay.checkTime";
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:queue];
    self.currentTask = [session dataTaskWithRequest:self.request];
    self.startDate = [NSDate date];
    [_currentTask resume];
    
}

- (void)stopLoading {
    [_currentTask cancel];
    self.currentTask = nil;
}

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    
    [self.client URLProtocol:self didLoadData:data];
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error) {
        [self.client URLProtocol:self didFailWithError:error];
    } else {
        NSTimeInterval duration = [[NSDate date] timeIntervalSinceDate:_startDate];
        [self.request setDurationRequest:duration * 1000];
    }
    [self.client URLProtocolDidFinishLoading:self];
}

@end

@implementation NSURLRequest (Extension)

- (void)setDurationRequest:(NSTimeInterval)duration {
    [[EVNetworkManager sharedInstance].allDurations setValue:@(duration)
                                                      forKey:self.URL.absoluteString];
}

- (NSTimeInterval)getTimeDurationRequest {
    
    NSNumber *d = [[EVNetworkManager sharedInstance].allDurations
                   valueForKey:self.URL.absoluteString];
    [[EVNetworkManager sharedInstance].allDurations removeObjectForKey:self.URL.absoluteString];
    NSTimeInterval result = d ? [d doubleValue] : 0;
    
    return result;
}

@end

