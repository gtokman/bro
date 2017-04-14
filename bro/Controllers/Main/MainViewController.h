//
//  MainViewController.h
//  bro
//
//  Created by g tokman on 4/13/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareMediaDelegate.h"
#import "HomeViewController.h"

@interface MainViewController : UIViewController

@property HomeViewController *homeVC;

+ (MainViewController*)getMainViewControllerWithStoryboardID;

@end
