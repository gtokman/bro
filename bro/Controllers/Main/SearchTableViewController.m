//
//  SearchTableViewController.m
//  bro
//
//  Created by g tokman on 4/20/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "SearchTableViewController.h"
#import "BRUser.h"

@interface SearchTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property NSMutableArray<BRUser *> *users;

@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.users = [NSMutableArray new];
    
}

#pragma mark - Actions

- (IBAction)cancelAction:(UIButton *)sender {
    [self shouldHideCancelButton:YES];
    [self.searchTextField resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"Cell number %ld", indexPath.row];
    
    return cell;
}

#pragma mark - Textfield delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"Should begin: %@", textField.text);
    [self shouldHideCancelButton:NO];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self shouldHideCancelButton:YES];
    [textField resignFirstResponder];
    return YES;
}

- (void)shouldHideCancelButton:(BOOL)isHidden {
    [UIView animateWithDuration:0.2 animations:^{
        [self.cancelButton setHidden:isHidden];
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
