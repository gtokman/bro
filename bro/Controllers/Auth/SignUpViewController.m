//
//  SignUpViewController.m
//  bro
//
//  Created by g tokman on 4/6/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "SignUpViewController.h"

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
                           NSLog(@"We have a user %@", user.email);
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

- (IBAction)nextAction:(UIButton *)sender {
    if ([self.emailTextField hasText] && [self.userNameTextField hasText] && [self.passwordTextField hasText]) {
        [AuthManager
         signUpUserWithEmail:self.emailTextField.text
         password:self.passwordTextField.text
         error: ^(NSError* failure) {
             NSLog(@"Error: %@", failure.localizedDescription);
         }];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
