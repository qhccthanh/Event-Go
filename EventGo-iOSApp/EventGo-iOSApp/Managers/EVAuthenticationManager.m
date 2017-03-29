//
//  EVAuthenticationManager.m
//  EventGoAuthentication
//
//  Created by Quach Ha Chan Thanh on 3/19/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import "EVAuthenticationManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@interface EVAuthenticationManager () <GIDSignInDelegate, GIDSignInUIDelegate>

@property (weak, nonatomic) UIViewController *currentController;
@property (nonatomic, copy) void(^googleSignHandle)(GIDGoogleUser *user, NSError *error);

@end

@implementation EVAuthenticationManager

+ (instancetype)shareManager {
    
    static EVAuthenticationManager *instance;
    static dispatch_once_t once_instace;
    dispatch_once(&once_instace, ^{
        instance = [EVAuthenticationManager new];
    });
    
    return instance;
}

- (RACSignal *)authenticateWithFacebookInController:(UIViewController *)controller {
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
       
        FBSDKLoginManager *manager = [FBSDKLoginManager new];
        [manager logInWithReadPermissions:@[@"email", @"public_profile"] fromViewController:controller
                                  handler:^(FBSDKLoginManagerLoginResult *result,
                                            NSError *error) {
                                      if (result) {
                                          [subscriber sendNext:result];
                                          return;
                                      }
                                      [subscriber sendError:error];
        }];
        
        return [RACDisposable new];
    }];
}

- (RACSignal *)authenticateWithGoogleInController:(UIViewController *)controller {
    
    _currentController = controller;
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        self.googleSignHandle = ^(GIDGoogleUser *user, NSError *error) {
            if (user) {
                [subscriber sendNext:user];
                return;
            }
            [subscriber sendError:error];
        };
//        [[GIDSignIn sharedInstance] signIn];
        return [RACDisposable new];
    }];
}

- (RACSignal *)signOut {
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [[GIDSignIn sharedInstance] signOut];
        
        return [RACDisposable new];
    }];
}

- (RACSignal *)getInfoFromProvider {
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        return [RACDisposable new];
    }];
}

#pragma mark - GIDSignInDelegate

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    if (self.googleSignHandle) {
        self.googleSignHandle(user,error);
    }
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error {
    
}

#pragma mark - GIDSignInUIDelegate

// The sign-in flow has finished selecting how to proceed, and the UI should no longer display
// a spinner or other "please wait" element.
- (void)signInWillDispatch:(GIDSignIn *)signIn
                     error:(NSError *)error {
    
}

- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController {
    
    if (_currentController) {
        [_currentController presentViewController:viewController animated:TRUE completion:nil];
    }
}

- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    
    [viewController dismissViewControllerAnimated:TRUE completion:nil];
}

@end
