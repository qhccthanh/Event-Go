//
//  SingletonContact.m
//  ZaloContact
//
//  Created by qhcthanh on 5/18/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

#import "CTContactManager.h"
#import "CTAddressBook.h"


@implementation CTContactManager {
    dispatch_queue_t serialQueue;
    BOOL isNotSupportiOS9;
}

+ (instancetype)sharedManager {
    static CTContactManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    self = [super init];
    serialQueue = dispatch_queue_create("LoadContact", NULL);
    isNotSupportiOS9 = SYSTEM_VERSION_LESS_THAN(@"9.0");
    return self;
}

-(void) getAllContactOfDevice:(completionLoadContactHandler)completion queue:(dispatch_queue_t)queue {
    // check queue is nil
    queue = queue != nil ? queue : dispatch_get_main_queue();
    //get contact with framework suitable
    dispatch_async(serialQueue, ^{
        if (isNotSupportiOS9) {
            [self getAllContactWithAddressBookFramework: ^(NSMutableArray* array, NSError* error){
                if (completion) {
                    dispatch_async(queue, ^{
                        completion(array,error);
                    });
                }
            }];
        } else {
            [self getAllContactWithContactsFramework: ^(NSMutableArray* array, NSError* error) {
                if (completion) {
                    dispatch_async(queue, ^{
                        completion(array,error);
                    });
                }
            }];
        }
    });
}

-(void)requestContactPermission:(requestedContactHandler)completion {
    dispatch_async(serialQueue, ^{
        __block NSError* errorContact = nil;
        if (isNotSupportiOS9) {
            ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
            // Check permission can access contact in this device
            if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
                //Request permission contact with completionBlock
                ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
                    // if allow
                    if (granted) {
                        
                    } else {
                        errorContact = [[NSError alloc] initWithDomain:@"com.ZaloContact.CTContactManager" code:kCTAuthorizationStatusDenied userInfo:nil];
                    }
                    if (completion)
                        completion(errorContact);
                });
            } // has permission
            else {
                if (completion) {
                    completion(nil);
                }
            }
        } else {
            CNContactStore* store = [[CNContactStore alloc] init];
            // Check permission can access contact in this device
            if ( [CNContactStore authorizationStatusForEntityType: CNEntityTypeContacts] ==  kABAuthorizationStatusNotDetermined) {
                //Request permission contact with completionBlock
                [store requestAccessForEntityType:CNEntityTypeContacts completionHandler: ^(BOOL granted, NSError* error) {
                    if (granted) {

                    }
                    else {
                        // do something if use don't allow permission contact
                        errorContact = [[NSError alloc] initWithDomain:@"com.ZaloContact.CTContactManager" code:kCTAuthorizationStatusDenied userInfo:nil];
                    }
                    if (completion)
                        completion(errorContact);
                }];
            } // has permission
            else {
                if (completion) {
                    completion(nil);
                }
            }
        }
    });
}

//MARK: Less than iOS 8.x use AddressBook Framework

/**
 *  Request allow access contact and get all contact with AddressBookFramework
 *
 *  @param completion call block when load contact finish
 */
-(void) getAllContactWithAddressBookFramework:(completionLoadContactHandler)completion {
    __block NSMutableArray* contactArray = nil;
    __block NSError* contactError = nil;
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    // Check permission can access contact in this device
    if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) {
        //Request permission contact with completionBlock
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            // if allow
            if (granted) {
                contactArray = [self getListPeopleInAddressBookFramework:addressBookRef];
            } else {
                // do something if use don't allow permission contact
                contactError = [[NSError alloc] initWithDomain:@"com.ZaloContact.CTContactManager" code:kCTAuthorizationStatusDenied userInfo:nil];
            }
            if (completion) {
                completion(contactArray,contactError);
            }
        });
    } // has permission
    else {
        contactArray = [self getListPeopleInAddressBookFramework:addressBookRef];
        if (completion) {
            completion(contactArray,contactError);
        }
    }
}

/**
 *  Get all people in device contact use AddressBook Framework. Notes: Can use for iOS 9 less than
 *
 *  @param addressBook reference of ABAddressBook from getallContactWithAddressBookFramework
 *
 *  @return NSMutableArray contacts
 */
-(NSMutableArray*)getListPeopleInAddressBookFramework:(ABAddressBookRef)addressBook {
    NSArray *allPeople = CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook));
    NSInteger numberOfPeople = [allPeople count];
    NSMutableArray* contactArray = [[NSMutableArray alloc] init];
    // read data foreach contact
    for (NSInteger i = 0; i < numberOfPeople; i++) {
        // Read data of person
        ABRecordRef person = (__bridge ABRecordRef)allPeople[i];
        
        NSString *firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSString *lastName  = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
        ABRecordID identifier = ABRecordGetRecordID(person);
        NSString* identified = [NSString stringWithFormat:@"%d",identifier];
        UIImage *image  = [self getImageForContactWithAddressBookFramework:person];
        
        ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
        
        NSMutableArray* phonesArray = [[NSMutableArray alloc] init];
        CFIndex numberOfPhoneNumbers = ABMultiValueGetCount(phoneNumbers);
        for (CFIndex i = 0; i < numberOfPhoneNumbers; i++) {
            NSString *phoneNumber = CFBridgingRelease(ABMultiValueCopyValueAtIndex(phoneNumbers, i));
            [phonesArray addObject:phoneNumber];
        }
        CFRelease(phoneNumbers);
        
        // Add contact to array
        CTAddressBook* contact = [[CTAddressBook alloc] initWithInfo:identified firstName:firstName lastName:lastName phones:phonesArray image:image];
        [contactArray addObject: contact];
    }
    // return contactArray when finish
    return contactArray;
}

/**
 *  Get Image Contact if exits
 *
 *  @param contactRef Ref contact to get image
 *
 *  @return UIImage if exit else return nil
 */
- (UIImage*)getImageForContactWithAddressBookFramework: (ABRecordRef)contactRef {
    NSData *imgData = nil;
    UIImage* image = nil;
    // can't get image from a ABRecordRef copy
    ABRecordID contactID = ABRecordGetRecordID(contactRef);
    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    ABRecordRef origContactRef = ABAddressBookGetPersonWithRecordID(addressBook, contactID);
    
    if (ABPersonHasImageData(origContactRef)) {
        imgData = (__bridge NSData*)ABPersonCopyImageDataWithFormat(origContactRef, kABPersonImageFormatOriginalSize);
        image = [UIImage imageWithData: imgData];
        
    }
    CFRelease(addressBook);
    // return image if exits else return nil
    return image;
}

//MARK: iOS 9.0 more than use Contacts Framework

/**
 *  Request allow access contact and get all contact with Contacts Framework
 *
 *  @param completion call block when load contact finish
 */
-(void) getAllContactWithContactsFramework:(completionLoadContactHandler)completion {
    __block NSMutableArray* contactArray = nil;
    __block NSError* contactError = nil;
    CNContactStore* store = [[CNContactStore alloc] init];
    // Check permission can access contact in this device
    if ( [CNContactStore authorizationStatusForEntityType: CNEntityTypeContacts] !=  CNAuthorizationStatusAuthorized) {
        //Request permission contact with completionBlock
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler: ^(BOOL granted, NSError* error) {
            if (granted) {
                contactArray = [self getListPeopleInContactsFramework:store];
            }
            else {
                // do something if use don't allow permission contact
                contactError = [[NSError alloc] initWithDomain:@"com.ZaloContact.CTContactManager" code:kCTAuthorizationStatusDenied userInfo:nil];
            }
            if (completion) {
                completion(contactArray,contactError);
            }
        }];
    } // has permission
    else {
        contactArray = [self getListPeopleInContactsFramework:store];
        if (completion) {
            completion(contactArray,contactError);
        }
    }
}

/**
 *  Get all people in device contact use Contact Framework. Notes: Can use for iOS 9 more than
 *
 *  @param store Ref Store of contact
 *
 *  @return NSMutableArray ContactArray when load data finish
 */
-(NSMutableArray*)getListPeopleInContactsFramework: (CNContactStore*)store {
    //keys with fetching properties
    NSError *error;
    [store containersMatchingPredicate:[CNContainer predicateForContainersWithIdentifiers: @[store.defaultContainerIdentifier]] error:&error];
    NSArray * keysToFetch = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey];
    CNContactFetchRequest * request = [[CNContactFetchRequest alloc]initWithKeysToFetch:keysToFetch];
    NSMutableArray* contactArray = [[NSMutableArray alloc] init];
    BOOL check = NO;
    
    check = [store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * __nonnull contact, BOOL * __nonnull stop){
        // doi 0.1
        NSString *phone;
        NSString *fullName;
        NSString *firstName;
        NSString *lastName;
        
        // copy data to my custom Contacts class.
        firstName = contact.givenName;
        lastName = contact.familyName;
        if (lastName == nil) {
            fullName=[NSString stringWithFormat:@"%@",firstName];
        } else if (firstName == nil){
            fullName=[NSString stringWithFormat:@"%@",lastName];
        } else {
            fullName=[NSString stringWithFormat:@"%@ %@",firstName,lastName];
        }
        
        //Add phones
        NSMutableArray* phoneArray = [[NSMutableArray alloc] init];
        for (CNLabeledValue *label in contact.phoneNumbers) {
            phone = [label.value stringValue];
            if ([phone length] > 0) {
                [phoneArray addObject:phone];
            }
        }
        UIImage* image = nil;
        image = [UIImage imageWithData:contact.imageData];
    
        
        // Add contact to contactArray
        CTAddressBook* address = [[CTAddressBook alloc] initWithInfo:contact.identifier firstName:firstName lastName:lastName phones:phoneArray image: image];
        [contactArray addObject:address];
    }];
    
    return contactArray;
}

@end
