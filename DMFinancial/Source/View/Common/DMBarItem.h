//
//  DMBarItem.h
//  DamaiHD
//
//  Created by lixiang on 13-10-21.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMBarItem : UIView

@property (nonatomic, assign) BOOL    selected;
@property (nonatomic, assign) BOOL    itemTag;
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *normalTitleColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;
@property (nonatomic, strong) UIColor *normalBgColor;
@property (nonatomic, strong) UIColor *selectedBgColor;

@end
