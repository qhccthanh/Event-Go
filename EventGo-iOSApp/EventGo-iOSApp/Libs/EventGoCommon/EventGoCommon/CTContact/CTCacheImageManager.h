//
//  CTImageManger.h
//  ZaloContact
//
//  Created by qhcthanh on 5/23/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTAddressBook.h"

typedef CF_ENUM(NSInteger,CTCacheImageStatus) {
    kCTCacheImageStatusSuccess = 0,
    kCTCacheImageStatusHasExists,
    kCTCacheImageStatusErrorIdentifieldNil,
    kCTCacheImageStatusErrorImageNil,
    kCTCacheImageStatusErrorIdentifieldAndImageNil,
};

@interface CTCacheImageManager : NSObject

/**
 *  Get singleton instance
 *
 *  @return instance
 */
+(instancetype)shareManager;

/**
 *  Caching Image With Identifield is Key, image is value in NSMutableDictionary. If image has existed with identifield return kCTCacheImageStatusHasExists. If image or identifield nil return status code kCTCacheImageStatusIdentifieldNil or kCTCacheImageStatusImageNil. If cache success return kCTCacheImageStatusSuccess
 *
 *  @param identified key to store
 *  @param image      store with identifield
 *
 *  @return CTCacheImageStatus 
 */
-(CTCacheImageStatus)cachingImageWithIdentifield:(NSString*)identified image:(UIImage*) image;

/**
 *  Get image in cahce with identifield. If don't have image with Identifield return nil
 *
 *  @param identified key of image in cache
 *
 *  @return image with identifield. Nil if don't have image with identifield
 */
-(UIImage*)getImageInCacheWithIdentifield:(NSString*)identified;

@end
