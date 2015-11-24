//
//  DMCellNumberView.h
//  DamaiIphone
//
//  Created by 陈彦岐 on 14-2-17.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMCellNumberView : UIView

//项目列表的序号，（显示序列号）
@property(nonatomic,assign)int index;
@property(nonatomic,strong)UIColor *color;


-(id)initWithFrame:(CGRect)frame withIndex:(int)index withColor:(UIColor *)color;

@end
