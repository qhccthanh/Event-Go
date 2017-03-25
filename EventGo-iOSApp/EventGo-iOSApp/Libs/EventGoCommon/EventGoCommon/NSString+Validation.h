//
//  NSString+Validation.h
//  EventGoCommon
//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validation)

- (BOOL)isValidEmail;
- (BOOL)isValidPhoneNumber;
- (BOOL)isNumber;

@end
