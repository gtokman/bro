//
//  AddButtonView.m
//  bro
//
//  Created by g tokman on 4/20/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "AddButtonView.h"

@interface AddButtonView ()

@property BOOL isPressed;

@end
@implementation AddButtonView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //// General Declarations
    [self drawCustomAddButtonWithIsPressed:self.isPressed];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.pressedColor = [UIColor colorWithRed: 0.792 green: 0.792 blue: 0.792 alpha: 0.25];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super initWithCoder:aDecoder]) {
        self.pressedColor = [UIColor colorWithRed: 0.792 green: 0.792 blue: 0.792 alpha: 0.25];
    }
    return self;
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

- (void)drawCustomAddButtonWithIsPressed: (BOOL)isPressed
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
   // UIColor* pressedColor = [UIColor colorWithRed: 0.792 green: 0.792 blue: 0.792 alpha: 0.25];
    UIColor* addColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* regularColor = [UIColor colorWithRed: 0.69 green: 0.714 blue: 0.733 alpha: 0.5];
    
    //// Shadow Declarations
    NSShadow* buttonShadow = [[NSShadow alloc] init];
    buttonShadow.shadowColor = [UIColor.blackColor colorWithAlphaComponent: 0.7];
    buttonShadow.shadowOffset = CGSizeMake(-1, -1);
    buttonShadow.shadowBlurRadius = 4;
    
    //// regular
    {
        //// addButtonBg Drawing
        UIBezierPath* addButtonBgPath = [UIBezierPath bezierPath];
        [addButtonBgPath moveToPoint: CGPointMake(96, 5)];
        [addButtonBgPath addLineToPoint: CGPointMake(96, 96)];
        [addButtonBgPath addLineToPoint: CGPointMake(5, 96)];
        [addButtonBgPath addCurveToPoint: CGPointMake(30.78, 32.61) controlPoint1: CGPointMake(5, 96) controlPoint2: CGPointMake(5, 61.24)];
        [addButtonBgPath addCurveToPoint: CGPointMake(96, 5) controlPoint1: CGPointMake(56.57, 3.98) controlPoint2: CGPointMake(96, 5)];
        [addButtonBgPath closePath];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, buttonShadow.shadowOffset, buttonShadow.shadowBlurRadius, [buttonShadow.shadowColor CGColor]);
        addButtonBgPath.usesEvenOddFillRule = YES;
        [regularColor setFill];
        [addButtonBgPath fill];
        CGContextRestoreGState(context);
        
        
        
        //// addIcon Drawing
        UIBezierPath* addIconPath = [UIBezierPath bezierPath];
        [addIconPath moveToPoint: CGPointMake(62.69, 50.64)];
        [addIconPath addLineToPoint: CGPointMake(62.69, 40.53)];
        [addIconPath addCurveToPoint: CGPointMake(60.17, 38) controlPoint1: CGPointMake(62.69, 39.13) controlPoint2: CGPointMake(61.56, 38)];
        [addIconPath addCurveToPoint: CGPointMake(57.64, 40.53) controlPoint1: CGPointMake(58.76, 38) controlPoint2: CGPointMake(57.64, 39.13)];
        [addIconPath addLineToPoint: CGPointMake(57.64, 50.64)];
        [addIconPath addLineToPoint: CGPointMake(47.53, 50.64)];
        [addIconPath addCurveToPoint: CGPointMake(45, 53.17) controlPoint1: CGPointMake(46.13, 50.64) controlPoint2: CGPointMake(45, 51.77)];
        [addIconPath addCurveToPoint: CGPointMake(47.53, 55.69) controlPoint1: CGPointMake(45, 54.57) controlPoint2: CGPointMake(46.13, 55.69)];
        [addIconPath addLineToPoint: CGPointMake(57.64, 55.69)];
        [addIconPath addLineToPoint: CGPointMake(57.64, 65.8)];
        [addIconPath addCurveToPoint: CGPointMake(60.17, 68.33) controlPoint1: CGPointMake(57.64, 67.2) controlPoint2: CGPointMake(58.77, 68.33)];
        [addIconPath addCurveToPoint: CGPointMake(62.69, 65.8) controlPoint1: CGPointMake(61.57, 68.33) controlPoint2: CGPointMake(62.69, 67.2)];
        [addIconPath addLineToPoint: CGPointMake(62.69, 55.69)];
        [addIconPath addLineToPoint: CGPointMake(72.8, 55.69)];
        [addIconPath addCurveToPoint: CGPointMake(75.33, 53.17) controlPoint1: CGPointMake(74.2, 55.69) controlPoint2: CGPointMake(75.33, 54.56)];
        [addIconPath addCurveToPoint: CGPointMake(72.8, 50.64) controlPoint1: CGPointMake(75.33, 51.76) controlPoint2: CGPointMake(74.2, 50.64)];
        [addIconPath addLineToPoint: CGPointMake(62.69, 50.64)];
        [addIconPath closePath];
        addIconPath.usesEvenOddFillRule = YES;
        [addColor setFill];
        [addIconPath fill];
    }
    
    
    //// overlay
    {
        if (isPressed)
        {
            //// addButtonBg 2 Drawing
            UIBezierPath* addButtonBg2Path = [UIBezierPath bezierPath];
            [addButtonBg2Path moveToPoint: CGPointMake(96, 5)];
            [addButtonBg2Path addLineToPoint: CGPointMake(96, 96)];
            [addButtonBg2Path addLineToPoint: CGPointMake(5, 96)];
            [addButtonBg2Path addCurveToPoint: CGPointMake(30.78, 32.61) controlPoint1: CGPointMake(5, 96) controlPoint2: CGPointMake(5, 61.24)];
            [addButtonBg2Path addCurveToPoint: CGPointMake(96, 5) controlPoint1: CGPointMake(56.57, 3.98) controlPoint2: CGPointMake(96, 5)];
            [addButtonBg2Path closePath];
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, buttonShadow.shadowOffset, buttonShadow.shadowBlurRadius, [buttonShadow.shadowColor CGColor]);
            addButtonBg2Path.usesEvenOddFillRule = YES;
            [self.pressedColor setFill];
            [addButtonBg2Path fill];
            CGContextRestoreGState(context);
            
        }
        
        
        //// addIcon 2 Drawing
        UIBezierPath* addIcon2Path = [UIBezierPath bezierPath];
        [addIcon2Path moveToPoint: CGPointMake(62.69, 50.64)];
        [addIcon2Path addLineToPoint: CGPointMake(62.69, 40.53)];
        [addIcon2Path addCurveToPoint: CGPointMake(60.17, 38) controlPoint1: CGPointMake(62.69, 39.13) controlPoint2: CGPointMake(61.56, 38)];
        [addIcon2Path addCurveToPoint: CGPointMake(57.64, 40.53) controlPoint1: CGPointMake(58.76, 38) controlPoint2: CGPointMake(57.64, 39.13)];
        [addIcon2Path addLineToPoint: CGPointMake(57.64, 50.64)];
        [addIcon2Path addLineToPoint: CGPointMake(47.53, 50.64)];
        [addIcon2Path addCurveToPoint: CGPointMake(45, 53.17) controlPoint1: CGPointMake(46.13, 50.64) controlPoint2: CGPointMake(45, 51.77)];
        [addIcon2Path addCurveToPoint: CGPointMake(47.53, 55.69) controlPoint1: CGPointMake(45, 54.57) controlPoint2: CGPointMake(46.13, 55.69)];
        [addIcon2Path addLineToPoint: CGPointMake(57.64, 55.69)];
        [addIcon2Path addLineToPoint: CGPointMake(57.64, 65.8)];
        [addIcon2Path addCurveToPoint: CGPointMake(60.17, 68.33) controlPoint1: CGPointMake(57.64, 67.2) controlPoint2: CGPointMake(58.77, 68.33)];
        [addIcon2Path addCurveToPoint: CGPointMake(62.69, 65.8) controlPoint1: CGPointMake(61.57, 68.33) controlPoint2: CGPointMake(62.69, 67.2)];
        [addIcon2Path addLineToPoint: CGPointMake(62.69, 55.69)];
        [addIcon2Path addLineToPoint: CGPointMake(72.8, 55.69)];
        [addIcon2Path addCurveToPoint: CGPointMake(75.33, 53.17) controlPoint1: CGPointMake(74.2, 55.69) controlPoint2: CGPointMake(75.33, 54.56)];
        [addIcon2Path addCurveToPoint: CGPointMake(72.8, 50.64) controlPoint1: CGPointMake(75.33, 51.76) controlPoint2: CGPointMake(74.2, 50.64)];
        [addIcon2Path addLineToPoint: CGPointMake(62.69, 50.64)];
        [addIcon2Path closePath];
        addIcon2Path.usesEvenOddFillRule = YES;
        [addColor setFill];
        [addIcon2Path fill];
    }
}

@end
