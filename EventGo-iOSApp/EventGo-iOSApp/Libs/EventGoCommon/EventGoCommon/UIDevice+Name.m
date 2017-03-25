//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import "UIDevice+Name.h"
#import "NSCollection+JSON.h"
#import <sys/utsname.h>

//http://stackoverflow.com/questions/11197509/ios-how-to-get-device-make-and-model

@implementation UIDevice (Name)

- (NSString *)deviceName {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if (deviceModel.length == 0) {
        return @"";
    }
    NSDictionary *deviceDic = [self deviceLookup];
    return [deviceDic stringForKey:deviceModel];
}

- (NSDictionary *)deviceLookup {
    return @{
             @"i386": @"Simulator",
             @"x86_64": @"Simulator",
             @"iPod1,1": @"iPodTouch",
             @"iPod2,1": @"iPodTouch2G",
             @"iPod3,1": @"iPodTouch3G",
             @"iPod4,1": @"iPodTouch4G",
             @"iPhone1,1": @"iPhone",
             @"iPhone1,2": @"iPhone3G",
             @"iPhone2,1": @"iPhone3GS",
             @"iPhone3,1": @"iPhone4",
             @"iPhone3,3": @"iPhone4",
             @"iPhone4,1": @"iPhone4S",
             @"iPhone5,1": @"iPhone5",
             @"iPhone5,2": @"iPhone5",
             @"iPhone5,3": @"iPhone5C",
             @"iPhone5,4": @"iPhone5C",
             @"iPhone6,1": @"iPhone5S",
             @"iPhone6,2": @"iPhone5S",
             @"iPhone7,1": @"iPhone6_Plus",
             @"iPhone7,2": @"iPhone6",
             @"iPhone8,1": @"iPhone6S",
             @"iPhone8,2": @"iPhone6S_Plus",
             @"iPhone8,4": @"iPhoneSE",
             @"iPhone9,1": @"iPhone7",
             @"iPhone9,3": @"iPhone7",
             @"iPhone9,2": @"iPhone7_Plus",
             @"iPhone9,4": @"iPhone7_Plus",
             @"iPad1,1": @"iPad",
             @"iPad2,1": @"iPad2",
             @"iPad3,1": @"iPad3G",
             @"iPad3,4": @"iPad4G",
             @"iPad2,5": @"iPadMini",
             @"iPad4,1": @"iPad5G_Air",
             @"iPad4,2": @"iPad5G_Air",
             @"iPad4,4": @"iPadMini2G",
             @"iPad4,5": @"iPadMini2G",
             @"iPad4,7": @"iPadMini",
             @"iPad6,7": @"iPadPro12",
             @"iPad6,8": @"iPadPro12",
             @"iPad6,3": @"iPadPro9",
             @"iPad6,4": @"iPadPro9"
             };
}

@end

