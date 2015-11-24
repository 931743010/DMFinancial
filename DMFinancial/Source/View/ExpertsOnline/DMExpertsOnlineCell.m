//
//  DMExpertsOnlineCell.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/16.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMExpertsOnlineCell.h"

@implementation DMExpertsOnlineCell {
    UILabel *_nameLabel;//名字
    UILabel *_zhichengLabel;//元老
    UIImageView *_iconImageView;//V标识
    UILabel *_descLabel;//描述
    UILabel *_descLabel1;//描述1
    UIImageView *_kongxianImageView;//空闲

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
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    topView.backgroundColor = [UIColor colorWithHexString:@"e9e9e9"];
    [self.contentView addSubview:topView];
    
    [self drawSolidLineWithFrame:CGRectMake(0, topView.bottom, kScreenWidth, 0.5) color:kSeperatorColor];
    
    _nameLabel = [self createLabelWithTextColor:[UIColor colorWithHexString:@"999999"] font:FONT(14) textAlignment:NSTextAlignmentLeft text:@""];
    _zhichengLabel = [self createLabelWithTextColor:[UIColor colorWithHexString:@"999999"] font:FONT(12) textAlignment:NSTextAlignmentLeft text:@""];
    _descLabel = [self createLabelWithTextColor:kDMDefaultBlackStringColor font:FONT(12) textAlignment:NSTextAlignmentLeft text:@""];
    _descLabel1 = [self createLabelWithTextColor:kDMDefaultBlackStringColor font:FONT(12) textAlignment:NSTextAlignmentLeft text:@""];

    _biaoshiLabel = [self createLabelWithTextColor:kDMPinkColor font:FONT(15) textAlignment:NSTextAlignmentLeft text:@""];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _iconImageView.image = [UIImage imageWithResourcesPathCompontent:@"icon_biaoshi.png"];
    [self.contentView addSubview:_iconImageView];

    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15 + topView.bottom, 56, 56)];
    _headImageView.image = [UIImage imageWithSize:CGSizeMake(80, 80) color:kDMPinkColor];
    _headImageView.layer.cornerRadius = 56/2;
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.borderColor = kSeperatorColor.CGColor;
    _headImageView.layer.borderWidth = 0.5;
    [self.contentView addSubview:_headImageView];
    
    _zixunButton = [[DMButton alloc] initWithFrame:CGRectMake(15, 45, 80, 24)];
    _zixunButton.right = kScreenWidth - AUTOSIZE(15);
    [_zixunButton setTitle:@"向他咨询" forState:UIControlStateNormal];
    [_zixunButton.titleLabel setFont:FONT(12)];
    [_zixunButton setBackgroundImage:[UIImage imageWithResourcesPathCompontent:@"icon_list_zixunButton.png"] forState:UIControlStateNormal];
    [_zixunButton buttonClickedcompletion:^(id returnData) {
        if (_delegate && [_delegate respondsToSelector:@selector(recordsWithSpid:)]) {
            [_delegate recordsWithSpid:self.myAttentionItem.spid];
        }
    }];
    [self.contentView addSubview:_zixunButton];
    
    _kongxianImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, _headImageView.bottom + 4, 47, 15)];
    _kongxianImageView.image = [UIImage imageWithResourcesPathCompontent:@"icon_list_kongxian.png"];
    [self.contentView addSubview:_kongxianImageView];

}

-(void)setMyAttentionItem:(DMSplist *)myAttentionItem {
    _myAttentionItem = myAttentionItem;
    
    
    _nameLabel.text = myAttentionItem.name;
    _zhichengLabel.text =myAttentionItem.leveltitle;
    _descLabel.text = [NSString stringWithFormat:@"%@ %@",myAttentionItem.city, myAttentionItem.cert];
    _descLabel1.text = myAttentionItem.title;
    _biaoshiLabel.text = myAttentionItem.goods;
    if (myAttentionItem.State .integerValue == 0) {
        _kongxianImageView.image = [UIImage imageWithResourcesPathCompontent:@"icon_list_kongxian.png"];
    } else {
        _kongxianImageView.image = [UIImage imageWithResourcesPathCompontent:@"icon_list_manglu.png"];
    }
    
    _nameLabel.frame = CGRectMake(_headImageView.right + 20, _headImageView.top, 200, AUTOSIZE(18));
    [_nameLabel adjustFontWithMaxSize:CGSizeMake(150, 20)];
    _iconImageView.frame = CGRectMake(_nameLabel.right + 10, _nameLabel.top, 14, 14);
    _zhichengLabel.frame = CGRectMake(_iconImageView.right + 5, _nameLabel.top + 2, 120, AUTOSIZE(12));

    _descLabel.frame = CGRectMake(_nameLabel.left, _nameLabel.bottom + 5, kScreenWidth - _nameLabel.left - 10, AUTOSIZE(13));
    _descLabel1.frame = CGRectMake(_nameLabel.left, _descLabel.bottom + 5, kScreenWidth - _nameLabel.left - 10, AUTOSIZE(13));

    _biaoshiLabel.frame = CGRectMake(_nameLabel.left, _descLabel1.bottom + 10, _descLabel.width, 14);
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
