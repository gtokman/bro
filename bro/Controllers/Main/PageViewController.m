//
//  PageViewController.m
//  bro
//
//  Created by g tokman on 4/9/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()
@property NSMutableArray<UIViewController *> *pageViewControllers;
@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Init
    self.pageViewControllers = [NSMutableArray new];
    MainViewController *main = [MainViewController getMainViewControllerWithStoryboardID];
    NotificationViewController *notification = [NotificationViewController notificationViewControllerFromStoryboardID];
    PhotoViewController *photoVC = [PhotoViewController photoViewControllerFromStoryboardID];
    [self.pageViewControllers addObject:notification];
    [self.pageViewControllers addObject:main];
    [self.pageViewControllers addObject:photoVC];
    // Setup
    self.dataSource = self;
    [self setViewControllers:@[self.pageViewControllers[1]]
                   direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        NSLog(@"Complete");
    }];
    self.view.backgroundColor = [UIColor blackColor];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Navigation

+ (PageViewController*)initPageViewControllerFromStoryboard {
    return [[UIStoryboard storyboardWithName:@"Home" bundle:nil]
            instantiateViewControllerWithIdentifier:@"HomePageController"];
}

#pragma mark - UIPageControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[MainViewController class]]) {
        NSLog(@"The before VC is profile %@", viewController.description);
        return self.pageViewControllers[0];
    } else if ([viewController isKindOfClass:[PhotoViewController class]]) {
        return self.pageViewControllers[1];
    }

    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[NotificationViewController class]]) {
        NSLog(@"The after vc should be Home: %@ ", viewController.description);
        return self.pageViewControllers[1];
    } else if ([viewController isKindOfClass:[MainViewController class]]) {
        return self.pageViewControllers[2];
    }
    
    return nil;
}

@end
