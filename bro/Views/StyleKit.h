//
//  StyleKit.h
//  yo
//
//  Created by Gary Tokman on 4/20/17.
//  Copyright © 2017 Gary Tokman. All rights reserved.
//
//  Generated by PaintCode Plugin for Sketch
//  http://www.paintcodeapp.com/sketch
//

@import UIKit;



@interface StyleKit : NSObject


#pragma mark - Resizing Behavior

typedef enum : NSInteger {
  StyleKitResizingBehaviorAspectFit, //!< The content is proportionally resized to fit into the target rectangle.
  StyleKitResizingBehaviorAspectFill, //!< The content is proportionally resized to completely fill the target rectangle.
  StyleKitResizingBehaviorStretch, //!< The content is stretched to match the entire target rectangle.
  StyleKitResizingBehaviorCenter, //!< The content is centered in the target rectangle, but it is NOT resized.
} StyleKitResizingBehavior;

extern CGRect StyleKitResizingBehaviorApply(StyleKitResizingBehavior behavior, CGRect rect, CGRect target);


#pragma mark - Canvas Drawings

//! Page 1
+ (void)drawAddButton;
+ (void)draw_120IPhoneWithFrame:(CGRect)targetFrame resizing:(StyleKitResizingBehavior)resizing;


#pragma mark - Canvas Images

//! Page 1
+ (UIImage *)imageOf_120IPhone;


@end
