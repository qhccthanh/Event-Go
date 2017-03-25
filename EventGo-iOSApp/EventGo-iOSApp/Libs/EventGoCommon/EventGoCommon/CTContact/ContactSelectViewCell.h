//
//  ContactSelectViewCell.h
//  ZaloContact
//
//  Created by qhcthanh on 5/19/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTAddressBook.h"

@interface ContactSelectViewCell : UICollectionViewCell

/**
 *  Clean cell when re render
 */
-(void)cleanUI;

/**
 *  Render cell with contact. Get image contact to avatarImageView, Get full name contact to nameLabel
 *
 *  @param contact will render in cell
 */
-(void)renderUI:(CTAddressBook*)contact;
@end
