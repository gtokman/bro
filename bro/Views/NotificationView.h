//
//  NotificationView.h
//  bro
//
//  Created by g tokman on 4/20/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface NotificationView : UIView
@property IBInspectable NSString *text;
@property IBInspectable double textSize;
@property IBInspectable UIColor *bgColor;
@property IBInspectable UIColor *pressedColor;
@end
