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
    HomeViewController *home = [HomeViewController homeViewControllerFromStoryBoardID];
    ProfileViewController *profile = [ProfileViewController profileViewControllerFromStoryboardID];
    [self.pageViewControllers addObject:profile];
    [self.pageViewControllers addObject:home];
    
    // Setup
    self.dataSource = self;
    [self setViewControllers:@[self.pageViewControllers[1]]
                   direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        NSLog(@"Complete");
    }];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Navigation

+(PageViewController*)initPageViewControllerFromStoryboard {
    return [[UIStoryboard storyboardWithName:@"Home" bundle:nil]
            instantiateViewControllerWithIdentifier:@"HomePageController"];
}

#pragma mark - UIPageControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[HomeViewController class]]) {
        NSLog(@"The before VC is profile %@", viewController.description);
        return self.pageViewControllers[0];
    }

    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[ProfileViewController class]]) {
        NSLog(@"The after vc should be Home: %@ ", viewController.description);
        return self.pageViewControllers[1];
    }
    
    return nil;
}

@end
