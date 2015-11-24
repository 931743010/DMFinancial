//
//  DMTabBarViewController.m
//  DamaiIphone
//
//  Created by lixiang on 13-12-19.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMTabBarViewController.h"

#define kCustomerTabbarHeight 50

@interface DMTabBarViewController () {
    NSMutableArray                  *_items;
}

@end

@implementation DMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    CGRect rect = {
        .origin.x = 0,
        .origin.y = 0,
        .size.width = [UIScreen mainScreen].applicationFrame.size.width,
        .size.height = kCustomerTabbarHeight,
    };
    UIView *customerTabbar = [[UIView alloc] initWithFrame:rect];
    customerTabbar.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1];
    customerTabbar.tag = 100;
    [self.tabBar addSubview:customerTabbar];
    [self.tabBar bringSubviewToFront:customerTabbar];
    self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"botton_bg.png"];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setViewControllers:(NSArray *)viewControllers {
    [super setViewControllers:viewControllers];
    _items = [[NSMutableArray alloc] initWithCapacity:[viewControllers count]];
    UIView *customerTabbar = [self.tabBar viewWithTag:100];
    CGFloat x = 0.0;
    CGFloat itemWidth = [UIScreen mainScreen].applicationFrame.size.width / self.viewControllers.count;
    for (int i = 0 ; i < [self.viewControllers count]; i++) {
        CGRect rect = {
            .origin.x = x,
            .origin.y = 0,
            .size.width = itemWidth,
            .size.height = kCustomerTabbarHeight,
        };
        x += itemWidth;
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.frame = rect;
        item.tag = 1000+i;
        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [customerTabbar addSubview:item];
        [_items addObject:item];
    }
}

- (void)setImages:(NSArray *)images selectedImages:(NSArray *)selectedImages {
    for (int i = 0 ; i < [_items count] ; i++) {
        UIButton *item = [_items objectAtIndex:i];
        UIImage *image = [images objectAtIndex:i];
        UIImage *selectedImage = [selectedImages objectAtIndex:i];
        if (image) {
            [item setImage:image forState:UIControlStateNormal];
        }
        if (selectedImage) {
            [item setImage:selectedImage forState:UIControlStateSelected];
        }
        [item setBackgroundImage:[UIImage imageNamed:@"bottom_bg.png"] forState:UIControlStateNormal];
        [item setBackgroundImage:[UIImage imageNamed:@"bottom_bg.png"] forState:UIControlStateSelected];
    }
}

#pragma mark ========== Button Action ==========
- (void)itemClick:(id)sender {
    [self setSelectedIndex:[(UIButton *)sender tag] -1000];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    
    UIButton *selectedButton = [_items objectAtIndex:selectedIndex];
    for(UIButton *button in _items) {
        button.selected = NO;
    }
    selectedButton.selected = YES;
}

@end
