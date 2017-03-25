//
//  ContactViewCell.m
//  ZaloContact
//
//  Created by qhcthanh on 5/18/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

#import "ContactViewCell.h"



@implementation ContactViewCell {
    
    __weak IBOutlet UIImageView *avatarImageView;
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UILabel *phoneLabel;
    __weak IBOutlet UIButton *selectButton;
    __weak IBOutlet UIButton *inviteSMSButton;
    id delegate;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    static int numberAwakeFromNib = 0;
//    numberAwakeFromNib++;
//    NSLog(@"%d",numberAwakeFromNib);
    [avatarImageView maskAvatarCircle: CGRectMake(0, 0, avatarImageView.frame.size.width, avatarImageView.frame.size.height)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)cleanUI {
    avatarImageView.image = nil;
    nameLabel.text = @"";
    phoneLabel.text = @"";
}

-(void)renderUI:(CTAddressBook *)contact {

    if (contact != nil) {
        _contact = contact;
        //Render UI
        nameLabel.text = contact.fullName;
        if (contact.phoneMutableArray.count > 0) {
            phoneLabel.text = [contact.phoneMutableArray objectAtIndex:0];
        }
        // Set image
        //avatarImageView.image = contact.mImage;
        // Set image with completionHandler
        [contact getContactImage:^(UIImage* image){
            avatarImageView.image = image;
        }];
        
        //Set Image check or uncheck
        [self changeStatus];
    }
    
}

-(void)changeStatus {
    if(!_contact.isSelected) {
        [selectButton setImage:[UIImage imageNamed:@"Circle Thin-64"]  forState:UIControlStateNormal];
    } else {
        [selectButton setImage: [UIImage imageNamed:@"Ok-52"] forState:UIControlStateNormal];
    }
}

- (void) setDelegate:(id)newDelegate{
    delegate = newDelegate;
}

- (IBAction)inviteViaSMS:(id)sender {
    if (delegate && [delegate respondsToSelector:@selector(inviteFriendViaSMS:)] ) {
        [delegate inviteFriendViaSMS:_contact];	
    }
}

@end
