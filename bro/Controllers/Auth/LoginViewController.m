//
//  LoginViewController.m
//  bro
//
//  Created by g tokman on 4/6/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property FIRAuthStateDidChangeListenerHandle authHandle;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.emailTextField becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.authHandle = [[FIRAuth auth]addAuthStateDidChangeListener:^(FIRAuth * _Nonnull auth, FIRUser * _Nullable user) {
        if (user) {
            NSLog(@"We have a user! %@", user.email);
            NSString *refreshToken = [[FIRInstanceID instanceID] token];
            [DatabaseManager updateUserToken:refreshToken withBlock:^(NSError *error, FIRDatabaseReference *ref) {
                if (error) {
                    NSLog(@"Could not update token");
                }
                NSLog(@"InstanceId token created: %@ and updated", refreshToken);
                [self performSegueWithIdentifier:@"HomeSegue" sender:nil];
            }];
        } else {
            NSLog(@"No user :(");
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[FIRAuth auth]removeAuthStateDidChangeListener:self.authHandle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardBounds;
    NSNumber *keyboardDuration;
    
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    keyboardDuration = [notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    [UIView animateWithDuration:[keyboardDuration integerValue] animations:^{
        NSLog(@"%f", keyboardBounds.size.height);
        self.loginActionBottomConstraint.constant = keyboardBounds.size.height;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSNumber *keyboardDuration;
    keyboardDuration = [notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    [UIView animateWithDuration:[keyboardDuration integerValue] animations:^{
        self.loginActionBottomConstraint.constant = 0;
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"prepare for seg");
    if ([self.emailTextField isFirstResponder]) [self.emailTextField resignFirstResponder];
    if ([self.passwordTextField isFirstResponder]) [self.passwordTextField resignFirstResponder];
}

#pragma mark - Actions

- (IBAction)forgotPasswordAction:(UIButton *)sender {
    NSError *signOutError;
    [AuthManager signOutUserThrowsError:&signOutError withBlock:^{
        if (signOutError) {
            NSLog(@"Error signing out: %@", signOutError.localizedDescription);
        } else {
            NSLog(@"User signed out!");
        }
    }];
}

- (IBAction)loginAction:(UIButton *)sender {
    if ([self.emailTextField hasText] && [self.passwordTextField hasText]) {
        [self.activityIndicator startAnimating];
        [AuthManager loginUserWithEmail:self.emailTextField.text password:self.passwordTextField.text
                              withBlock:^(FIRUser *user, NSError *error) {
            if (error) {
                NSLog(@"Error logining in user: %@", error.localizedDescription);
            } else {
                NSLog(@"We have a user logged in: %@", user.email);
            }
            [self.activityIndicator stopAnimating];
        }];
    }
}

#pragma mark - TextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
