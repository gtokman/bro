//
//  CustomNavBar.m
//  bro
//
//  Created by g tokman on 4/24/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "CustomNavBar.h"

@implementation CustomNavBar

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.path = [UIBezierPath
                      bezierPathWithRoundedRect:self.bounds
                      byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                      cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)].CGPath;
    self.layer.mask = maskLayer;
    
}


@end
