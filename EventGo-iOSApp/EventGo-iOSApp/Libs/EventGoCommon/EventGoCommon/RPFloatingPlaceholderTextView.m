//
//  RPFloatingPlaceholderTextView.m
//  RPFloatingPlaceholders
//
//  Created by Rob Phillips on 10/19/13.
//  Copyright (c) 2013 Rob Phillips. All rights reserved.
//
//  See LICENSE for full license agreement.
//

#import "RPFloatingPlaceholderTextView.h"
#import "UIFont+Extension.h"

@interface RPFloatingPlaceholderTextView ()
@property (nonatomic, assign) BOOL shouldDrawPlaceholder;
@property (nonatomic, strong, readwrite) UILabel *floatingLabel;
@end

@implementation RPFloatingPlaceholderTextView

- (float)labelHeight {
    return 25.0;
}

#pragma mark - Programmatic Initializer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViewDefaults];
        [self setupDefaultColorStates];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        [self setupViewDefaults];
        [self setupDefaultColorStates];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupViewDefaults];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupDefaultColorStates];
    self.placeholder = self.placeholder;
    self.text = self.text;
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

#pragma mark - Dealloc

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Setters & Getters

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textViewTextDidChange:nil];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment: textAlignment];
    self.floatingLabel.textAlignment = textAlignment;
}

- (void)setPlaceholder:(NSString *)aPlaceholder {
    if ([_placeholder isEqualToString:aPlaceholder]) return;
    _placeholder = aPlaceholder;
    self.floatingLabel.text = _placeholder;
    [self.floatingLabel sizeToFit];
    self.floatingLabel.frame = CGRectMake(self.frame.origin.x + 5.0,
                                          self.frame.origin.y,
                                          self.frame.size.width,
                                          self.floatingLabel.frame.size.height);
}

- (BOOL)hasText {
    return self.text.length != 0;
}

#pragma mark - View Defaults

- (void)setupViewDefaults {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidBeginEditing:)
                                                 name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:)
                                                 name:UITextViewTextDidEndEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:)
                                                 name:UITextViewTextDidChangeNotification object:self];
    
    self.contentMode = UIViewContentModeRedraw;
    self.floatingLabel = [[UILabel alloc] init];
    self.floatingLabel.font = [UIFont SFUITextRegularWithSize:12];
    self.floatingLabel.textAlignment = self.textAlignment;
    self.floatingLabel.backgroundColor = [UIColor clearColor];
    self.floatingLabel.alpha = 0.f;
}

- (void)setupDefaultColorStates {
    
    UIColor *defaultActiveColor;
    if ([self respondsToSelector:@selector(tintColor)]) {
        defaultActiveColor = self.tintColor ?: [[[UIApplication sharedApplication] delegate] window].tintColor;
    } else {
        defaultActiveColor = [UIColor blueColor];
    }
    
    self.floatingLabelActiveTextColor = self.floatingLabelActiveTextColor ?: defaultActiveColor;
    self.floatingLabelInactiveTextColor = self.floatingLabelInactiveTextColor ?: [UIColor colorWithWhite:0.7f alpha:1.f];
    self.floatingLabel.textColor = self.floatingLabelActiveTextColor;
}

#pragma mark - Drawing & Animations

- (void)layoutSubviews {
    [super layoutSubviews];
    if (![self isFirstResponder]) {
        [self checkForExistingText];
    }
}

- (void)drawRect:(CGRect)aRect {
    [super drawRect:aRect];
    if (self.shouldDrawPlaceholder) {
        UIColor *placeholderGray = self.defaultPlaceholderColor ?: [UIColor colorWithRed:199/255.f green:199/255.f blue:205/255.f alpha:1.f];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setAlignment: self.textAlignment];
        
        NSDictionary *placeholderAttributes = @{NSFontAttributeName : self.font,
                                                NSForegroundColorAttributeName : placeholderGray,
                                                NSParagraphStyleAttributeName : paragraphStyle};
        
        if ([self respondsToSelector:@selector(tintColor)]) {
            // Inset the placeholder by the same 5px on both sides so that it works in right-to-left languages too
            CGRect placeholderFrame = CGRectMake(5.f, 6.f, self.frame.size.width - 10.f, self.frame.size.height - 20.f);
            [self.placeholder drawInRect:placeholderFrame
                          withAttributes:placeholderAttributes];
            
        } else {
            CGRect placeholderFrame = CGRectMake(8.f, 8.f, self.frame.size.width - 10.f, self.frame.size.height - 20.f);
            NSAttributedString *attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder
                                                                                        attributes:placeholderAttributes];
            [attributedPlaceholder drawInRect:placeholderFrame];
        }
    }
}

- (void)didMoveToSuperview {
    if (self.floatingLabel.superview != self.superview) {
        if (self.superview && self.hasText) {
            [self.superview addSubview:self.floatingLabel];
        } else {
            [self.floatingLabel removeFromSuperview];
        }
    }
}

- (void)showFloatingLabelWithAnimation:(BOOL)isAnimated {
    if (self.floatingLabel.superview != self.superview) {
        [self.superview addSubview:self.floatingLabel];
    }
    [self setNeedsDisplay];
    CGRect frame = CGRectMake(self.frame.origin.x  + 5.0,
                              self.frame.origin.y - ceil(self.floatingLabel.font.lineHeight),
                              self.frame.size.width,
                              self.floatingLabel.frame.size.height);
    
    if (isAnimated) {
        UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut;
        [UIView animateWithDuration:0.2f delay:0.f options:options animations:^{
            self.floatingLabel.alpha = 1.f;
            self.floatingLabel.frame = frame;
            
        } completion:nil];
    } else {
        self.floatingLabel.alpha = 1.f;
        self.floatingLabel.frame = frame;
    }
}

- (void)hideFloatingLabel {
    UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseIn;
    [UIView animateWithDuration:0.2f delay:0.f options:options animations:^{
        self.floatingLabel.alpha = 0.f;
        self.floatingLabel.frame = CGRectMake(self.frame.origin.x  + 5.0,
                                              self.frame.origin.y,
                                              self.frame.size.width,
                                              self.floatingLabel.frame.size.height);
    } completion:^(BOOL finished) {
        [self setNeedsDisplay];
    }];
}

- (void)checkForExistingText{
    self.shouldDrawPlaceholder = !self.hasText;
    if (self.hasText) {
        self.floatingLabel.textColor = self.floatingLabelInactiveTextColor;
        [self.floatingTextViewDelegate floatTextViewUpdateState];
        [self showFloatingLabelWithAnimation:NO];
    }
}


- (void)animateFloatingLabelColorChangeWithAnimationBlock:(void (^)(void))animationBlock {
    UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionTransitionCrossDissolve;
    [UIView transitionWithView:self.floatingLabel duration:0.25 options:options animations:^{
        animationBlock();
    } completion:nil];
}

#pragma mark - Text View Observers

- (void)textViewDidBeginEditing:(NSNotification *)notification {
    __weak __typeof(self) weakSelf = self;
    [self animateFloatingLabelColorChangeWithAnimationBlock:^{
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        self.floatingLabel.textColor = strongSelf.floatingLabelActiveTextColor;
        [self.floatingTextViewDelegate floatTextViewUpdateState];
    }];
}

- (void)textViewDidEndEditing:(NSNotification *)notification {
    __weak __typeof(self) weakSelf = self;
    [self animateFloatingLabelColorChangeWithAnimationBlock:^{
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        self.floatingLabel.textColor = strongSelf.floatingLabelInactiveTextColor;
        [self.floatingTextViewDelegate floatTextViewUpdateState];
    }];
}

- (void)textViewTextDidChange:(NSNotification *)notification {
    BOOL previousShouldDrawPlaceholderValue = self.shouldDrawPlaceholder;
    self.shouldDrawPlaceholder = !self.hasText;
    [self.floatingTextViewDelegate floatTextViewUpdateState];
    
    if (previousShouldDrawPlaceholderValue != self.shouldDrawPlaceholder) {
        if (self.shouldDrawPlaceholder) {
            [self hideFloatingLabel];
        } else {
            [self showFloatingLabelWithAnimation:YES];
        }
    }
}

@end
