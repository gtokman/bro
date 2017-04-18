//
//  PhotoViewController.h
//  bro
//
//  Created by g tokman on 4/13/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "UsersTableViewController.h"

@interface PhotoViewController : UIViewController

@property UsersTableViewController *homeVC;

+ (PhotoViewController*)photoViewControllerFromStoryboardID;

@end
