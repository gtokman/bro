//
//  SignUpViewController.m
//  bro
//
//  Created by g tokman on 4/6/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "SignUpViewController.h"
@import ChameleonFramework;

@interface SignUpViewController ()
@property FIRAuthStateDidChangeListenerHandle handle;
@end

@implementation SignUpViewController

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.handle = [[FIRAuth auth]
                   addAuthStateDidChangeListener:^(FIRAuth * _Nonnull auth, FIRUser * _Nullable user) {
                       if (user) {
                           [self addNewUserToDatabase: user];
                       }
                   }];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[FIRAuth auth]removeAuthStateDidChangeListener:self.handle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Helper

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardBounds;
    NSNumber *keyboardDuration;
    
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    keyboardDuration = [notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    // Do something with keyboard height
    [UIView animateWithDuration:[keyboardDuration integerValue] animations:^{
        NSLog(@"%f", keyboardBounds.size.height);
        self.nextActionBottomConstraint.constant = keyboardBounds.size.height;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    CGRect keyboardBounds;
    NSNumber *keyboardDuration;
    
    [[notification.userInfo valueForKey:UIKeyboardDidChangeFrameNotification] getValue:&keyboardBounds];
    keyboardDuration = [notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    // Do something with keyboard height
    [UIView animateWithDuration:[keyboardDuration integerValue] animations:^{
        NSLog(@"%f", keyboardBounds.size.height);
        self.nextActionBottomConstraint.constant = 0;
    }];
}

- (void)signUpNewUser {
    [self.activityIndicator startAnimating];
    [AuthManager
     signUpUserWithEmail:self.emailTextField.text
     password:self.passwordTextField.text
     withBlock:^(FIRUser *user, NSError *error) {
         if (error) {
             NSLog(@"Error signing up: %@", error.localizedDescription);
             [self.activityIndicator stopAnimating];
         } else {
             NSLog(@"Sign up with user: %@", user.email);
         }
     }];
}

- (void)addNewUserToDatabase:(FIRUser *)user {
    
    NSLog(@"We have a user %@, displayName: %@", user.email, user.displayName);
    NSString *token = [[FIRInstanceID instanceID] token];
    [DatabaseManager
     addNewUserToDatabase:user
     userName:self.userNameTextField.text
     token:token
     withBlock:^(NSError *error, FIRDatabaseReference *ref) {
         if (error) {
             NSLog(@"Error adding user to database: %@", error.localizedDescription);
             // Handle user name taken error
             
         } else {
             [DatabaseManager addNewUserName:self.userNameTextField.text
                                   withBlock:^(NSError *error, FIRDatabaseReference *ref) {
                                       if (error) {
                                           NSLog(@"Adding username to DB error %@", error.localizedDescription);
                                           return;
                                       }
                                       NSLog(@"new user added %@", ref);
                                       [self performSegueWithIdentifier:@"HomeSegue" sender:nil];
                                   }];
         }
         [self.activityIndicator stopAnimating];
     }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([self.emailTextField isFirstResponder]) [self.emailTextField resignFirstResponder];
    if ([self.userNameTextField isFirstResponder]) [self.userNameTextField resignFirstResponder];
    if ([self.passwordTextField isFirstResponder]) [self.passwordTextField resignFirstResponder];
}

#pragma mark - Actions

- (IBAction)termsAndServiceAction:(UIButton *)sender {
    NSURL *termsUrl = [NSURL URLWithString:@"https://us-central1-broapp-a3772.cloudfunctions.net/termsAndService"];
    SFSafariViewController *sfVC = [[SFSafariViewController alloc] initWithURL:termsUrl];
    sfVC.delegate = self;
    [self presentViewController:sfVC animated:YES completion:nil];
}

- (IBAction)nextAction:(UIButton *)sender {
    FIRUser *user = [FIRAuth auth].currentUser;
    if ([self.emailTextField hasText] && [self.userNameTextField hasText] && [self.passwordTextField hasText]){
        if (!user) {
            [self signUpNewUser];
        } else {
            [self addNewUserToDatabase: user];
        }
    } else {
        NSLog(@"No empty text");
    }
}

#pragma mark - SFSafariDelegate

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    NSLog(@"Done with SFVC!");
    //  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully {
    NSLog(@"Did finish loading!");
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
