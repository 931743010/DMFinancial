//
//  DMTabBarViewController.h
//  DamaiIphone
//
//  Created by lixiang on 13-12-19.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMTabBarViewController : UITabBarController

@property (nonatomic, strong) NSArray *barItems;

- (void)setImages:(NSArray *)images selectedImages:(NSArray *)selectedImages;

@end
