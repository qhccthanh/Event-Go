//
//  EVNetworkManager.h
//  EventGoNetwork
//
//  Created by Quach Ha Chan Thanh on 3/19/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import <EventGoCommon/EventGoCommon.h>
#import "EventGoErrorCode.h"
#import "NSError+EVAPI.h"

extern NSString *kBaseUrl;
extern NSString *kZaloPayClientAppId;
extern NSString *kUploadUrl;

@protocol AFMultipartFormData;

typedef  void (^DowloadCompleteBlock)(NSString *filePath, NSError *error);
typedef  void (^DowloadProgressBlock)(float progress);
typedef  void (^PrehandleServerError)(int errorCode, NSString *message);
typedef  void (^AccessTokeUpdateHandle)(NSString *accesstoken);


extern NSString *kZaloPayClientAppId;


@interface EVNetworkManager : NSObject

@property (nonatomic, strong) NSString *accesstoken;
@property (nonatomic, strong) NSString *paymentUserId;
@property (nonatomic, strong) NSMutableDictionary *allDurations;

+ (instancetype)sharedInstance;

- (void)cancelAllRequest;

- (id)initWithBaseUrl:(NSString *)baseUrl;

- (void)prehandleError:(PrehandleServerError)handle;

- (void)accessTokenChangeHandle:(AccessTokeUpdateHandle)handle;

- (void)setHeader:(NSDictionary *)headers;

- (RACSignal *)requestWithPath:(NSString *)path
                    parameters:(NSDictionary *)params;


- (RACSignal *)postRequestWithPath:(NSString *)path
                        parameters:(NSDictionary *)params;

- (RACSignal *)deleteRequestWithPath:(NSString *)path
                          parameters:(NSDictionary *)params;

- (RACSignal *)putRequestWithPath:(NSString *)path
                       parameters:(NSDictionary *)params;


- (NSURLSessionDownloadTask* )downloadFileWithUrl:(NSString *)urlString
                                   saveToFilePath:(NSString *)savePath
                                         progress:(DowloadProgressBlock)progress
                                         complete:(DowloadCompleteBlock)complete;
- (RACSignal *)uploadWithPath:(NSString *)path
                        param:(NSDictionary *)params
                    formBlock:(void (^)(id <AFMultipartFormData> formData))block;

- (RACSignal *)requestWithUrlString:(NSString *)urlString userAgent:(NSString *)userAgent;

@end

@interface EVNetworkManagerRecorderProtocol : NSURLProtocol

@end

@interface NSURLRequest (Extension)

- (void)setDurationRequest:(NSTimeInterval)duration;
- (NSTimeInterval)getTimeDurationRequest;

@end
