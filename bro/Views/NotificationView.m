//
//  NotificationView.m
//  bro
//
//  Created by g tokman on 4/20/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "NotificationView.h"

@interface NotificationView ()
@property BOOL isPressed;
@end

@implementation NotificationView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (void)setupDefaults {
    self.text = @"1";
    self.textSize = 18;
    self.bgColor = [UIColor colorWithRed: 0.342 green: 0.342 blue: 0.342 alpha: 1];
    self.pressedColor = [UIColor colorWithRed: 0.689 green: 0.689 blue: 0.689 alpha: 1];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self drawNotificationIconWithIsPressed:self.isPressed text:self.text textSize:self.textSize];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // [super touchesBegan:touches withEvent:event];
    self.isPressed = YES;
    [self setNeedsDisplay];
    NSLog(@"Touches began");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // [super touchesBegan:touches withEvent:event];
    self.isPressed = NO;
    [self setNeedsDisplay];
}

- (void)drawNotificationIconWithIsPressed: (BOOL)isPressed text: (NSString*)text textSize: (CGFloat)textSize
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Shadow Declarations
    NSShadow* shadow3 = [[NSShadow alloc] init];
    shadow3.shadowColor = UIColor.blackColor;
    shadow3.shadowOffset = CGSizeMake(0, 0);
    shadow3.shadowBlurRadius = 5;
    
    //// notifBg Drawing
    UIBezierPath* notifBgPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(9, 9, 70, 70)];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow3.shadowOffset, shadow3.shadowBlurRadius, [shadow3.shadowColor CGColor]);
    [self.bgColor setFill];
    [notifBgPath fill];
    CGContextRestoreGState(context);
    
    
    
    //// notificationText Drawing
    CGRect notificationTextRect = CGRectMake(40, 36, 9, 15);
    NSMutableParagraphStyle* notificationTextStyle = [[NSMutableParagraphStyle alloc] init];
    notificationTextStyle.alignment = NSTextAlignmentCenter;
    NSDictionary* notificationTextFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-Medium" size: textSize], NSForegroundColorAttributeName: UIColor.whiteColor, NSParagraphStyleAttributeName: notificationTextStyle};
    
    CGFloat notificationTextTextHeight = [text boundingRectWithSize: CGSizeMake(notificationTextRect.size.width, INFINITY) options: NSStringDrawingUsesLineFragmentOrigin attributes: notificationTextFontAttributes context: nil].size.height;
    CGContextSaveGState(context);
    CGContextClipToRect(context, notificationTextRect);
    [text drawInRect: CGRectMake(CGRectGetMinX(notificationTextRect), CGRectGetMinY(notificationTextRect) + (notificationTextRect.size.height - notificationTextTextHeight) / 2, notificationTextRect.size.width, notificationTextTextHeight) withAttributes: notificationTextFontAttributes];
    CGContextRestoreGState(context);
    
    
    if (isPressed)
    {
        //// overlay Drawing
        UIBezierPath* overlayPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(9, 9, 70, 70)];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadow3.shadowOffset, shadow3.shadowBlurRadius, [shadow3.shadowColor CGColor]);
        [self.pressedColor setFill];
        [overlayPath fill];
        CGContextRestoreGState(context);
        
    }
}
@end
