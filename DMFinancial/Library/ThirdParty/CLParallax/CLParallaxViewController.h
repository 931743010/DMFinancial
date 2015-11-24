//
//  CLParallaxViewController.h
//  CLParallaxViewController
//
//  Created by lixiang on 14-4-16.
//  Copyright (c) 2014年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLParallaxViewController : UIViewController 

@property (nonatomic, strong) UIView        *parallaxContentView;
@property (nonatomic, strong) UIScrollView  *rootView;
@property (nonatomic, assign) CGFloat       parallaxHeight;

- (void)configWithParallaxContentView:(UIView *)parallaxContentView
                             rootView:(UIScrollView *)rootView
                       parallaxHeight:(CGFloat)parallaxHeight;
@end
