//
//  CustomView.m
//  bro
//
//  Created by g tokman on 5/6/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

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
                      byRoundingCorners: UIRectCornerAllCorners
                      cornerRadii:CGSizeMake(10, 10)].CGPath;
    self.layer.mask = maskLayer;
    
}

@end
