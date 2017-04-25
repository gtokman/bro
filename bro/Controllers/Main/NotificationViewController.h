//
//  NotificationViewController.h
//  bro
//
//  Created by g tokman on 4/9/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import "DatabaseManager.h"
#import "ShareMediaDelegate.h"
#import "NotificationCell.h"


@interface NotificationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ShareMediaDelegate, UIToolbarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *notificationControl;

- (IBAction)notificationControlAction:(UISegmentedControl *)sender;
+ (NotificationViewController*)notificationViewControllerFromStoryboardID;

@end
