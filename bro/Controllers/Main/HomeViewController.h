//
//  HomeViewController.h
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

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

+ (HomeViewController*)homeViewControllerFromStoryBoardID;

- (IBAction)addAction:(UIButton *)sender;
@end
