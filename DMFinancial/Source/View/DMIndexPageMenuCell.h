//
//  DMIndexPageMenuCell.h
//  DamaiPlayPhone
//
//  Created by 陈彦岐 on 15/8/28.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//
#import "DMTableViewCell.h"

//首页发现菜单
typedef NS_ENUM(NSUInteger, DMIndexPageMenuType) {
    DMIndexPageMenuTypeNewcomer = 1,
    DMIndexPageMenuTypeYangmao = 2,
    DMIndexPageMenuTypeP2P = 3,
    DMIndexPageMenuTypeHotList = 4,
};

@protocol DMIndexPageMenuCellDelegate <NSObject>

@optional
-(void)menuAction:(DMIndexPageMenuType)type;

@end

@interface DMIndexPageMenuCell : DMTableViewCell
@property (nonatomic, assign) id<DMIndexPageMenuCellDelegate> delegate;
@end
