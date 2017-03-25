//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AspectRatioCalculator(size) \
CGRectGetWidth([UIScreen mainScreen].bounds)/414.0 *size
//1
@interface UIFont(Extension)

+ (UIFont *)robotoBoldWithSize:(CGFloat)size;
+ (UIFont *)robotoRegularWithSize:(CGFloat)size;
+ (UIFont *)robotoMediumWithSize:(CGFloat)size;
+ (UIFont *)robotoMediumItalicWithSize:(CGFloat)size;

+ (UIFont *)helveticaNeueRegularWithSize:(CGFloat)size;
+ (UIFont *)helveticaNeueBoldWithSize:(CGFloat)size;
+ (UIFont *)helveticaNeueMediumWithSize:(CGFloat)size;

+ (UIFont *)SFUITextRegularWithSize:(CGFloat)size;
+ (UIFont *)SFUITextMediumWithSize:(CGFloat)size;
+ (UIFont *)SFUITextSemiboldWithSize:(CGFloat)size;
+ (UIFont *)SFUITextRegularItalicWithSize:(CGFloat)size;
+ (UIFont *)SFUITextSemiboldItalicWithSize:(CGFloat)size;

@end
