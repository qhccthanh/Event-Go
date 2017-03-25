//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import "UIView+Extention.h"
#import "UIColor+Ext.h"

@implementation UIView (Extention)

+ (instancetype)viewFromSameNib {
    return [self viewFromSameNib:nil];
}

+ (instancetype)viewFromSameNib:(NSBundle *)bundle {
    return [self viewFromNibName:NSStringFromClass([self class]) bundle:bundle];
}

+ (instancetype)viewFromNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
    if (bundle == nil) {
        bundle = [NSBundle mainBundle];
    }
    
    NSArray *topLevelObjects = [bundle loadNibNamed:nibName owner:nil options:nil];
    for (id currentObject in topLevelObjects) {
        if ([currentObject isKindOfClass:[self class]]) {
            return currentObject;
        }
    }
    
    return nil;
}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
- (UITableView *)superTableView {
    for (UIView* next = [self superview]; next; next = next.superview) {
        if ([next isKindOfClass:[UITableView class]]) {
            return (UITableView *)next;
        }
    }
    return nil;
}

- (void)roundRect:(float)radius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

- (void)showShadow {
    [self showShadowWithOutBezierPath:5.0 color:[UIColor blackColor] opacity:0.5];
}

- (void)showShadow:(float)offSet color:(UIColor *)color opacity:(float)opacity {
    UIView *view = self;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:view.bounds];
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOffset = CGSizeMake(0.0f, offSet);
    view.layer.shadowOpacity = opacity;
    view.layer.shadowPath = shadowPath.CGPath;
}

- (void)showShadowWithOutBezierPath:(float)offSet color:(UIColor *)color opacity:(float)opacity {
    UIView *view = self;
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOffset = CGSizeMake(0.0f, offSet);
    view.layer.shadowOpacity = opacity;
}

- (void)roundRect:(float)radius
      borderColor:(UIColor *)color
      borderWidth:(float)borderWidth {
    [self roundRect:radius];
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = borderWidth;
}

- (void)debugLayout {
    for (UIView *view in self.subviews) {
        view.backgroundColor = [UIColor randomColor];
    }
}
@end





