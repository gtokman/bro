//
//  SignUpViewController.h
//  bro
//
//  Created by g tokman on 4/6/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import "AuthManager.h"
#import "DatabaseManager.h"
@import Firebase;
@import SafariServices;

@interface SignUpViewController : UIViewController <UITextFieldDelegate, SFSafariViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextActionBottomConstraint;

- (IBAction)nextAction:(UIButton *)sender;

@end
