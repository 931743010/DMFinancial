//
//  DMTableViewHeaderView.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/11.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMTableViewHeaderView.h"

@implementation DMTableViewHeaderView {
    UILabel *_titleLabel;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews {
    self.backgroundColor = kTableViewBgColor;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.width - 20, self.height)];
    _titleLabel.text = @"";
    _titleLabel.textColor = kDMDefaultBlackStringColor;
    _titleLabel.font = FONT(13);
    [self addSubview:_titleLabel];
}

-(void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

@end
