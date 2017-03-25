//
//  ContactViewCell.h
//  ZaloContact
//
//  Created by qhcthanh on 5/18/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTAddressBook.h"

@protocol ContactCellProtocol

@required
-(void) inviteFriendViaSMS: (CTAddressBook*)contact;

@end

@interface ContactViewCell : UITableViewCell

@property CTAddressBook* contact;

/**
 *  Clean cell when re render
 */
-(void) cleanUI;

/**
 *  RenderUI with contact
 *
 *  @param contact contact want to render in cell
 */
-(void) renderUI:(CTAddressBook*)contact;

/**
 *  Set delegate in InviteFriend SMS
 *
 *  @param newDelegate delegate
 */
-(void) setDelegate:(id)newDelegate;

/**
 *  Change status select or unselect depend on contact.mSelect
 */
-(void)changeStatus;
@end
