//
//  ContactSelectViewCell.m
//  ZaloContact
//
//  Created by qhcthanh on 5/19/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

#import "ContactSelectViewCell.h"

@implementation ContactSelectViewCell {
    __weak IBOutlet UIImageView *contactImageView;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [contactImageView maskAvatarCircle: CGRectMake(0, 0, 38, 38)];
}

-(void)cleanUI {
    contactImageView.image = [UIImage imageNamed:@"user non avatar"];
}

/**
 *  Render UI with model CTAddressBook
 *
 *  @param contact Model to render
 */
-(void)renderUI:(CTAddressBook*)contact {
    if (contact) {
        // Set image with completionHandler
        [contact getContactImage:^(UIImage* image){
            contactImageView.image = image;
        }];
        //contactImageView.image = contact.mImage;
    }
}

@end
