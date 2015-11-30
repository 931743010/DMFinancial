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
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth - 10, 15)];
    _titleLabel.textColor = kDMDefaultBlackStringColor;
    _titleLabel.font = FONT(14);
    [self.contentView addSubview:_titleLabel];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth - 10, 15)];
    _timeLabel.textColor = kDMDefaultBlackStringColor;
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.font = FONT(14);
    [self.contentView addSubview:_timeLabel];

    _contentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, kScreenWidth - 10, 15)];
    _contentsLabel.textColor = kDMDefaultBlackStringColor;
    _contentsLabel.font = FONT(14);
    [self.contentView addSubview:_contentsLabel];

    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
    _iconImageView.image = [UIImage imageWithBaseImage:[UIImage imageWithSize:CGSizeMake(6, 6) color:[UIColor redColor]] roundedCornersSize:3 imageSize:CGSizeMake(6, 6)];
    [self.contentView addSubview:_iconImageView];
}

-(void)setItem:(DMMessageItem *)item {
    _item = item;
    _titleLabel.text = item.title;
    _timeLabel.text = item.time;
    _contentsLabel.text = item.contents;
    _iconImageView.hidden = !item.isNewMessage;

}

@end
