//
//  SingletonContact.h
//  ZaloContact
//
//  Created by qhcthanh on 5/18/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <AddressBook/AddressBook.h>
#import "UIKit/UIKit.h"

// iOS Version Checking
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)

#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

typedef CF_ENUM(CFIndex, CTAuthorizationStatus) {
    kCTAuthorizationStatusNotDetermined = kABAuthorizationStatusNotDetermined,    // deprecated, use CNAuthorizationStatusNotDetermined
    kCTAuthorizationStatusRestricted,           // deprecated, use CNAuthorizationStatusRestricted
    kCTAuthorizationStatusDenied,               // deprecated, use CNAuthorizationStatusDenied
    kCTAuthorizationStatusAuthorized            // deprecated, use CNAuthorizationStatusAuthorized
};

@interface CTContactManager: NSObject

/**
 *  Completion Handler call when load all contact device complete
 *
 *  @param contactArray NSMutableArray Contact. contactArray maybe nil if load fail
 *  @param error        Nil if load success, else return CTAuthorizationStatus Error Code
 */
typedef void(^completionLoadContactHandler)(NSMutableArray  * _Nullable contactArray, NSError * _Nullable error);

/**
 *  Load image contact handler. return contactImage when get success. Image can nil if load fail
 *
 *  @param contactImage image when load success.
 */
typedef void(^completionImageHandler)(UIImage * _Nullable contactImage);

/**
 *  Request access contact device hanlder. callback when success and return error equal nil. If has error or user denied callback with CTAuthorizationStatus Error code
 *
 *  @param error The error completion block finsihed return
 */
typedef void(^requestedContactHandler)(NSError * _Nullable error);

/**
 *  Get single instance
 *
 *  @return instance of CTContactManger
 */
+ (nonnull instancetype)sharedManager;

/**
 *  Get all contact of this device, if iOS 9.x less than use AdressBook framework, if iOs 9.x more than use Contact Framework. If app not determine permission will call requestContactPermission
 *
 *  @param completion return NSMutableArray,CTError in Block. if CTError equal nil load contact success, if CTError != nil has error is defind in CTError. 
 *  @param queue      queue process when completion, if NULL process completion block in main thread
 */
- (void)getAllContactOfDevice:(completionLoadContactHandler _Nullable)completion queue:(dispatch_queue_t _Nullable)queue ;

/**
 *  Request contact in device
 *
 *  @param completion     (CTError*) block will call when completion request permission error return in block maybe kDeniedContactPermission if user denied permission, kNotDeterminePermission if not determine, nil if user has accepet permission.
 */
-(void)requestContactPermission:(requestedContactHandler _Nullable)completion;
@end
    
