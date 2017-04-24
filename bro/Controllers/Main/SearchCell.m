//
//  SearchCell.m
//  bro
//
//  Created by g tokman on 4/21/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "SearchCell.h"



@implementation SearchCell
@synthesize user = _user;

- (void)setUser:(BRUser *)user {
    _user = user;
    self.displayNameLabel.text = user.displayName;
}

- (BRUser *)user {
    return _user;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)addAction:(UIButton *)sender {
    NSLog(@"Hello");
    [self.delegate addNewUser: self.user];
}

@end
