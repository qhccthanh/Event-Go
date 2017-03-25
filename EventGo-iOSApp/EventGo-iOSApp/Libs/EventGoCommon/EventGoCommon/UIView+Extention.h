//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extention)

+ (instancetype)viewFromSameNib;

+ (instancetype)viewFromSameNib:(NSBundle *)bundle;

+ (instancetype)viewFromNibName:(NSString *)nibName bundle:(NSBundle *)bundle;

- (UIViewController*)viewController;

- (void)roundRect:(float)radius;

- (void)showShadow;

- (void)showShadow:(float)offSet color:(UIColor *)color opacity:(float)opacity;

- (void)showShadowWithOutBezierPath:(float)offSet color:(UIColor *)color opacity:(float)opacity;

- (void)roundRect:(float)radius
      borderColor:(UIColor *)color
      borderWidth:(float)borderWidth;

- (UITableView *)superTableView;

- (void)debugLayout;

@end

