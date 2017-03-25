//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import "UIFont+Extension.h"
#import <CoreText/CoreText.h>


@implementation UIFont(Extension)

+ (UIFont *)robotoBoldWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"Roboto-Bold" size:size];
}
+ (UIFont *)robotoRegularWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"Roboto-Regular" size:size];
}
+ (UIFont *)robotoMediumWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"Roboto-Medium" size:size];
}
+ (UIFont *)robotoMediumItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"Roboto-MediumItalic" size:size];
}
+ (UIFont *)helveticaNeueRegularWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}
+ (UIFont *)helveticaNeueBoldWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}
+ (UIFont *)helveticaNeueMediumWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:size];
}

+ (UIFont *)SFUITextRegularWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFUIText-Regular" size:size];
}

+ (UIFont *)SFUITextMediumWithSize:(CGFloat)size {
  //  [self dumpAllFonts];
    return [UIFont fontWithName:@"SFUIText-Medium" size:size];
}

+ (UIFont *)SFUITextSemiboldWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFUIText-Semibold" size:size];
}

+ (UIFont *)SFUITextRegularItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFUIText-RegularItalic" size:size];
}

+ (UIFont *)SFUITextSemiboldItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"SFUIText-SemiboldItalic" size:size];
}
@end
