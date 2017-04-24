//
//  NotificationViewController.m
//  bro
//
//  Created by g tokman on 4/9/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "NotificationViewController.h"
#import <FirebaseDatabase/FirebaseDatabase.h>

@interface NotificationViewController ()
@property FIRDatabaseHandle usersHandle;
@property NSMutableArray<BRUser *> *users;
@property NSMutableArray<NSString *> *notifications;
@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.users = [NSMutableArray new];
    self.notifications = [NSMutableArray new];
    [self.notifications addObject:@"Hi"];
    self.usersHandle = [DatabaseManager observeNewUserNotificationsWithBlock:^(FIRDataSnapshot *snapshot) {
        NSLog(@"Notification ref %@", snapshot.value);
        BRUser *user = [[BRUser alloc] initWithJsonDictionary:snapshot.value];
        [self.users addObject:user];
    }];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refreshControl;
}

- (void)handleRefresh:(id)sender {
    NSLog(@"Refresh");
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)notificationControlAction:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            NSLog(@"messages selected");
            [self.tableView reloadData];
            break;
        case 1:
            NSLog(@"Requests selected");
            [self.tableView reloadData];
            
            break;
    }
}

+ (UINavigationController *)notificationViewControllerFromStoryboardID {
    return [[UIStoryboard storyboardWithName:@"Home" bundle:nil]
            instantiateViewControllerWithIdentifier:@"ProfileVC"];
}

#pragma mark - ShareMediaDelegate

- (void)didSelectUser:(BRUser *)user {
    NSLog(@"User accepted %@", user.displayName);
    [DatabaseManager addNewFriend:user withSelfBlock:^(NSError *error, FIRDatabaseReference *ref) {
        if (error) {
            NSLog(@"Error adding friend %@", error.localizedDescription);
        }
        NSLog(@"Added user to self %@", ref);
    } withFriendBlock:^(NSError *error, FIRDatabaseReference *ref) {
        if (error) {
            NSLog(@"Error adding friend %@", error.localizedDescription);
        }
        NSLog(@"Added self to user %@", ref);
    }];
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notificationControl.selectedSegmentIndex == 0 ? self.notifications.count : self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationCell" forIndexPath:indexPath];
    
    switch (self.notificationControl.selectedSegmentIndex) {
        case 0:
            cell.displayNameLabel.text = self.notifications[indexPath.row];
            break;
        case 1: {
            BRUser *user = self.users[indexPath.row];
            cell.user = user;
            cell.delegate = self;
            break;
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(NotificationCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [UIView animateWithDuration:0.1 animations:^{
        [cell.acceptButton setHidden: !self.notificationControl.selectedSegmentIndex];
    }];
}

@end
