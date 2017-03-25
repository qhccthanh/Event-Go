//
//  UIImage+Text.h
//  ZaloContact
//
//  Created by qhcthanh on 6/1/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Text)

/**
 *  Create new image with text and size of new image
 *
 *  @param text NSString will draw center image
 *  @param size of new image
 *
 *  @return new image has drawed text with size
 */
+(UIImage *)createImageFromText:(NSString *)text size:(CGSize)size;
@end
