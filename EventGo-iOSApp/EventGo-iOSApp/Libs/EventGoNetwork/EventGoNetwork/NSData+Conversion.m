//
//  NSData+Conversion.m
//  EventGoNetwork
//
//  Created by Quach Ha Chan Thanh on 3/19/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import "NSData+Conversion.h"

@implementation NSData (Conversion)

#pragma mark - String Conversion
- (NSString *)hexadecimalString {
    
    const unsigned char *dataBuff = (const unsigned char *)[self bytes];
    if (!dataBuff) {
        return [NSString string];
    }
    NSUInteger dataLen  = [self length];
    NSMutableString *hexString  = [NSMutableString stringWithCapacity:(dataLen * 2)];
    
    for (int i = 0; i < dataLen; i++) {
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuff[i]]];
    }
    
    return [NSString stringWithString:hexString];
}

@end
