//
//  UIColor+Ext.m
//  EventGoCommon
//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import "UIColor+Ext.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB color macro with alpha
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#import "UIColor+Ext.h"

@implementation UIColor (Extension)

+ (UIColor *)colorWithHexValue:(uint32_t)value {
    return UIColorFromRGB(value);
}

+ (UIColor *)colorWithHexValue:(uint32_t)value alpha:(float)alpha {
    return UIColorFromRGBWithAlpha(value, alpha);
}

+ (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    if (hexString.length != 7) {
        return nil;
    }
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end

@implementation UIColor (EventGo)

+ (UIColor *)subText {
    return UIColorFromRGB(0x727f8c);
}

+ (UIColor *)defaultText {
    return UIColorFromRGB(0x24272b);
}

+ (UIColor *)midNightBlueColor {
    return UIColorFromRGB(0x2c3e50);
}

// teal 500
+ (UIColor *)egoBaseColor {
    return [UIColor colorWithHexValue:0x266378];
}

// organ 500
+ (UIColor *)egoSecondaryColor {
    return [UIColor colorWithHexValue:0x52B888];
}

+ (UIColor *)lineColor {
    return [UIColor colorWithHexValue:0xe3e6e7];
}

+ (UIColor *)errorColor {
    return [UIColor colorWithHexValue:0xfe0000];
}

+ (UIColor*)defaultBackground {
    return UIColorFromRGB(0xF0F4F7);
}

+ (UIColor *)placeHolderColor {
    return [UIColor colorWithHexValue:0xacb3ba];
}

+ (UIColor *)disableButtonColor {
    return [UIColor colorWithHexValue:0xc7c7cc];
}
+ (UIColor *)highlightButtonColor {
    return [UIColor colorWithHexValue:0x0174af];
}
+ (UIColor *)payColor {
    return [UIColor colorWithHexValue:0x06BE04];
}
+ (UIColor *)selectedColor {
    return [UIColor colorWithHexValue:0xe7e9eb];
}

+ (UIColor *)ev_blue {
    return [self colorWithHexValue:0x4387f6];
}

+ (UIColor *)ev_green {
    return [self colorWithHexValue:0x129d5a];
}

+ (UIColor *)ev_red {
    return [self colorWithHexValue:0xde4438];
}

+ (UIColor *)ev_yellow {
    return [self colorWithHexValue:0xf6b501];
}

+ (UIColor *)ev_gray {
    return [self colorWithHexValue:0x53718b];
}

+ (UIColor *)defaultAppIconColor {
    return [self colorWithHexValue:0xbbc1c8];
}

+ (UIColor *)hex_0x333333 {
    return [self colorWithHexValue:0x333333];
}

+ (UIColor *)hex_0x2b2b2b {
    return [self colorWithHexValue:0x2b2b2b];
}

+ (UIColor *)hex_0xacb3ba {
    return [self colorWithHexValue:0xacb3ba];
}

+ (UIColor*) egoLightBlueColor{
    return [UIColor colorWithRed:(5.0 /255) green:(163.0f / 255) blue:(229.0f / 255) alpha:1];
}
+ (UIColor*) egoLightLightBlueColor{
    return [UIColor colorWithRed:(5.0 /255) green:(163.0f / 255) blue:(229.0f / 255) alpha:0.4];
}
+ (UIColor*) egoLightLightGrayColor{
    return [UIColor colorWithWhite:0.88f alpha:1.0];
}

+ (UIColor*) egoLightLightLightGrayColor{
    return [UIColor colorWithWhite:0.95f alpha:1.0];
}


+ (UIColor*) egoDarkGreenColor{
    return [UIColor colorWithRed:(77.0 /255) green:(174.0f / 255) blue:(0.0f / 255) alpha:1];
}

+ (UIColor*) egoButtonDisabledColor {
    
    return [UIColor colorWithRed:0.69f green:0.82f blue:0.88f alpha:1];
}

+ (UIColor *)egoColorFromHexString:(NSString *)hexString {
    if(hexString.length == 0 || [hexString isEqualToString:@"#"]) return [UIColor clearColor];
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end


