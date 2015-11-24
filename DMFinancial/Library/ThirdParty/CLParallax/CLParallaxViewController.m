//
//  CLParallaxViewController.m
//  CLParallaxViewController
//
//  Created by lixiang on 14-4-16.
//  Copyright (c) 2014年 lixiang. All rights reserved.
//

#import "CLParallaxViewController.h"

@interface CLParallaxViewController () <UITableViewDelegate, UIScrollViewDelegate>

@end

@implementation CLParallaxViewController 

- (void)configWithParallaxContentView:(UIView *)parallaxContentView
                             rootView:(UIScrollView *)rootView
                       parallaxHeight:(CGFloat)parallaxHeight {
    
    _parallaxContentView       = parallaxContentView;
    _rootView                  = rootView;
    _parallaxHeight            = parallaxHeight;
    
    parallaxContentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), _parallaxHeight);
    rootView.frame = self.view.bounds;
    rootView.contentInset = UIEdgeInsetsMake(_parallaxHeight, 0, 0, 0);
    rootView.backgroundColor = [UIColor clearColor];
    rootView.delegate = self;
    rootView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:parallaxContentView];
    [self.view addSubview:rootView];
}

#pragma mark ========== UIScrollViewDelegate ==========
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIView *parallaxContentView = self.parallaxContentView;
    
    CGFloat y = fabs(scrollView.contentOffset.y)-_parallaxHeight;
    CGRect newFrame;
    if (y > 0) {
        newFrame = CGRectMake(CGRectGetMinX(parallaxContentView.frame),
                              CGRectGetMinY(parallaxContentView.frame),
                              CGRectGetWidth(parallaxContentView.frame),
                              _parallaxHeight+y);
    } else {
        newFrame = CGRectMake(CGRectGetMinX(parallaxContentView.frame),
                              (int)(y*0.5),
                              CGRectGetWidth(parallaxContentView.frame),
                              CGRectGetHeight(parallaxContentView.frame));
    }
    parallaxContentView.frame = newFrame;
}


@end
