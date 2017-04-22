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
#import "NotificationCell.h"


@interface NotificationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

+ (NotificationViewController*)notificationViewControllerFromStoryboardID;

@end
