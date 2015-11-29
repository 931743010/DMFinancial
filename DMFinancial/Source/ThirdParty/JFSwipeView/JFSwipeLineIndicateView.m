//
//  JFSwipeLineIndicateView.m
//  DamaiPlayPhone
//
//  Created by 付书炯 on 15/4/15.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "JFSwipeLineIndicateView.h"
#import "UIView+JFLayout.h"

@interface JFSwipeLineIndicateView ()

@property (nonatomic, strong) UIView *colorView;

@end
@implementation JFSwipeLineIndicateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _colorView = [[UIView alloc] initWithFrame:frame];
        _colorView.layer.cornerRadius = 1.5;
        _colorView.layer.borderWidth = 0.5;
        _colorView.layer.masksToBounds = YES;
        _colorView.layer.borderColor = [UIColor clearColor].CGColor;
        [self addSubview:_colorView];
        [_colorView jf_pinEdge:JFEdgeLeft toEdge:JFEdgeLeft ofView:self withOffset:8 priority:UILayoutPriorityDefaultHigh];
        [_colorView jf_pinEdge:JFEdgeRight toEdge:JFEdgeRight ofView:self withOffset:-8 priority:UILayoutPriorityDefaultHigh];
        [_colorView jf_pinEdgeToSuperviewEdge:JFEdgeTop withInset:0];
        [_colorView jf_pinEdgeToSuperviewEdge:JFEdgeBottom withInset:0];
    }
    return self;
}

- (void)setLineColor:(UIColor *)lineColor
{
    if (_lineColor != lineColor) {
        _lineColor = lineColor;
        self.colorView.layer.borderColor = _lineColor.CGColor;
        self.colorView.backgroundColor = _lineColor;
    }
}

@end
