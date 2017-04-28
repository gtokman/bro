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

@interface UsersTableViewController ()
@property NSMutableArray<BRUser *> *users;
@property NSArray *colors;
@property NSInteger index;
@property FIRUser *currentUser;
@property FIRDatabaseHandle usersHandle;
@end

@implementation UsersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.users = [NSMutableArray new];
    self.colors = @[FlatWatermelonDark, FlatSkyBlueDark, FlatYellowDark, FlatGreenDark, FlatMagentaDark];
    self.currentUser = [[FIRAuth auth]currentUser];
    //NSLog(@"%@, %@, %@", user.email, user.displayName, user.description);
    
    self.usersHandle = [DatabaseManager observeNewUsersAddedHandleWithBlock:^(FIRDataSnapshot *snapshot) {
        BRUser *user = [[BRUser alloc] initWithJsonDictionary:snapshot.value];
        [self.activityIndicator stopAnimating];
        [self.users addObject:user];
        [self.tableView reloadData];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePushNotification:) name:@"NewPushNotification" object:nil];
}

- (void)handlePushNotification:(NSNotification *)notification {
    NSLog(@"Received notification %@", notification.object);
    [self.notificationButton setHidden:NO];
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
    UsersCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [UIView animateWithDuration:0.1 animations:^{
        [cell.displayNameLabel setHidden:YES];
        [cell.activityIndicator startAnimating];
    }];
    [DatabaseManager addNewBroNotificationToFriend:receivingUser withBlock:^(NSError *error, FIRDatabaseReference *ref) {
        if (error) {
            NSLog(@"Error sending notif to bro: %@", error);
        }
        NSLog(@"Notif to bro success %@", ref);
        [UIView animateWithDuration:0.1 animations:^{
            [cell.activityIndicator stopAnimating];
            cell.displayNameLabel.text = @"Bro Sent!";
            [cell.displayNameLabel setHidden:NO];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:3.0 animations:^{
                cell.displayNameLabel.alpha = 0;
            } completion:^(BOOL finished) {
                cell.displayNameLabel.alpha = 1;
                cell.displayNameLabel.text = receivingUser.displayName;
            }];
        }];
    }];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = self.colors[self.index];
    self.index++;
    
    if (self.index == self.colors.count) {
        self.index = 0;
    }
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UsersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BroCell" forIndexPath:indexPath];
    
    BRUser *user = self.users[indexPath.row];
    cell.displayNameLabel.text = user.displayName;
    
    return cell;
}

@end
