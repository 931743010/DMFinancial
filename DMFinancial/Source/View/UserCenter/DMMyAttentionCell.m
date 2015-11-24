//
//  DMMyAttentionCell.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/10.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMMyAttentionCell.h"

@implementation DMMyAttentionCell {
    UILabel *_nameLabel;//名字
    UILabel *_zhichengLabel;//元老
    UIImageView *_iconImageView;//V标识
    UILabel *_descLabel;//描述
    UILabel *_biaoshiLabel;//关键字
    UILabel *_changedMoneyLabel;//改变的镖银
    
    UIImageView *_headImageView;//头像
    DMButton *_zixunButton;//向他咨询
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    topView.backgroundColor = [UIColor colorWithHexString:@"e9e9e9"];
    [self.contentView addSubview:topView];
    
    [self drawSolidLineWithFrame:CGRectMake(0, topView.bottom, kScreenWidth, 0.5) color:kSeperatorColor];
    
    _nameLabel = [self createLabelWithTextColor:[UIColor colorWithHexString:@"999999"] font:FONT(17) textAlignment:NSTextAlignmentLeft text:@""];
    _zhichengLabel = [self createLabelWithTextColor:[UIColor colorWithHexString:@"999999"] font:FONT(12) textAlignment:NSTextAlignmentLeft text:@""];
    _descLabel = [self createLabelWithTextColor:kDMDefaultBlackStringColor font:FONT(12) textAlignment:NSTextAlignmentLeft text:@""];
    _descLabel.numberOfLines = 0;
    _biaoshiLabel = [self createLabelWithTextColor:kDMPinkColor font:FONT(15) textAlignment:NSTextAlignmentLeft text:@""];

    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10 + topView.bottom, 80, 80)];
    _headImageView.image = [UIImage imageWithSize:CGSizeMake(80, 80) color:kDMPinkColor];
    _headImageView.layer.cornerRadius = 40;
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.borderColor = kSeperatorColor.CGColor;
    _headImageView.layer.borderWidth = 0.5;
    [self.contentView addSubview:_headImageView];
    
    _zixunButton = [[DMButton alloc] initWithFrame:CGRectMake(15, _headImageView.bottom + 5, 80, 24)];
    [_zixunButton setTitle:@"向他咨询" forState:UIControlStateNormal];
    [_zixunButton.titleLabel setFont:FONT(14)];
    [_zixunButton setBackgroundImage:[UIImage imageWithResourcesPathCompontent:@"icon_list_zixunButton.png"] forState:UIControlStateNormal];
    [_zixunButton buttonClickedcompletion:^(id returnData) {
        
    }];
    [self.contentView addSubview:_zixunButton];
    
    
}

-(void)setMyAttentionItem:(NSString *)myAttentionItem {
    _myAttentionItem = myAttentionItem;

    
    _nameLabel.text = @"登录登录奖励登录奖励登录奖励登录奖励登录奖励奖励";
    _zhichengLabel.text = @"元老";
    _descLabel.text = @"北京 认证会员 身份认证\n2014年度全国优秀HR";
    _biaoshiLabel.text = @"国企       央企      民营";
    
    _nameLabel.frame = CGRectMake(_headImageView.right + 30, 10 + 15, 200, AUTOSIZE(18));
    [_nameLabel adjustFontWithMaxSize:CGSizeMake(150, 20)];
    _zhichengLabel.frame = CGRectMake(_nameLabel.right + 40, 10 + 22, 120, AUTOSIZE(12));
    _descLabel.frame = CGRectMake(_nameLabel.left, _nameLabel.bottom + 5, kScreenWidth - _nameLabel.left - 10, AUTOSIZE(13));

    _biaoshiLabel.frame = CGRectMake(_nameLabel.left, _zixunButton.top, _descLabel.width, 24);
    [_descLabel adjustFontWithMaxSize:CGSizeMake(_descLabel.width, 30)];

}

- (UILabel *)createLabelWithTextColor:(UIColor *)color font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text {
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.textAlignment =textAlignment;
    lable.textColor = color;
    lable.text = text;
    lable.font = font;
    [self.contentView addSubview:lable];
    return lable;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
