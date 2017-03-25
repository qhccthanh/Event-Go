//
//  ZPFloatTextViewInputView.m
//  ZaloPayCommon
//
//  Created by bonnpv on 1/5/17.
//  Copyright © 2017 VNG Corporation. All rights reserved.
//

#import "EVFloatTextViewInputView.h"
#import "Masonry.h"
#import "UIColor+Ext.h"
#import "UIFont+Extension.h"

@interface EVFloatTextViewInputView()<RPFloatingPlaceholderTextView>

@property (nonatomic) BOOL isShowError;
@property (nonatomic, strong) NSString * errorMessage;

@end

@implementation EVFloatTextViewInputView

- (id)init {
    self = [super init];
    if (self) {
        self.textField = [[RPFloatingPlaceholderTextView alloc] init];
        self.textField.floatingTextViewDelegate = self;
        [self addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@5);
            make.right.equalTo(@0);
            make.top.equalTo(@([self.textField labelHeight]));
            make.bottom.equalTo(@(-5));
        }];
        self.textField.backgroundColor = [UIColor clearColor];
        self.lineView = [[UIView alloc] init];
        [self addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(@1);
            make.bottom.equalTo(self.mas_bottom);
        }];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.lineView);
        }];
        
        self.normalColor = [UIColor placeHolderColor];
        self.highlightColor = [UIColor egoBaseColor];
        self.errorColor = [UIColor errorColor];
        
        self.backgroundColor = [UIColor clearColor];
        
        [self.textField setFont:[UIFont SFUITextRegularWithSize:16]];
        self.textField.floatingLabel.font = [UIFont SFUITextRegularWithSize:12];
        
        self.isShowError = false;
    }
    return self;
}

- (void)setLineInsets:(UIEdgeInsets)lineInsets {
    _lineInsets = lineInsets;
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(self.lineInsets.left));
        make.right.equalTo(@(-self.lineInsets.right));
    }];
}

- (void)floatTextViewUpdateState {
    if (self.isShowError) {
        self.textField.floatingLabel.textColor = [UIColor errorColor];
        self.lineView.backgroundColor = [UIColor errorColor];
        self.textField.floatingLabel.text = self.errorMessage;
        return;
    }
    
    self.textField.floatingLabel.text = self.textField.placeholder;
    
    if (self.textField.isFirstResponder) {
        self.lineView.backgroundColor = self.highlightColor;
        self.textField.floatingLabelActiveTextColor = self.highlightColor;
        self.textField.floatingLabel.textColor = self.highlightColor;
    } else {
        self.lineView.backgroundColor = [UIColor lineColor];
        self.textField.floatingLabelActiveTextColor = self.normalColor;
        self.textField.floatingLabel.textColor = self.normalColor;
    }
    
    
    CGRect floatRect = self.textField.floatingLabel.frame;
    floatRect.size.width = CGRectGetWidth(self.frame) - 10;
    self.textField.floatingLabel.frame = floatRect;
}

- (void)showErrorWithText:(NSString *)errorText {
    self.isShowError = true;
    self.errorMessage = errorText;
    self.textField.floatingLabel.text = errorText;
    self.textField.floatingLabel.textColor = [UIColor errorColor];
    //    [self.textField showFloatingLabel:YES];
    [self.textField setNeedsLayout];
    [self.textField layoutIfNeeded];
}

- (void)clearErrorText {
    if (self.isShowError) {
        self.textField.floatingLabel.textColor = [UIColor placeHolderColor];
        self.textField.floatingLabel.text = self.textField.placeholder;
        self.isShowError = false;
    }
}
- (void)showErrorAuto:(NSString *)errorText {
    self.lineView.backgroundColor = self.errorColor;
    self.textField.floatingLabel.textColor = self.errorColor;
    self.textField.floatingLabel.text = errorText;
}

- (void)setTextFieldInsets:(UIEdgeInsets)textFieldInsets {
    _textFieldInsets = textFieldInsets;
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(textFieldInsets.left));
        make.right.equalTo(@(-textFieldInsets.right));
    }];
}



@end
