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
@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.users = [NSMutableArray new];
    self.usersHandle = [DatabaseManager observeNewUserNotificationsWithBlock:^(FIRDataSnapshot *snapshot) {
        NSLog(@"Notification ref %@", snapshot.value);
        BRUser *user = [[BRUser alloc] initWithJsonDictionary:snapshot.value];
        [self.users addObject:user];
        [self.tableView
         insertRowsAtIndexPaths:@[
                                  [NSIndexPath indexPathForRow:self.users.count - 1 inSection:0]
                                  ]
         withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
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
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationCell" forIndexPath:indexPath];
    BRUser *user = self.users[indexPath.row];
    cell.user = user;
    cell.delegate = self;
    
    return cell;
}

@end
