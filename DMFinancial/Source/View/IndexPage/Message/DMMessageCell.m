//
//  DMMessageCell.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/30.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMMessageCell.h"

@implementation DMMessageCell {
    UILabel *_titleLabel;
    UILabel *_timeLabel;
    UILabel *_contentsLabel;
    UIImageView *_iconImageView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.height = 108;
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 19, kScreenWidth - 32, 17)];
    _titleLabel.textColor = kDMDefaultBlackStringColor;
    _titleLabel.font = BOLDFONT(15);
    [self.contentView addSubview:_titleLabel];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, _titleLabel.bottom + 9, kScreenWidth - 32, 14)];
    _timeLabel.textColor = kDMDefaultLightGrayStringColor;
    _timeLabel.font = FONT(12);
    [self.contentView addSubview:_timeLabel];

    _contentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 30, kScreenWidth - 32, 15)];
    _contentsLabel.textColor = kDMDefaultGrayStringColor;
    _contentsLabel.font = FONT(14);
    _contentsLabel.bottom = self.height - 20;
    [self.contentView addSubview:_contentsLabel];

    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 20 + 3, 10, 10)];
    _iconImageView.image = [UIImage imageWithBaseImage:[UIImage imageWithSize:CGSizeMake(6, 6) color:[UIColor redColor]] roundedCornersSize:3 imageSize:CGSizeMake(6, 6)];
    [self.contentView addSubview:_iconImageView];
}

-(void)setItem:(DMMessageItem *)item {
    _item = item;
    _titleLabel.text = item.title;
    _timeLabel.text = item.time;
    _contentsLabel.text = item.contents;
    _iconImageView.hidden = !item.isNewMessage;
    
    if (item.isNewMessage) {
        _titleLabel.frame = CGRectMake(32, 19, kScreenWidth - 16 - 32, 17);
    }
    else {
        _titleLabel.frame = CGRectMake(16, 19, kScreenWidth - 32, 17);
    }
}

@end
