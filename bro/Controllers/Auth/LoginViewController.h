//
//  LoginViewController.h
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

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginActionBottomConstraint;


- (IBAction)forgotPasswordAction:(UIButton *)sender;
- (IBAction)loginAction:(UIButton *)sender;

@end
