//
//  SearchTableViewController.m
//  bro
//
//  Created by g tokman on 4/20/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <FirebaseAuth/FirebaseAuth.h>
#import "SearchTableViewController.h"
#import "BRUser.h"
#import "DatabaseManager.h"
#import "SearchCell.h"


@interface SearchTableViewController () <UITextFieldDelegate, UserAddedDelegate>

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property NSMutableArray<BRUser *> *users;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Init
    self.users = [NSMutableArray new];
    [self.view addSubview:self.loadingIndicator];
    self.loadingIndicator.center = [self.view center];
}

#pragma mark - UserAddedDelegate

- (void)addNewUser:(BRUser *)user {
    NSLog(@"User: %@", user.displayName);
    [DatabaseManager addNewFriendRequest:user withBlock:^(NSError *error, FIRDatabaseReference *ref) {
        if (error) {
            NSLog(@"Error adding friend");
        }
        
    }];
}

#pragma mark - Actions

- (IBAction)cancelAction:(UIButton *)sender {
    [self shouldHideCancelButton:YES];
    [self.searchTextField resignFirstResponder];
}
- (IBAction)logoutAction:(UIBarButtonItem *)sender {
    NSError *error;
    [[FIRAuth auth] signOut:&error];
}

- (void)searchForUserName:(NSString*)username {
    [DatabaseManager queryUsersWithUsername:username withBlock:^(FIRDataSnapshot *snapshot) {
        BRUser *user = [[BRUser alloc] initWithJsonDictionary:snapshot.value];
        [self.users addObject:user];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.users.count - 1 inSection:0]]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.loadingIndicator stopAnimating];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];
    
    // Configure the cell...
    BRUser *user = self.users[indexPath.row];
    cell.user = user;
    cell.delegate = self;
    
    return cell;
}

#pragma mark - Textfield delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"Should begin: %@", textField.text);
    [self shouldHideCancelButton:NO];
    if (self.users.count > 0) {
        [self.users removeAllObjects];
        [self.tableView reloadData];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self shouldHideCancelButton:YES];
    [textField resignFirstResponder];
    if ([textField hasText]) {
        [self searchForUserName:textField.text.uppercaseString];
        [self.loadingIndicator startAnimating];
    }
    
    return YES;
}

- (void)shouldHideCancelButton:(BOOL)isHidden {
    [UIView animateWithDuration:0.2 animations:^{
        [self.cancelButton setHidden:isHidden];
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
