//
//  ViewController.m
//  ZaloContact
//
//  Created by qhcthanh on 5/18/16.
//  Copyright © 2016 qhcthanh. All rights reserved.
//

#import "CTContactViewController.h"


@interface CTContactViewController () {
    //private property
    NSMutableDictionary* contactDictionary;
    NSMutableArray* searchArray;
    NSMutableArray* contactKeyArray;
    NSMutableArray* selectContactArray;
    NSMutableArray* contactNoFilterArray;
    UILabel* numberOfContactTableViewLabel;
    
    //private UI
    __weak IBOutlet UITableView *contactTableView;
    __weak IBOutlet UIActivityIndicatorView *loadContactIndicator;
    __weak IBOutlet UICollectionView *selectContactCollectionView;
    __weak IBOutlet UIView *contentView;
    
    UIBarButtonItem* leftBarButton;
    UIBarButtonItem* rightBarButton;
    UIView* titleBarView;
}
// scroll performance
@property (nonatomic, strong) CADisplayLink* displayLink;
@property (nonatomic, assign) NSInteger framesInLastInterval;
@property (nonatomic, assign) CFAbsoluteTime lastLogTime;
@property (nonatomic, assign) NSInteger totalFrames;
@property (nonatomic, assign) NSTimeInterval scrollingTime;
@property (nonatomic, assign) CGFloat averageFPS;
@end

@implementation CTContactViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    //Addobserver
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addContact:) name:@"CREATECONTACT" object:nil];
    
    //Save bar item
    leftBarButton = self.navigationItem.leftBarButtonItem;
    rightBarButton = self.navigationItem.rightBarButtonItem;
    titleBarView = self.navigationItem.titleView;
    // init property
    contactDictionary = [[NSMutableDictionary alloc] init];
    searchArray = [[NSMutableArray alloc] init];
    contactKeyArray = [[NSMutableArray alloc] init];
    selectContactArray = [[NSMutableArray alloc] init];
    contactNoFilterArray = [[NSMutableArray alloc] init];
    //Configure Indicator
    [loadContactIndicator stopAnimating];
    loadContactIndicator.hidden = true;
    
    //Configure SearchController
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.placeholder = @"Nhâp tên để tìm kiếm";
    self.searchController.searchBar.alpha = 0.4;
    self.searchController.delegate = self;
    self.definesPresentationContext = YES;
    self->contactTableView.estimatedRowHeight = 30.0;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    [self.searchController.searchBar setFrame:CGRectMake(0, 0, [self.view frame].size.width, 44)];
    
    //set footer
    numberOfContactTableViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 30 + 20)];

    numberOfContactTableViewLabel.text = @"";
    [numberOfContactTableViewLabel setFont: [UIFont fontWithName:@"Arial" size:20]];
    numberOfContactTableViewLabel.textColor = [UIColor blackColor];
    numberOfContactTableViewLabel.textAlignment = NSTextAlignmentCenter;
    contactTableView.tableFooterView = numberOfContactTableViewLabel;
    self.searchController.active = false;
    // Add layout
    [contactTableView removeFromSuperview];
    [contentView setFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [contentView addSubview:self.searchController.searchBar];
    //
    [contactTableView setFrame:CGRectMake(0, 44, self.view.frame.size.width, contentView.frame.size.height - 44)];
    [contentView addSubview:contactTableView];
    

    [self syncContactAction:nil];
}

-(void)dealloc {
    [_displayLink invalidate];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (_delegate) {
        [_delegate ctContactDismiss:[selectContactArray copy]];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIButton Action
- (IBAction)syncContactAction:(id)sender {
    //
    self.searchController.active = false;
    //Reload Data
    [selectContactArray removeAllObjects];
    //Reload UI
    [selectContactCollectionView reloadData];
    [loadContactIndicator startAnimating];
    loadContactIndicator.hidden = false;
    [self renderTableViewHasDataSelect];
    
    [[CTContactManager sharedManager] getAllContactOfDevice:^(NSMutableArray* contactArr,NSError *contactError){
        // has load success
        if (contactError == nil) {
            if (contactArr) {
                contactNoFilterArray = contactArr;
                contactDictionary = [self filterContactArray:contactArr];
                [self->contactTableView reloadData];
            }
            [self->loadContactIndicator stopAnimating];
            self->loadContactIndicator.hidden = true;
        } else {
            //NSLog(@"%u",*contactError);
        }
    } queue:nil];
    
}

- (IBAction)addContactAction:(id)sender {

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CTContactViewController"];
                            
    [self.navigationController pushViewController:vc animated:true];
}

+ (instancetype)shared {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CTContact" bundle:nil];
    CTContactViewController *vc = NULL;
    
    if (storyboard) {
        vc = [storyboard instantiateViewControllerWithIdentifier:@"CTContactViewController"];
    }
    
    return vc;
}

#pragma mark - private function

-(void)addContact:(NSNotification*) notification {
    if (notification != nil && notification.userInfo != nil) {
        CTAddressBook* contact = notification.userInfo[@"contact"];
        [contactNoFilterArray addObject:contact];
        contactDictionary = [self filterContactArray:contactNoFilterArray];
        NSString* key = [contact getFirstCharacter];
        int section = -1;
        for(int i = 0; i< contactKeyArray.count; i++) {
            if ([contactKeyArray[i] isEqualToString: key]) {
                section = i;
                break;
            }
        }
        if (section != -1) {
            NSArray* contactArraySelect = [contactDictionary valueForKey:key];
            if (contactArraySelect) {
                NSInteger index = [contactArraySelect indexOfObject:contact];
                NSIndexPath* indexCell = [NSIndexPath indexPathForItem:index inSection:section];
                if (index == 0) {
                    [contactTableView insertSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
                } else {
                    [contactTableView insertRowsAtIndexPaths:@[indexCell] withRowAnimation:UITableViewRowAnimationFade];
                }
                [contactTableView scrollToRowAtIndexPath:indexCell atScrollPosition:UITableViewScrollPositionTop animated:true];
            }
        }
    }
}


/**
 *  Parse NSMutableArray filter to NSMutableDictionary
 *
 *  @param contactFilterArray contactArray from ContactDevice NSMutableArray<CTAddressBook*>
 *
 *  @return NSMutableDictionary has filter contactFilterArray
 */
-(NSMutableDictionary*)filterContactArray:(NSMutableArray*)contactFilterArray {
    NSMutableDictionary* contactFilterDictionary = [[NSMutableDictionary alloc] init];
    //Filter Array to Dictionary
    for(int i = 0 ;i< contactFilterArray.count; i++) {
        //get contact i
        CTAddressBook* contact = [contactFilterArray objectAtIndex:i];
        
        // Upcase full name and get first character
        NSString* stringFirst = [contact getFirstCharacter];
        
        NSMutableArray* contactsInCharacter = [contactFilterDictionary valueForKey:stringFirst];
        //If first charter is exits
        if (contactsInCharacter) {
            // add contact in this key
            [contactsInCharacter addObject:contact];
        } else {
            // creaet new array and add to this key
            NSMutableArray* contactsInCharacterT = [[NSMutableArray alloc] init];
            [contactsInCharacterT addObject:contact];
            [contactFilterDictionary setValue:contactsInCharacterT forKey:stringFirst];
        }
    }
    // Sort alphaB array Key (ascending)
    NSArray* sortArray = [contactFilterDictionary.allKeys sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES]]];
    contactKeyArray = [[NSMutableArray alloc] initWithArray:sortArray];
    return contactFilterDictionary;
}

/**
 *  Create and add label No data in tableView
 */
-(void) addLabelNoDataToTableView {
    // if exist return
    if ([contactTableView viewWithTag:101]) {
        return;
    }
    //else create
    UILabel* noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX([self.view frame])/2 , CGRectGetMidY([contactTableView frame]) - 80, 200, 80)];
    noDataLabel.text = @"Không có liên hệ";
    [noDataLabel setFont: [UIFont fontWithName:@"Arial" size:25]];
    noDataLabel.tag = 101;
    [noDataLabel setTextAlignment:NSTextAlignmentCenter];
    //noDataLabel.backgroundColor = [UIColor blackColor];
    [contactTableView addSubview:noDataLabel];
}

/**
 *  reload UI when selectContactArray has data or not
 */
-(void) renderTableViewHasDataSelect {
    // if no data in selectContactArray
    BOOL isSearching = false;
    if (selectContactArray.count == 0) {
        // if hasn't render will render
        if (contentView.tag == 1) {
            if (self.searchController.isActive) {
                self.searchController.active = false;
                isSearching = true;
            }
            // set has render
            contentView.tag = 0;
            // Animation view render
            [UIView animateWithDuration:0.25 animations:^{
                // move up contentView 65 (65 is equal selectContactCollectionView.height)
                CGRect rect = [contentView frame];
                rect.origin.y -= 48;
                [contentView setFrame:rect];
                // increase height contactTableView 65 (65 is equal selectCOntactCollecionView.height)
                CGRect rectTableView = [contactTableView frame];
                rectTableView.size.height += 48;
                [contactTableView setFrame:rectTableView];
            } completion: ^(BOOL success){
                if (isSearching)
                    self.searchController.active = true;
            }];
            
        }
    } // if has data in selectContactArray
    else {
        //if hasn't render will render'
        if (contentView.tag == 0) {
            if (self.searchController.isActive) {
                self.searchController.active = false;
                isSearching = true;
            }
            // set has render
            contentView.tag = 1;
            // Animation view render
            [UIView animateWithDuration:0.25 animations:^{
                // move down contentView 65 (65 is equal selectContactCollectionView.height)
                CGRect rect = [contentView frame];
                rect.origin.y += 48;
                [contentView setFrame:rect];
                // deincrease height contactTableView 65 (65 is equal selectCOntactCollecionView.height)
                CGRect rectTableView = [contactTableView frame];
                rectTableView.size.height -= 48;
                [contactTableView setFrame:rectTableView];
            } completion: ^(BOOL success){
                if (isSearching)
                    self.searchController.active = true;
            }];
        }
    }
}

#pragma mark - UITableViewDelegate + UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    // Check is search enable
    if (self.searchController.isActive) {
         numberOfContactTableViewLabel.text = [NSString stringWithFormat:@"%lu liên hệ",(unsigned long)searchArray.count];
        // if no data in search add label nodata to tableview
        if (searchArray.count == 0) {
            [self addLabelNoDataToTableView];
        } // if has data remove label nodata in tableview
        else {
            [[tableView viewWithTag:101] removeFromSuperview];
        }
        return 1;
    }
     numberOfContactTableViewLabel.text = [NSString stringWithFormat:@"%lu liên hệ",(unsigned long)contactNoFilterArray.count];
    // if no search (tablview normal)
    if (contactKeyArray.count == 0) {
        // add LabelNoData if havn't data
        [self addLabelNoDataToTableView];
    } else {
        // remove label if has
        [[tableView viewWithTag:101] removeFromSuperview];
    }
    return contactKeyArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // if search enable return search count array
    if (self.searchController.isActive) {
        return searchArray.count;
    }
    // else return key tableview array
    NSString* key = [contactKeyArray objectAtIndex: section];
    NSMutableArray* array = [contactDictionary valueForKey:key];
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Load custom cell
    ContactViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"ContactCell"];
    [cell cleanUI];
    [cell setDelegate:self];
    // if search enable. render model of searchArray. else render contactArray
    if (self.searchController.isActive) {
        [cell renderUI:[searchArray objectAtIndex: indexPath.row]];
        return cell;
    }
    NSString* key = [contactKeyArray objectAtIndex: indexPath.section];
    NSMutableArray* array = [contactDictionary valueForKey:key];
    [cell renderUI:[array objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [contactTableView deselectRowAtIndexPath:indexPath animated:false];
    // Get cell
    ContactViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        return;
    }
    // Get data
    CTAddressBook* contact;
    // if searchbar enable get contact in search array
    if (self.searchController.isActive) {
        contact = [searchArray objectAtIndex:indexPath.row];
    } // else get in contact array
    else {
        NSString* key = [contactKeyArray objectAtIndex: indexPath.section];
        NSMutableArray* array = [contactDictionary valueForKey:key];
        contact = [array objectAtIndex:indexPath.row];
    }
    contact.isSelected = !contact.isSelected;
    [cell changeStatus];
    
    // if contact has selected remove in selectContactArray, else add to selectContactArray
    if (contact.isSelected) {
        [selectContactArray addObject:contact];
        NSArray* indexPathArray = [[NSArray alloc] initWithObjects: [NSIndexPath indexPathForItem:selectContactArray.count - 1 inSection:0]  , nil];
        [selectContactCollectionView insertItemsAtIndexPaths: indexPathArray];
        [selectContactCollectionView scrollToItemAtIndexPath:indexPathArray[0] atScrollPosition:UICollectionViewScrollPositionRight animated:true];
    } else {
        NSInteger indexRemoveContact = [selectContactArray indexOfObject:contact];
        [selectContactArray removeObject:contact];
        NSArray* indexPathArray = [[NSArray alloc] initWithObjects: [NSIndexPath indexPathForItem: indexRemoveContact inSection:0]  , nil];
        [selectContactCollectionView scrollToItemAtIndexPath:indexPathArray[0] atScrollPosition:UICollectionViewScrollPositionRight animated:true];
        [selectContactCollectionView deleteItemsAtIndexPaths:indexPathArray];
    }
    
    // reload UI
    [self performSelector:@selector(renderTableViewHasDataSelect) withObject:nil afterDelay:0];
    // reload selectCollectionView

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 53.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // If search enable remove headerView
    if (self.searchController.isActive) {
        return nil;
    }
    // else add HeaderView with title = key's section
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX([self.view frame]), 18)];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.alpha = 0.85;
    //LinerBar
    UIView* linearBar = [[UIView alloc] initWithFrame:CGRectMake(0, -1, CGRectGetMaxX([self.view frame]), 1.2)];
    linearBar.backgroundColor = [UIColor grayColor];
    //HeaderLabel
    UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMidY([headerView frame]) - 5, CGRectGetMaxX([self.view frame]), 18)];
    headerLabel.alpha = 0.8;
    headerLabel.text = [contactKeyArray objectAtIndex: section];
    if ([headerLabel.text isEqualToString:@" "]) {
        headerLabel.text = @"#";
    }
    [headerLabel setFont: [UIFont fontWithName:@"Arial" size:16] ];
    headerLabel.textColor = [UIColor grayColor];
    [headerView addSubview:headerLabel];
    [headerView addSubview:linearBar];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    // if search enable remove tiles
    if (self.searchController.isActive)
        return nil;
    // else return tiles title array = key contact
    return contactKeyArray;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Get key in row
        NSString* key = contactKeyArray[indexPath.section];
        // get contact array in section key
        NSMutableArray* contactAray = [contactDictionary objectForKey:key];
        //Remove contact in array and delete in tableView with animation
        [contactAray removeObjectAtIndex:indexPath.row];
        if (contactAray.count == 0) {
            [contactDictionary removeObjectForKey:key];
            [contactKeyArray removeObjectAtIndex:indexPath.section];
            [contactTableView deleteSections: [[NSIndexSet alloc] initWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        } else {
            [contactTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        
    }
}

#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}/**
  *  create texture image for contact if image is null
  */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return selectContactArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ContactSelectViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ContactSelectCell" forIndexPath:indexPath];
    [cell cleanUI];
    [cell renderUI: [selectContactArray objectAtIndex: indexPath.row]];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CTAddressBook* contact = [selectContactArray objectAtIndex:indexPath.row];
    //render cell in contactTableView
    if (self.searchController.isActive) {
        [contactTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:true];
    } else {
        NSString* key = [contact getFirstCharacter];
        int section = -1;
        for(int i = 0; i< contactKeyArray.count; i++) {
            if ([contactKeyArray[i] isEqualToString: key]) {
                section = i;
                break;
            }
        }
        if (section != -1) {
            NSArray* contactArraySelect = [contactDictionary valueForKey:key];
            if (contactArraySelect) {
                NSInteger index = [contactArraySelect indexOfObject:contact];
                NSIndexPath* indexCell = [NSIndexPath indexPathForItem:index inSection:section];
                [contactTableView scrollToRowAtIndexPath:indexCell atScrollPosition:UITableViewScrollPositionTop animated:true];
            }
        }
    }
    
    [self renderTableViewHasDataSelect];
}

#pragma mark - UISeachUpdating && UISearchDelegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // get search string
    NSString *searchString = searchController.searchBar.text;
    // search with string
    [self searchForText:searchString];
    // reload tableView when filter
    [contactTableView reloadData];
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"searchBarCancelButtonClicked");
    [contactTableView reloadData];
}

-(void)searchForText:(NSString*)searchString {
    [searchArray removeAllObjects];
    // get element foreach key
    for (int i = 0; i < contactKeyArray.count; i++) {
        // get array of contact in this key
        NSArray* array = [contactDictionary valueForKey: [contactKeyArray objectAtIndex:i]] ;
        // foreach contact with key
        for (int j = 0; j < array.count; j++) {
            // get contact at index
            CTAddressBook* contact = [array objectAtIndex:j];
            // if seach string empty add searchArray
            if ([searchString  isEqual: @""]) {
                [searchArray addObject:contact];
            } // if in name contain searchString add to searchArray
            else if ( [contact.fullName containsString:searchString]) {
                [searchArray addObject:contact];
            }
        }
    }
}

#pragma mark - ContactViewCellProtocol
-(void)inviteFriendViaSMS:(CTAddressBook *)contact {
    // if can't send SMS
    if(![MFMessageComposeViewController canSendText]) {
        // show alert notify can't send SMS and return
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    // Confirgue data
    NSArray *recipents = contact.phoneMutableArray;
    NSString *message = [NSString stringWithFormat:@"Chào bạn %@, bạn đã được mời tham gia ứng dụng Zalo một ứng dụng xã hội số một tại Việt Nam hiện nay. Bạn sẽ tha hồ chat, gọi điện và một số tiện ích khác hoàn toàn miển phí. Để được cài đặt vui lòng bấm vào đây: https://itunes.apple.com/us/app/zalo/id579523206?mt=8", contact.fullName];
    
    // Craeate send SMS controller
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    // set phone receive
    [messageController setRecipients:recipents];
    // set message
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}


#pragma mark - MFMessageCompose Delegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    //Rand notify for test and show alert
    int rand = arc4random_uniform(2);
    NSString* message = @"Không thể gửi đươc tin nhắn!";
    if ( rand == 0 ) {
        message = @"Bạn đã gửi tin nhắn mời thành công!";
    }
    UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo lỗi" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [warningAlert show];
    
    // check result and handler
    switch (result) {
        case MessageComposeResultCancelled:
            break;
        case MessageComposeResultFailed:
            break;
        case MessageComposeResultSent:
            break;
        default:
            break;
    }
    // back current view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
