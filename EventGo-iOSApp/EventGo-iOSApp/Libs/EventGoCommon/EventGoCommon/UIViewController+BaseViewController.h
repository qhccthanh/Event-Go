//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BaseViewController)

- (void)baseViewControllerViewDidLoad;

- (NSArray *)leftBarButtonItems;

- (void)backButtonClicked:(id)sender;

- (void)viewWillPopout;

- (NSString *)screenName;

@end
