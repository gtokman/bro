//
//  UsersTableViewController.m
//  bro
//
//  Created by g tokman on 4/7/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "UsersTableViewController.h"
#import "BRUser.h"

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

+ (UsersTableViewController *)homeViewControllerFromStoryBoardID {
    return [[UIStoryboard storyboardWithName:@"Home" bundle:nil]
            instantiateViewControllerWithIdentifier:@"HomeVC"];
}

- (IBAction)addAction:(UIButton *)sender {
    NSError *signOutError;
    [[FIRAuth auth] signOut:&signOutError];
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
    
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}


@end
