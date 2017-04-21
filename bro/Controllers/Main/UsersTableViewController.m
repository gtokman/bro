//
//  UsersTableViewController.m
//  bro
//
//  Created by g tokman on 4/7/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "UsersTableViewController.h"
#import "BRUser.h"
@import ChameleonFramework;

@interface UsersTableViewController () <UISearchResultsUpdating>
@property NSMutableArray<BRUser *> *users;
@property FIRUser *currentUser;
@property FIRDatabaseHandle usersHandle;
@end

@implementation UsersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.users = [NSMutableArray new];
    self.currentUser = [[FIRAuth auth]currentUser];
    //NSLog(@"%@, %@, %@", user.email, user.displayName, user.description);
    
    self.usersHandle = [DatabaseManager observeNewUsersAddedHandleWithBlock:^(FIRDataSnapshot *snapshot) {
        BRUser *user = [[BRUser alloc] initWithJsonDictionary:snapshot.value];
        [self.users addObject:user];
        [self.tableView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[DatabaseManager newUserRef] removeObserverWithHandle:self.usersHandle];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)unwindSegue:(UIStoryboardSegue*)segue {
    
}

+ (UsersTableViewController *)homeViewControllerFromStoryBoardID {
    return [[UIStoryboard storyboardWithName:@"Home" bundle:nil]
            instantiateViewControllerWithIdentifier:@"HomeVC"];
}

#pragma mark - Actions

- (IBAction)addAction:(UIButton *)sender {
    NSError *signOutError;
    [[FIRAuth auth] signOut:&signOutError];
}

- (IBAction)inviteAction:(UITapGestureRecognizer *)sender {
    UIViewController *contactsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactsVC"];
    [self.parentViewController.navigationController pushViewController:contactsVC animated:YES];
//    [self.navigationController pushViewController:contactsVC animated:YES];
}

- (IBAction)searchAction:(UITapGestureRecognizer *)sender {
    UIViewController *searchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
    [self.parentViewController.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BRUser *receivingUser = self.users[indexPath.row];
    [self.delegate didSelectUser:receivingUser];
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BroCell" forIndexPath:indexPath];
    
    BRUser *user = self.users[indexPath.row];
    cell.textLabel.text = user.displayName;
    cell.backgroundColor = [UIColor randomFlatColor];
    
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}


@end
