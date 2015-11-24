//
//  DMPicker.h
//  DamaiPlayPhone
//
//  Created by Joseph Fu on 15/1/19.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMPicker : UIViewController

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *containerView;

- (void)cancel:(UIButton *)button;
- (void)confirm:(UIButton *)button;
- (void)removeFromScreen;
- (void)showFromViewController:(UIViewController *)viewController;


@end
