//
//  JVFloatLabeledTextField.m
//  JVFloatLabeledTextField
//
//  The MIT License (MIT)
//
//  Copyright (c) 2013-2015 Jared Verdi
//  Original Concept by Matt D. Smith
//  http://dribbble.com/shots/1254439--GIF-Mobile-Form-Interaction?list=users
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "JVFloatLabeledTextField.h"
#import "NSString+TextDirectionality.h"
#import "UIColor+Ext.h"

static CGFloat const kJVFieldFloatingLabelFontSize = 12.0f;
static CGFloat const kFloatingLabelShowAnimationDuration = 0.1f;
static CGFloat const kFloatingLabelHideAnimationDuration = 0.1f;
NSString *kJVFieldFloatingLabelTextColor = @"#008fe5";
NSString *kJVFieldFloatingLabelTextErrorColor = @"#ED1E31";

@implementation JVFloatLabeledTextField
{
    BOOL _isFloatingLabelFontDefault;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _floatingLabel = [UILabel new];
    _floatingLabel.alpha = 0.0f;
    [self addSubview:_floatingLabel];
    // some basic default fonts/colors
    _floatingLabelFont = [UIFont systemFontOfSize:kJVFieldFloatingLabelFontSize]; //[self defaultFloatingLabelFont];
    _floatingLabel.font = _floatingLabelFont;
    _floatingLabelTextColor = [UIColor egoColorFromHexString:kJVFieldFloatingLabelTextColor];//[UIColor grayColor];
    _errorColor = [UIColor egoColorFromHexString:kJVFieldFloatingLabelTextErrorColor];
    _floatingLabel.textColor = _floatingLabelTextColor;
    _animateEvenIfNotFirstResponder = NO;
    _floatingLabelShowAnimationDuration = kFloatingLabelShowAnimationDuration;
    _floatingLabelHideAnimationDuration = kFloatingLabelHideAnimationDuration;
    [self setFloatingLabelText:self.placeholder];
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    _adjustsClearButtonRect = YES;
    _isFloatingLabelFontDefault = YES;
    _floatingLabelYPadding = 10;
    _floatingLabelActiveTextColor = [UIColor egoColorFromHexString:@"008fe5"];
}

#pragma mark -

- (UIFont *)defaultFloatingLabelFont
{
    UIFont *textFieldFont = nil;
    
    if (!textFieldFont && self.attributedPlaceholder && self.attributedPlaceholder.length > 0) {
        textFieldFont = [self.attributedPlaceholder attribute:NSFontAttributeName atIndex:0 effectiveRange:NULL];
    }
    if (!textFieldFont && self.attributedText && self.attributedText.length > 0) {
        textFieldFont = [self.attributedText attribute:NSFontAttributeName atIndex:0 effectiveRange:NULL];
    }
    if (!textFieldFont) {
        textFieldFont = self.font;
    }
    
    return [UIFont fontWithName:textFieldFont.fontName size:roundf(textFieldFont.pointSize * 0.7f)];
}

- (void)updateDefaultFloatingLabelFont
{
    UIFont *derivedFont = [self defaultFloatingLabelFont];
    
    if (_isFloatingLabelFontDefault) {
        self.floatingLabelFont = derivedFont;
    }
    else {
        // dont apply to the label, just store for future use where floatingLabelFont may be reset to nil
        _floatingLabelFont = derivedFont;
    }
}

- (UIColor *)labelActiveColor
{
    if (_floatingLabelActiveTextColor) {
        return _floatingLabelActiveTextColor;
    }
    else if ([self respondsToSelector:@selector(tintColor)]) {
        return [self performSelector:@selector(tintColor)];
    }
    return [UIColor blueColor];
}

- (void)setFloatingLabelFont:(UIFont *)floatingLabelFont
{
    if (floatingLabelFont != nil) {
        _floatingLabelFont = floatingLabelFont;
    }
    _floatingLabel.font = _floatingLabelFont ? _floatingLabelFont : [self defaultFloatingLabelFont];
    _isFloatingLabelFontDefault = floatingLabelFont == nil;
    [self setFloatingLabelText:self.placeholder];
    [self invalidateIntrinsicContentSize];
}

- (void)showFloatingLabel:(BOOL)animated
{
    void (^showBlock)() = ^{
        _floatingLabel.alpha = 1.0f;
        _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                          _floatingLabelYPadding,
                                          _floatingLabel.frame.size.width,
                                          _floatingLabel.frame.size.height);
    };
    
    if (animated || 0 != _animateEvenIfNotFirstResponder) {
        [UIView animateWithDuration:_floatingLabelShowAnimationDuration
                              delay:0.0f
                            options:UIViewAnimationOptionTransitionNone
                         animations:showBlock
                         completion:nil];
    }
    else {
        showBlock();
    }
}

- (void)hideFloatingLabel:(BOOL)animated
{
    void (^hideBlock)() = ^{
        _floatingLabel.alpha = 0.0f;
        _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                          _floatingLabel.font.lineHeight + _placeholderYPadding,
                                          _floatingLabel.frame.size.width,
                                          _floatingLabel.frame.size.height);

    };
    
    if (animated || 0 != _animateEvenIfNotFirstResponder) {
        [UIView animateWithDuration:_floatingLabelHideAnimationDuration
                              delay:0.0f
                            options:UIViewAnimationOptionTransitionNone
                         animations:hideBlock
                         completion:nil];
    }
    else {
        hideBlock();
    }
}

- (void)setLabelOriginForTextAlignment
{
    CGRect textRect = [self textRectForBounds:self.bounds];
    
    CGFloat originX = textRect.origin.x;
    
    if (self.textAlignment == NSTextAlignmentCenter) {
        originX = textRect.origin.x + (textRect.size.width/2) - (_floatingLabel.frame.size.width/2);
    }
    else if (self.textAlignment == NSTextAlignmentRight) {
        originX = textRect.origin.x + textRect.size.width - _floatingLabel.frame.size.width;
    }
    else if (self.textAlignment == NSTextAlignmentNatural) {
        JVTextDirection baseDirection = [_floatingLabel.text getBaseDirection];
        if (baseDirection == JVTextDirectionRightToLeft) {
            originX = textRect.origin.x + textRect.size.width - _floatingLabel.frame.size.width;
        }
    }
    
    _floatingLabel.frame = CGRectMake(originX + _floatingLabelXPadding,
                                      _floatingLabel.frame.origin.y,
                                      _floatingLabel.frame.size.width,
                                      _floatingLabel.frame.size.height);
}

- (void)setFloatingLabelText:(NSString *)text
{
    _floatingLabel.text = text;
    [self setNeedsLayout];
}

#pragma mark - UITextField

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self updateDefaultFloatingLabelFont];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self updateDefaultFloatingLabelFont];
}

- (CGSize)intrinsicContentSize
{
    CGSize textFieldIntrinsicContentSize = [super intrinsicContentSize];
    [_floatingLabel sizeToFit];
    return CGSizeMake(textFieldIntrinsicContentSize.width,
                      textFieldIntrinsicContentSize.height + _floatingLabelYPadding + _floatingLabel.bounds.size.height);
}

- (void)setPlaceholder:(NSString *)placeholder
{
    [super setPlaceholder:placeholder];
    [self setFloatingLabelText:placeholder];
}
- (void)setPlaceholderOnly:(NSString *)placeholder
{
    [super setPlaceholder:placeholder];
}
- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder
{
    [super setAttributedPlaceholder:attributedPlaceholder];
    [self setFloatingLabelText:attributedPlaceholder.string];
    [self updateDefaultFloatingLabelFont];
}

- (void)setPlaceholder:(NSString *)placeholder floatingTitle:(NSString *)floatingTitle
{
    [super setPlaceholder:placeholder];
    [self setFloatingLabelText:floatingTitle];
}

- (void)setFloatingTitle:(NSString *)floatingTitle {
      [self setFloatingLabelText:floatingTitle];
}


-(void)setFloatingTitleWithError:(NSString *)floatingErrorTitle{
    _floatingLabel.textColor = self.errorColor;
    _floatingLabel.text = floatingErrorTitle;
    self.isShowError = YES;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect rect = [super editingRectForBounds:bounds];
    if ([self.text length] || self.keepBaseline ) {
        CGFloat height = CGRectGetHeight(self.frame) - self.font.lineHeight;
        rect.origin.y = height/2 - self.floatingLabelYPadding;
    }
    return rect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect rect = [super editingRectForBounds:bounds];
    if ([self.text length] || self.keepBaseline) {
        CGFloat height = CGRectGetHeight(self.frame) - self.font.lineHeight;
        rect.origin.y = height/2 - self.floatingLabelYPadding;
    }
    return rect;
}

- (CGRect)insetRectForBounds:(CGRect)rect
{
    CGFloat topInset = ceilf(_floatingLabel.bounds.size.height + _placeholderYPadding);
    topInset = MIN(topInset, [self maxTopInset]);
    return CGRectMake(rect.origin.x, rect.origin.y + topInset / 2.0f, rect.size.width, rect.size.height);
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    CGRect rect = [super clearButtonRectForBounds:bounds];
    if (0 != self.adjustsClearButtonRect
    	&& _floatingLabel.text.length // for when there is no floating title label text
	) {
        if ([self.text length] || self.keepBaseline) {
            CGFloat topInset = ceilf(_floatingLabel.font.lineHeight + _placeholderYPadding);
            topInset = MIN(topInset, [self maxTopInset]);
            rect = CGRectMake(rect.origin.x, rect.origin.y + topInset / 2.0f, rect.size.width, rect.size.height);
        }
    }
    return CGRectIntegral(rect);
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect rect = [super leftViewRectForBounds:bounds];
    
    CGFloat topInset = ceilf(_floatingLabel.font.lineHeight + _placeholderYPadding);
    topInset = MIN(topInset, [self maxTopInset]);
    rect = CGRectOffset(rect, 0, topInset / 2.0f);
    
    return rect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    
    CGRect rect = [super rightViewRectForBounds:bounds];
    
    CGFloat topInset = ceilf(_floatingLabel.font.lineHeight + _placeholderYPadding);
    topInset = MIN(topInset, [self maxTopInset]);
    rect = CGRectOffset(rect, 0, topInset / 2.0f);
    rect.origin.x -= 0;
    rect.origin.y -= 5;
    return rect;
}

- (CGFloat)maxTopInset
{
    return MAX(0, floorf(self.bounds.size.height - self.font.lineHeight));
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    [self setNeedsLayout];
}

- (void)setAlwaysShowFloatingLabel:(BOOL)alwaysShowFloatingLabel
{
    _alwaysShowFloatingLabel = alwaysShowFloatingLabel;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setLabelOriginForTextAlignment];
    CGSize floatingLabelSize = [_floatingLabel sizeThatFits:_floatingLabel.superview.bounds.size];
    
    _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                      _floatingLabel.frame.origin.y,
                                      floatingLabelSize.width,
                                      floatingLabelSize.height);
    BOOL firstResponder = self.isFirstResponder;
    if (!self.isShowError){
        _floatingLabel.textColor = (firstResponder && self.text && self.text.length > 0 ?
                                self.labelActiveColor : self.floatingLabelTextColor);
        if(self.isAlwayActiveTextColorFloating){
            _floatingLabel.textColor = self.labelActiveColor;
            //self.placeholder = @"";
        }
    }
    if ((!self.text || 0 == [self.text length]) && !self.alwaysShowFloatingLabel) {
        [self hideFloatingLabel:firstResponder];
    }
    else {
     [self showFloatingLabel:firstResponder];
    }
    
    //Image Tail
    if(_imageViewTail)
        [_imageViewTail removeFromSuperview];
    if(self.isShowError && self.isShowTailImage){
        if(!_imageViewTail){
            self.imageViewTail = [[UIImageView alloc] init];
            self.imageViewTail.contentMode = UIViewContentModeScaleToFill;
            CGRect rect = CGRectMake(_floatingLabel.frame.size.width + 3 , 0, 15, 15);
            self.imageViewTail.image = self.imageTail;
            self.imageViewTail.frame = rect;
            //self.imageViewTail.tintColor = [UIColor redColor];
            //self.imageViewTail.backgroundColor = [UIColor redColor];
            
            UIImage *newImage = [self.imageViewTail.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            UIGraphicsBeginImageContextWithOptions(self.imageTail.size, NO, newImage.scale);
            [[UIColor redColor] set];
            [newImage drawInRect:CGRectMake(0, 0, self.imageTail.size.width, newImage.size.height)];
            newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            self.imageViewTail.image = newImage;
        }

        
        [_floatingLabel addSubview:self.imageViewTail];
        
    }
    
    
    [self initLines];
    
}
#pragma mark Add Error with image
- (void)setFloatingTitleErrorWithImage:(NSString*)Title andImage:(UIImage*)image{
    
    _floatingLabel.text = Title;
    _floatingLabel.textColor = self.errorColor;
    self.isShowError = YES;
    self.imageTail = image;
    self.isShowTailImage = true;
    [self setNeedsLayout];
    
}
-(void)initLines{
    
    CGFloat width = self.superview.frame.size.width;
    
    if(!self.lineTop && self.isShowTopBottomLine){
        self.lineTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1)];
        self.lineTop.backgroundColor = [UIColor egoColorFromHexString:@"#E3E6E7"];
        
        self.lineBottom = [[UIView alloc] initWithFrame:CGRectMake(0,self.superview.frame.size.height-1, width,  1)];
        //self.lineBottom.backgroundColor = TEXTFIELD_SUCCESS_COLOR;
        
        [self.superview addSubview:self.lineBottom];
        [self.superview addSubview:self.lineTop];
        
    }
    
    if(self.isBGBottomLineDefault){
        self.lineBottom.backgroundColor = [UIColor egoColorFromHexString:@"#E3E6E7"];
    }
    else {
        if(self.lineBottom)
            self.lineBottom.backgroundColor = self.floatingLabel.textColor;
    }
   
    
    if(!self.viewTapOnFloatingLabel && self.isShowTailImage ){
        
        CGRect rectViewTap = self.floatingLabel.frame;
        rectViewTap.origin.x += 10;
        rectViewTap.origin.y -= 10;
        rectViewTap.size.height += 10;
        rectViewTap.size.width += self.imageViewTail.frame.size.width + 10;
        self.viewTapOnFloatingLabel = [[UIView alloc] initWithFrame:rectViewTap];
        self.viewTapOnFloatingLabel.backgroundColor = [UIColor clearColor];
        [self.superview addSubview:self.viewTapOnFloatingLabel];
    }
//    if(self.isShowTailImage == false){
//        [self.viewTapOnFloatingLabel removeFromSuperview];
//    }
}
@end
