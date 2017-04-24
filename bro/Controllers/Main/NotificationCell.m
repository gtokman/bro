//
//  NotificationCell.m
//  bro
//
//  Created by g tokman on 4/22/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "NotificationCell.h"

@implementation NotificationCell
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

- (IBAction)acceptAction:(UIButton *)sender {
    [self.delegate didSelectUser:self.user];
}
@end
