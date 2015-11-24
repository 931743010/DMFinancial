//
//  DMCircleView.m
//  DamaiIphone
//
//  Created by lixiang on 14-1-11.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "DMCircleView.h"

@interface DMCircleView () {
    CAShapeLayer *_circleLayer;
}

@end

@implementation DMCircleView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _thickness = 1.0f;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat width = CGRectGetWidth(self.bounds) < CGRectGetHeight(self.bounds) ? (int)CGRectGetWidth(self.bounds)/2 : (int)CGRectGetHeight(self.bounds)/2;
    CALayer *layer = [self layer];
    CGFloat radius = width;
    [layer setMasksToBounds:YES];
    layer.backgroundColor = self.fillColor.CGColor;
    layer.borderColor = self.stokeColor.CGColor;
    layer.borderWidth = self.thickness;
    layer.cornerRadius = radius;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
