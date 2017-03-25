//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import "UIViewController+BaseViewController.h"

#import "UIColor+Ext.h"
#import "UIImage+Extention.h"

@interface UIFont (IconFont)
    + (UIFont *)iconFontWithSize:(CGFloat)size;
@end

@interface UIButton (IconFont)
    - (void)setIconFont:(NSString *)iconName forState:(UIControlState)state;
@end


@implementation UIViewController (BaseViewController)

- (void)baseViewControllerViewDidLoad {
    
    self.view.backgroundColor = [UIColor defaultBackground];
    [self setUpUiBar];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.navigationController.navigationBar.translucent = NO;

    UIImageView *imageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    imageView.hidden = YES;
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    // Tracking heare
}
- (NSString *)screenName {
    
    return NSStringFromClass([self class]);
}

- (void)setUpUiBar {
    
    self.navigationController.navigationBarHidden = NO;
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationItem.leftBarButtonItems = [self leftBarButtonItems];
    }
}

- (NSArray *)leftBarButtonItems {
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setIconFont:@"general_backios" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont iconFontWithSize:20];
    
    backButton.frame = CGRectMake(0, 0, 44, 44);    
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIBarButtonItem *negativeSeparator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeparator.width = -16;
    return  @[negativeSeparator, backBarButtonItem];
}

- (void)backButtonClicked:(id)sender {
    
    [self viewWillPopout];
    if (self.navigationController.viewControllers.count == 1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


#pragma mark - Menu Delegate

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu {
    return FALSE;
}

- (void)viewWillPopout {
    
}

@end
