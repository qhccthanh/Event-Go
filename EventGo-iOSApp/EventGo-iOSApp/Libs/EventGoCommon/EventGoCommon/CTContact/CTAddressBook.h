//
//  CTAddressBook.h
//  ZaloContact
//
//  Created by qhcthanh on 5/18/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "CTCacheImageManager.h"
#import "UIImageView+Mask.h"
#import "UIImage+Text.h"
#import "CTContactManager.h"


@interface CTAddressBook : NSObject {
    
}

@property NSString *identifield;
@property NSString *key;
@property NSString *firstName;
@property NSString *lastName;
@property NSString* fullName;
@property NSString* phone;
@property UIImage* image;
@property NSMutableArray* phoneMutableArray;
@property Boolean isSelected;

-(id)initWithInfo:(NSString*)identifield firstName:(NSString *)firstName lastName:(NSString *)lastName phones:(NSMutableArray *)phones image:(UIImage *)image;

/**
 *  Get first character of fullname
 *
 *  @return first character of fullname contact
 */
-(NSString*)getFirstCharacter;


/**
 *  Get image contact. Completion call when load contact finish. If contact don't have image create image with letter and random color then store image in cache with contact identifield and call thi hanlder
 *
 *  @param completion completionHandler(UIImage* image) callback when load finish image maybe nil
 */
-(void)getContactImage:(completionImageHandler)completion;
@end
