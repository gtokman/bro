//
//  UsersTableViewController.h
//  bro
//
//  Created by g tokman on 4/7/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import <FirebaseDatabase/FirebaseDatabase.h>
#import "DatabaseManager.h"
#import "BRMessage.h"
#import "NotificationView.h"
#import "ShareMediaDelegate.h"


@interface UsersTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) id <ShareMediaDelegate> delegate;
@property (weak, nonatomic) IBOutlet NotificationView *notificationButton;

+ (UsersTableViewController*)homeViewControllerFromStoryBoardID;

- (IBAction)addAction:(UIButton *)sender;
@end
