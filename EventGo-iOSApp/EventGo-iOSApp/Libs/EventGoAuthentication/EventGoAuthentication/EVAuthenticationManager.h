//
//  EVAuthenticationManager.h
//  EventGoAuthentication
//
//  Created by Quach Ha Chan Thanh on 3/19/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <EventGoCommon/EventGoCommon.h>

typedef enum : NSUInteger {
    EVAuthenticationType_Facebook,
    EVAuthenticationType_Google,
    EVAuthenticationType_NotDetermine,
} EVAuthenticationType;

@interface EVAuthenticationManager : NSObject

@property (nonatomic, assign) NSString *currentAccessToken;
@property (nonatomic, assign) EVAuthenticationType *currentType;

+ (instancetype)shareManager;

- (RACSignal *)authenticateWithFacebookInController:(UIViewController *)controller;

- (RACSignal *)authenticateWithGoogleInController:(UIViewController *)controller;

- (RACSignal *)signOut;

- (RACSignal *)getInfoFromProvider;

@end
