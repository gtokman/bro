//
//  MainViewController.h
//  bro
//
//  Created by g tokman on 4/13/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareMediaDelegate.h"
#import "UsersTableViewController.h"

@interface MainViewController : UIViewController

@property UsersTableViewController *homeVC;

+ (MainViewController*)getMainViewControllerWithStoryboardID;

@end
