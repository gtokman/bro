//
//  HomeViewController.m
//  bro
//
//  Created by g tokman on 4/7/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "HomeViewController.h"
#import "BRUser.h"

@interface HomeViewController () <UISearchResultsUpdating>
@property NSMutableArray<BRUser *> *users;
@property FIRDatabaseHandle usersHandle;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.users = [NSMutableArray new];
    FIRUser *user = [[FIRAuth auth]currentUser];
    NSLog(@"%@, %@, %@", user.email, user.displayName, user.description);
    
    self.usersHandle = [[DatabaseManager newUserRef]
                        observeEventType:FIRDataEventTypeChildAdded
                        withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                            BRUser *user = [[BRUser alloc] initWithJsonDictionary:snapshot.value];
                            [self.users addObject:user];
                            [self.tableView reloadData];
                        }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[DatabaseManager newUserRef] removeObserverWithHandle:self.usersHandle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

+ (HomeViewController *)homeViewControllerFromStoryBoardID {
    return [[UIStoryboard storyboardWithName:@"Home" bundle:nil]
            instantiateViewControllerWithIdentifier:@"HomeVC"];
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BroCell" forIndexPath:indexPath];
    
    BRUser *user = self.users[indexPath.row];
    cell.textLabel.text = user.displayName;
    
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}


@end
