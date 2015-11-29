//
//  JFSwipeUnderneathIndicateView.m
//  DamaiPlayPhone
//
//  Created by Joseph Fu on 15/2/4.
//  Copyright (c) 2015年 Joseph Fu. All rights reserved.
//

#import "JFSwipeUnderneathIndicateView.h"

@interface JFSwipeUnderneathIndicateView ()

@property (strong, nonatomic) CAShapeLayer *maskLayer;

@end

@implementation JFSwipeUnderneathIndicateView
@synthesize imageView = _imageView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self addSubview:self.imageView];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(self, _imageView);
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_imageView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_imageView]-8-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
    }
    return self;
}


- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
    }
    return _imageView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
