//
//  NotificationCell.h
//  bro
//
//  Created by g tokman on 4/22/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareMediaDelegate.h"

@interface NotificationCell : UITableViewCell


@property (weak) id <ShareMediaDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (weak) BRUser *user;
@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (IBAction)acceptAction:(UIButton *)sender;

@end
