//
//  DMManagementItemCell.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/25.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMManagementItemCell.h"

@implementation DMManagementItemCell {
    UILabel *_nameLabel;//资产名称
    UILabel *_numberLabel;//资产数量
    UILabel *_yieldLabel;//收益率
    UILabel *_dayGainsLabel;//日收益
    UIImageView *_bgImageView;//背景图片
    UIImageView *_iconBadgeImageView;//新增收益提示图标
    DMButton *_delButton;//删除按钮
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews {
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.width - 10, 14)];
    _nameLabel.font = FONT(13);
    [self addSubview:_nameLabel];
    
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.width - 10, self.height)];
    _numberLabel.font = FONT(17);
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_numberLabel];

    _yieldLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.height - 14, self.width - 10, 14)];
    _yieldLabel.textAlignment = NSTextAlignmentLeft;
    _yieldLabel.font = FONT(13);
    [self addSubview:_yieldLabel];

    _dayGainsLabel = [[UILabel alloc] initWithFrame:_yieldLabel.frame];
    _dayGainsLabel.font = FONT(13);
    _dayGainsLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_dayGainsLabel];

    _iconBadgeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 1, -1, 2, 2)];
    _iconBadgeImageView.backgroundColor = [UIColor redColor];
    [self addSubview:_iconBadgeImageView];
    
    _delButton = [[DMButton alloc] initWithFrame:CGRectMake(self.width - 10, -10, 20, 20)];
    _delButton.backgroundColor = [UIColor redColor];
    _delButton.hidden = YES;
    [_delButton buttonClickedcompletion:^(id returnData) {
        
    }];
    [self addSubview:_delButton];
    
    
}

-(void)setItem:(DMManagementItem *)item {
    _item = item;
    _nameLabel.text = item.name;
    _numberLabel.text = item.number;
    _yieldLabel.text = item.yield;
    _dayGainsLabel.text = item.dayGains;
    _iconBadgeImageView.hidden = !item.hasNew;
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:item.url] placeholderImage:nil];
}

-(void)setShowDelButton:(BOOL)showDelButton {
    _showDelButton = showDelButton;
    _delButton.hidden = !showDelButton;
}

@end
