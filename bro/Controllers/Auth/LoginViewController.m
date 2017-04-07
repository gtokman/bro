//
//  LoginViewController.m
//  bro
//
//  Created by g tokman on 4/6/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.userNameTextField becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
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
        self.loginActionBottomConstraint.constant = keyboardBounds.size.height;
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
        self.loginActionBottomConstraint.constant = 0;
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"prepare for seg");
    [self.userNameTextField resignFirstResponder];
}

#pragma mark - Actions

- (IBAction)forgotPasswordAction:(UIButton *)sender {
}

- (IBAction)loginAction:(UIButton *)sender {
}

#pragma mark - TextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
