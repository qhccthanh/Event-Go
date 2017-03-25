//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"

@interface ZPFloatTextInputView : UIView
@property (nonatomic, strong) JVFloatLabeledTextField *textField;

@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *highlightColor;
@property (nonatomic, strong) UIColor *errorColor;
//@property (nonatomic, assign) UIEdgeInsets lineInsets;
//@property (nonatomic, assign) UIEdgeInsets textInsets;
//@property (nonatomic, assign) UIEdgeInsets textFieldInsets;

- (void)showErrorAuto:(NSString *)errorText;
- (void)showErrorWithText:(NSString *)errorText;
- (void)clearErrorText;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, assign) UIEdgeInsets lineInsets;
@property (nonatomic, assign) UIEdgeInsets textFieldInsets;

@end
