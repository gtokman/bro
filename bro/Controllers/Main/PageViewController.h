//
//  PageViewController.h
//  bro
//
//  Created by g tokman on 4/9/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "ProfileViewController.h"
#import "PhotoViewController.h"
#import "MainViewController.h"

@interface PageViewController : UIPageViewController <UIPageViewControllerDataSource>

+(PageViewController*)initPageViewControllerFromStoryboard;

@end
