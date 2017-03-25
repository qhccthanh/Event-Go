//
//  RPFloatingPlaceholderTextView.h
//  RPFloatingPlaceholders
//
//  Created by Rob Phillips on 10/19/13.
//  Copyright (c) 2013 Rob Phillips. All rights reserved.
//
//  See LICENSE for full license agreement.
//

#import <UIKit/UIKit.h>

@protocol RPFloatingPlaceholderTextView <NSObject>
- (void)floatTextViewUpdateState;
@end


@interface RPFloatingPlaceholderTextView : UITextView
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong, readonly) UILabel *floatingLabel;
@property (nonatomic, strong) UIColor *floatingLabelActiveTextColor;
@property (nonatomic, strong) UIColor *floatingLabelInactiveTextColor;
@property (nonatomic, strong) UIColor *defaultPlaceholderColor;
@property (nonatomic, weak) id <RPFloatingPlaceholderTextView>floatingTextViewDelegate;
- (float)labelHeight;
@end
