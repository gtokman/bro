//
//  MainViewController.m
//  bro
//
//  Created by g tokman on 4/13/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () <ShareMediaDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.layer.cornerRadius=25;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSelectUser:(BRUser *)user {
    NSLog(@"Selected %@", user.email);
    [DatabaseManager addNewBroNotificationToFriend:user withBlock:^(NSError *error, FIRDatabaseReference *ref) {
        if (error) {
            NSLog(@"Error sending notif to bro: %@", error);
        }
        NSLog(@"Notif to bro success %@", ref);
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"UsersListSegue"]) {
        self.homeVC = [segue destinationViewController];
        self.homeVC.delegate = self;
    }
}

+ (UINavigationController *)getMainViewControllerWithStoryboardID {
    return [[UIStoryboard storyboardWithName:@"Home" bundle:nil]
            instantiateViewControllerWithIdentifier:@"MainVC"];
}

@end
