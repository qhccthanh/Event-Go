//
//  CTAddressBook.m
//  ZaloContact
//
//  Created by qhcthanh on 5/18/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

#import "CTAddressBook.h"


@interface CTAddressBook() {
    BOOL isLoadImage;
}
@end

@implementation CTAddressBook {
    
}

-(id)initWithInfo:(NSString*)identifield firstName:(NSString *)firstName lastName:(NSString *)lastName phones:(NSMutableArray *)phones image:(UIImage *)image {
    self = [super init];
    _lastName = lastName;
    _firstName = firstName;
    _phoneMutableArray = phones;
    _identifield = identifield;
    // load fullName
    if (_lastName == nil) {
        _fullName=[NSString stringWithFormat:@"%@",firstName];
    } else if (_firstName == nil){
        _fullName=[NSString stringWithFormat:@"%@",lastName];
    } else {
        _fullName=[NSString stringWithFormat:@"%@ %@",firstName,lastName];
    }
    //Load key
    if ([_firstName length] == 0 && [_lastName length] == 0 ) {
        _key = @"@";
    } else if([_firstName length] == 0) {
        _key = [NSString stringWithFormat:@"%C", [_lastName characterAtIndex:0]];
    } else if ([_lastName length] == 0) {
        _key = [NSString stringWithFormat:@"%C", [_firstName characterAtIndex:0]];
    } else  {
        _key = [NSString stringWithFormat:@"%C%C", [_firstName characterAtIndex:0],[_lastName characterAtIndex:0]];
    }
    
    //Load image in current queue sync
//    dispatch_sync([CTAddressBook getQueueLoadImageContact], ^{
//        UIImage* imageCache = [[CTDrawImageManager shareManager] getImageInCacheWithIdentifield:identifield];
//        if (imageCache) {
//            _mImage = imageCache;
//        } else {
//            if (image) {
//                _mImage =  image;
//            } else {
//                _mImage = [UIImage createImageFromText: _mKey size:CGSizeMake(38,38)];
//            }
//            [[CTDrawImageManager shareManager] cacheImageWithIdentifield:identifield image:_mImage];
//        }
//    });
    
    // load image with getter.
    if (image) {
        _image = image;
        [[CTCacheImageManager shareManager] cachingImageWithIdentifield:identifield image: image];
    }
    
    return self;
}

////get image
-(void)getContactImage:(completionImageHandler)completion {
    UIImage* imageCache = [[CTCacheImageManager shareManager] getImageInCacheWithIdentifield:_identifield];
    if(imageCache) {
        if (completion) {
            completion(imageCache);
        }
    }
    //Load image in current queue
    dispatch_async([CTAddressBook getQueueLoadImageContact], ^{
        UIImage* imageCache = [[CTCacheImageManager shareManager] getImageInCacheWithIdentifield:_identifield];
        if (imageCache) {
            _image = imageCache;
        } else {
            _image = [UIImage createImageFromText: _key size:CGSizeMake(38,38)];
            [[CTCacheImageManager shareManager] cachingImageWithIdentifield:_identifield image:_image];
        }
        if (completion) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                completion(_image);
            });
        }
        
    });
}

-(NSString*)getFirstCharacter {
    if ( _fullName != nil && _fullName.length != 0) {
        NSString* nameUpcase = [_fullName uppercaseString];
        unichar characterFirst = [nameUpcase characterAtIndex:0];
        NSString* stringFirst = [NSString stringWithFormat:@"%C",characterFirst];
        return stringFirst;
    }
    return @"";
}

/**
 *  GET DEFAULT QUEUE IN CTADDRESSBOOK
 *
 *  @return SERIAL QUEUE
 */
+(dispatch_queue_t)getQueueLoadImageContact {
    static dispatch_once_t once;
    static dispatch_queue_t loadImageSerialQueue;
    dispatch_once(&once, ^{
        loadImageSerialQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, false);
    });
    return loadImageSerialQueue;
}

@end
