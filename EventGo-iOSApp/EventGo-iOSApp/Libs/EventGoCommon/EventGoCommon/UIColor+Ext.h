//
//  UIColor+Ext.h
//  EventGoCommon
//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Ext)
+ (UIColor *)colorWithHexValue:(uint32_t)value;
+ (UIColor *)colorWithHexValue:(uint32_t)value alpha:(float)alpha;
+ (UIColor *)randomColor;
+ (UIColor *)colorFromHexString:(NSString *)hexString;
@end

@interface UIColor (EventGo)
+ (UIColor *)midNightBlueColor;
+ (UIColor *)egoBaseColor;
+ (UIColor *)lineColor;
+ (UIColor *)errorColor;
+ (UIColor *)defaultBackground;
+ (UIColor *)subText;
+ (UIColor *)defaultText;
+ (UIColor *)placeHolderColor;
+ (UIColor *)disableButtonColor;
+ (UIColor *)highlightButtonColor;
+ (UIColor *)payColor;
+ (UIColor *)selectedColor;

+ (UIColor *)ev_blue;
+ (UIColor *)ev_green;
+ (UIColor *)ev_red;
+ (UIColor *)ev_yellow;
+ (UIColor *)ev_gray;
+ (UIColor *)defaultAppIconColor;

+ (UIColor *)hex_0x333333;
+ (UIColor *)hex_0x2b2b2b;
+ (UIColor *)hex_0xacb3ba;

+ (UIColor *)egoLightBlueColor;
+ (UIColor *)egoLightLightBlueColor;
+ (UIColor *)egoDarkGreenColor;
+ (UIColor *)egoLightLightGrayColor;
+ (UIColor *)egoLightLightLightGrayColor;
+ (UIColor *)egoButtonDisabledColor;
+ (UIColor *)egoColorFromHexString:(NSString *)hexString;

@end

