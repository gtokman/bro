//
//  SearchCell.h
//  bro
//
//  Created by g tokman on 4/21/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRUser.h"

@protocol UserAddedDelegate <NSObject>

- (void)addNewUser:(BRUser*)user;

@end

@interface SearchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak) BRUser *user;
@property id <UserAddedDelegate> delegate;
@end
