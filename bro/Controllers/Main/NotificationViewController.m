//
//  NotificationViewController.m
//  bro
//
//  Created by g tokman on 4/9/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "NotificationViewController.h"
#import "bro-Swift.h"
#import <FirebaseDatabase/FirebaseDatabase.h>

@interface NotificationViewController ()
@property FIRDatabaseHandle usersHandle;
//@property FIRDatabaseHandle messagesHandle;
@property NSMutableArray<BRUser *> *users;
@property NSMutableArray<BRMessage *> *messages;
@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.users = [NSMutableArray new];
    self.messages = [NSMutableArray new];
    
    
    self.usersHandle = [DatabaseManager observeNewUserNotificationsWithBlock:^(FIRDataSnapshot *snapshot) {
        NSLog(@"Notification ref %@", snapshot.value);
        BRUser *user = [[BRUser alloc] initWithJsonDictionary:snapshot.value];
        [self.users addObject:user];
        [self.tableView reloadData];
    }];
    
    [DatabaseManager queryNewBroMessagesWithBlock:^(FIRDataSnapshot *snapshot) {
        BRMessage *message = [[BRMessage alloc] initWithMessageDictionary:snapshot.value];
        
        [self.messages addObject:message];
        
        [self.tableView reloadData];
    }];
}

#pragma mark - Actions

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
        // Delete ref
        [DatabaseManager removeNotificationRefWithUser:user];
    } withFriendBlock:^(NSError *error, FIRDatabaseReference *ref) {
        if (error) {
            NSLog(@"Error adding friend %@", error.localizedDescription);
        }
        NSLog(@"Added self to user %@", ref);
        
    }];
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notificationControl.selectedSegmentIndex == 0 ? self.messages.count : self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationCell" forIndexPath:indexPath];
    
    switch (self.notificationControl.selectedSegmentIndex) {
        case 0: {
            BRMessage *message = self.messages[self.messages.count - indexPath.row - 1];
            cell.displayNameLabel.text = [NSString stringWithFormat:@"%@ From %@", message.body, message.sender];
            NSDate *timestamp = [NSDate dateWithTimeIntervalSince1970:message.timeStamp.doubleValue / 1000];
            cell.timeLabel.text = [DateHelper timeAgoSinceDate:timestamp currentDate:[NSDate date] numericDates:YES];
            break;
        }
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
        [cell.timeLabel setHidden: self.notificationControl.selectedSegmentIndex];
    }];
    
//    if (indexPath.row % 2 == 0) {
//        cell.backgroundColor = [UIColor flatGrayColor];
//    } else {
//        cell.backgroundColor = [UIColor flatWhiteColor];
//    }
}

@end
