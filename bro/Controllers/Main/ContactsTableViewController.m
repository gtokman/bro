//
//  ContactsTableViewController.m
//  bro
//
//  Created by g tokman on 4/19/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "ContactsTableViewController.h"
#import "ContactsCell.h"
@import Ohana;
@import Contacts;
@import MessageUI;

@interface ContactsTableViewController () <OHCNContactsDataProviderDelegate, MFMessageComposeViewControllerDelegate>
@property NSMutableArray<OHContact *> *contacts;
@end

@implementation ContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Init setup
    OHCNContactsDataProvider *dataProvider = [[OHCNContactsDataProvider alloc] initWithDelegate:self];
    OHAlphabeticalSortPostProcessor *alphabeticalSortProcessor = [[OHAlphabeticalSortPostProcessor alloc]
     initWithSortMode:OHAlphabeticalSortPostProcessorSortModeFullName];
    OHRequiredFieldPostProcessor *phoneNumberProcessor = [[OHRequiredFieldPostProcessor alloc]
                                                          initWithFieldType:OHContactFieldTypePhoneNumber];
    OHContactsDataSource *dataSource = [[OHContactsDataSource alloc]
                                        initWithDataProviders:
                                        [NSOrderedSet orderedSetWithObjects:dataProvider, nil]
                                        postProcessors:
                                        [NSOrderedSet orderedSetWithObjects:alphabeticalSortProcessor, phoneNumberProcessor, nil]];
    ContactsTableViewController __weak *weakSelf = self;
    [dataSource.onContactsDataSourceReadySignal addObserver:self callback:^(id  _Nonnull self) {
        weakSelf.contacts = [NSMutableArray arrayWithArray:dataSource.contacts.array];
    }];
    [dataSource loadContacts];
}

#pragma mark - OHCNContactsDataProviderDelegate

- (void)dataProviderDidHitContactsAuthenticationChallenge:(OHCNContactsDataProvider *)dataProvider {
    CNContactStore *contactStore = [CNContactStore new];
    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error requesting contact permission: %@", error);
        }
        
        if (granted) {
            [dataProvider loadContacts];
        }
    }];
}

#pragma mark - Message compose delegete

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    switch (result) {
        case MessageComposeResultSent:
            NSLog(@"Message was sent");
            break;
        case MessageComposeResultFailed:
            NSLog(@"Message was failed");
            break;
        default:
            NSLog(@"Message was cancelled");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([MFMessageComposeViewController canSendText]) {
        OHContact *contact = self.contacts[indexPath.row];
        MFMessageComposeViewController *composeVC = [MFMessageComposeViewController new];
        composeVC.messageComposeDelegate = self;
        //config
        composeVC.recipients = @[[[contact.contactFields valueForKey:@"value"] firstObject]];
        composeVC.body = @"Bro! Download the Bro app.";
        
        [self presentViewController:composeVC animated:YES completion:nil];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell" forIndexPath:indexPath];
    
    OHContact *contact = self.contacts[indexPath.row];
    cell.nameLabel.text = contact.fullName;
    cell.phoneNumberLabel.text = [[contact.contactFields valueForKey:@"value"] firstObject];
    
    return cell;
}

@end
