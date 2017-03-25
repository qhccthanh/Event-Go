//
//  NSString+Validation.m
//  EventGoCommon
//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import "NSString+Validation.h"
#import "NBPhoneNumberUtil.h"

@implementation NSString(Validation)
- (BOOL)isValidEmail
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidPhoneNumber {
    NBPhoneNumberUtil *phoneUtil = [[NBPhoneNumberUtil alloc] init];
    NSError *error = nil;
    NBPhoneNumber *phoneNumber_ = [phoneUtil parse:self
                                     defaultRegion:@"VN"
                                             error:&error];
    if (!error) {
        return [phoneUtil isValidNumber:phoneNumber_];
    }
    return NO;
}

- (BOOL)isNumber {
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:self];
    
    return [alphaNums isSupersetOfSet:inStringSet];
}
@end
