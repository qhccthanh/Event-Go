
//
//  ViewController.h
//  ZaloContact
//
//  Created by qhcthanh on 5/18/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactViewCell.h"
#import <MessageUI/MessageUI.h>
#import "CTContactManager.h"
#import "ContactSelectViewCell.h"
#import "CTContactViewControllerDelegate.h"


@interface CTContactViewController :  UIViewController <UITableViewDelegate, UITableViewDataSource, ContactCellProtocol,MFMessageComposeViewControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UISearchControllerDelegate>

@property (strong, nonatomic) UISearchController *searchController;
@property (weak, nonatomic) id<CTContactViewControllerDelegate> delegate;

+ (instancetype)shared;

@end

