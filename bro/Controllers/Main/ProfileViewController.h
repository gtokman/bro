//
//  ProfileViewController.h
//  bro
//
//  Created by g tokman on 4/9/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController

+ (ProfileViewController*)profileViewControllerFromStoryboardID;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
