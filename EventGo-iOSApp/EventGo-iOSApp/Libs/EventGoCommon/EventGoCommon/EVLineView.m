//
//  Created by Quach Ha Chan Thanh on 3/18/17.
//  Copyright © 2017 Quach Ha Chan Thanh. All rights reserved.
//

#import "EVLineView.h"
#import "UIView+Extention.m"
#import "UIColor+Ext.h"
#import "Masonry.h"

@implementation EVLineView
- (instancetype)init {
    self = [super init];
    self.backgroundColor = [UIColor lineColor];
    return self;
}

- (void)alignToTop {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@1);
    }];
}

- (void)alignToBottom {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@1);
    }];
}

- (void)alignToLeft {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.width.equalTo(@1);
    }];
}

- (void)alignToRight {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.right.equalTo(@0);
        make.width.equalTo(@1);
    }];
}

- (void)alignToBottomWithLeftMargin:(int)margin {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.equalTo(@(margin));
        make.right.equalTo(@0);
        make.height.equalTo(@1);
    }];
}
@end
