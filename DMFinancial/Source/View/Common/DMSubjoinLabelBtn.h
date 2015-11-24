//
//  DMSubjoinLabelBtn.h
//  DamaiPlayPhone
//
//  Created by SongDong on 14-12-29.
//  Copyright (c) 2014年 陈彦岐. All rights reserved.
//  button增加一个label标签 右上角显示数量

#import <UIKit/UIKit.h>

@interface DMSubjoinLabelBtn : UIButton

@property(nonatomic, strong) UILabel *flexibleLabel;

@property(nonatomic, strong) UIImageView *bgImageView;  //自定义按钮的背景图片

-(id)initWithTitle:(NSString *)title frame:(CGRect)frame;

@end
