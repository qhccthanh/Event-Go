//
//  CTContactViewControllerDelegate.h
//  ZaloContact
//
//  Created by Quach Ha Chan Thanh on 2/3/17.
//  Copyright © 2017 qhcthanh. All rights reserved.
//

#ifndef CTContactViewControllerDelegate_h
#define CTContactViewControllerDelegate_h

@protocol CTContactViewControllerDelegate <NSObject>

@required
- (void)ctContactDismiss:(NSMutableArray<CTAddressBook *> *)selectedArray;

@end

#endif /* CTContactViewControllerDelegate_h */
