//
//  CTImageManger.m
//  ZaloContact
//
//  Created by qhcthanh on 5/23/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

#import "CTCacheImageManager.h"

@implementation CTCacheImageManager {
    NSMutableDictionary* imageLetterDictionary;
    dispatch_queue_t internalQueue;
}

+(instancetype) shareManager {
    static CTCacheImageManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(id) init {
    self = [super init];
    imageLetterDictionary = [[NSMutableDictionary alloc] init];
    internalQueue = dispatch_queue_create("Caching_Image_Queue", DISPATCH_QUEUE_SERIAL);
    return self;
}

-(CTCacheImageStatus)cachingImageWithIdentifield:(NSString*)identified image:(UIImage*) image {
    // check image and identified not nil. Else return
    if (identified && image) {
        __block CTCacheImageStatus statusCode = kCTCacheImageStatusSuccess;
        dispatch_sync(internalQueue, ^{
            //Check image is exits get it and return
            UIImage* imageCreate = [imageLetterDictionary objectForKey:identified];
            if (imageCreate) {
                statusCode = kCTCacheImageStatusHasExists;
            }
            //   Image is not exits create image with key
            //Add image to dictionary
            [imageLetterDictionary setValue:image forKey:identified];

        });
        
        return statusCode;
    }
    // if image nil
    if (!identified) {
        return kCTCacheImageStatusErrorImageNil;
    } else if (!image) { // if identifield nil
        return kCTCacheImageStatusErrorIdentifieldNil;
    } // if image and identifield nil
    return kCTCacheImageStatusErrorIdentifieldAndImageNil;
}


-(UIImage *)getImageInCacheWithIdentifield:(NSString *)identified {
    if (identified) {
        __block UIImage* imageInCache = nil;
        // Get Image
        dispatch_sync(internalQueue, ^{
            imageInCache = [imageLetterDictionary objectForKey:identified];
        });
        return imageInCache;
    }
    return nil;
}

@end
