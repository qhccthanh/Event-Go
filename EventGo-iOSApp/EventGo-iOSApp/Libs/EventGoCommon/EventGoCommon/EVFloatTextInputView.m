//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import "EVFloatTextInputView.h"
#import "Masonry.h"
#import "UIColor+Ext.h"
#import "UIFont+Extension.h"
#import "JVFloatLabeledTextField.h"

@interface JVFloatLabeledTextField()

- (void)hideFloatingLabel:(BOOL)animated;

- (void)showFloatingLabel:(BOOL)animated;

@end

@class ZPFloatTextField;

@protocol ZPFloatTextInputDelegate <NSObject>

- (void)floatLabeledTextLayoutSubviews;
@end

@interface ZPFloatTextField : JVFloatLabeledTextField

@property (nonatomic, assign) id <ZPFloatTextInputDelegate> floatLabelDelegate;

@property (nonatomic) BOOL isShowError;

@end

@implementation ZPFloatTextField
@dynamic delegate;
@dynamic isShowError;

- (void)layoutSubviews {
    [super layoutSubviews];
    if ([self.floatLabelDelegate respondsToSelector:@selector(floatLabeledTextLayoutSubviews)]) {
        [self.floatLabelDelegate floatLabeledTextLayoutSubviews];
    }
}
- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect rect = [super editingRectForBounds:bounds];
    if ([self.text length] || self.keepBaseline || self.isShowError) {
        CGFloat height = CGRectGetHeight(self.frame) - self.font.lineHeight;
        rect.origin.y = height/2 - self.floatingLabelYPadding;
    }
    return rect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect rect = [super editingRectForBounds:bounds];
    if ([self.text length] || self.keepBaseline || self.isShowError) {
        CGFloat height = CGRectGetHeight(self.frame) - self.font.lineHeight;
        rect.origin.y = height/2 - self.floatingLabelYPadding;
    }
    return rect;
}
- (void)hideFloatingLabel:(BOOL)animated {
    if (self.isShowError) {
        return;
    }
    if ([[super class] instancesRespondToSelector:@selector(hideFloatingLabel:)]) {
        [super hideFloatingLabel:animated];
    }
#pragma clang diagnostic pop
}
- (void)showFloatingLabel:(BOOL)animated {
    if ([[super class] instancesRespondToSelector:@selector(showFloatingLabel:)]) {
        [super showFloatingLabel:animated];
    }
}

@end

@interface ZPFloatTextInputView()<ZPFloatTextInputDelegate>
@property (nonatomic) BOOL isShowError;
@property (nonatomic, strong) NSString * errorMessage;
@end
@implementation ZPFloatTextInputView

- (id)init {
    self = [super init];
    if (self) {
        self.textField = [[ZPFloatTextField alloc] init];
        ((ZPFloatTextField *)self.textField).floatLabelDelegate = self;
        [self addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.right.equalTo(@0);
            make.height.equalTo(@60);
            make.top.equalTo(@0);
        }];
        
        self.textField.backgroundColor = [UIColor clearColor];
        self.lineView = [[UIView alloc] init];
        [self addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(@1);
            make.top.equalTo(self.textField.mas_bottom);
        }];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.lineView);
        }];
        
        self.normalColor = [UIColor placeHolderColor];
        self.highlightColor = [UIColor egoBaseColor];
        self.errorColor = [UIColor errorColor];
        
        self.backgroundColor = [UIColor clearColor];
        
        [self.textField setFont:[UIFont SFUITextRegularWithSize:16]];
        self.textField.floatingLabelFont = [UIFont SFUITextRegularWithSize:12];
        
        self.textField.keepBaseline = NO;
        self.isShowError = false;
        self.textField.floatingLabelYPadding = 10;
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

- (void)floatLabeledTextLayoutSubviews {
    if (self.isShowError) {
        self.textField.floatingLabel.textColor = [UIColor errorColor];
        self.lineView.backgroundColor = [UIColor errorColor];
        self.textField.floatingLabel.text = self.errorMessage;
    } else {
        self.textField.floatingLabel.text = self.textField.placeholder;
        
        if (self.textField.isFirstResponder) {
            self.lineView.backgroundColor = self.highlightColor;
            self.textField.floatingLabelTextColor = self.highlightColor;
            self.textField.floatingLabel.textColor = self.highlightColor;
        } else {
            self.lineView.backgroundColor = [UIColor lineColor];
            self.textField.floatingLabelTextColor = self.normalColor;
            self.textField.floatingLabel.textColor = self.normalColor;
        }
    }
    
    CGRect floatRect = self.textField.floatingLabel.frame;
    floatRect.size.width = CGRectGetWidth(self.frame) - 10;
    self.textField.floatingLabel.frame = floatRect;
}

- (void)setIsShowError:(BOOL)isShowError {
    ((ZPFloatTextField *)self.textField).isShowError = isShowError;
    _isShowError = isShowError;
}

- (void)showErrorWithText:(NSString *)errorText {
    self.isShowError = true;
    self.errorMessage = errorText;
    self.textField.floatingLabel.text = errorText;
    self.textField.floatingLabel.textColor = [UIColor errorColor];
    [self.textField showFloatingLabel:YES];
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
    [self.textField showFloatingLabel:YES];
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
