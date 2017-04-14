//
//  PhotoViewController.h
//  bro
//
//  Created by g tokman on 4/13/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "HomeViewController.h"

@interface PhotoViewController : UIViewController

@property HomeViewController *homeVC;

+ (PhotoViewController*)photoViewControllerFromStoryboardID;

@end
