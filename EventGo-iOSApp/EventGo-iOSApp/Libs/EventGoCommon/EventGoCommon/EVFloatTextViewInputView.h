//
//  ZPFloatTextViewInputView.h
//  ZaloPayCommon
//
//  Created by bonnpv on 1/5/17.
//  Copyright © 2017 VNG Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPFloatingPlaceholderTextView.h"

@interface EVFloatTextViewInputView : UIView

@property (nonatomic, strong) RPFloatingPlaceholderTextView *textField;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *highlightColor;
@property (nonatomic, strong) UIColor *errorColor;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, assign) UIEdgeInsets lineInsets;
@property (nonatomic, assign) UIEdgeInsets textFieldInsets;

- (void)showErrorAuto:(NSString *)errorText;
- (void)showErrorWithText:(NSString *)errorText;
- (void)clearErrorText;
@end

