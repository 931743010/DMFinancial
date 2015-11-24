//
//  DMExpertsOnlineConsultCell.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/16.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMExpertsOnlineConsultCell.h"

@implementation DMExpertsOnlineConsultCell {
    UILabel *_nameLabel;
    UILabel *_timeLabel;
    UILabel *_messageLabel;
    UIImageView *_headImageView;
    UIImageView *_countImageView;
    UILabel *_countLabel;
    
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
    

    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10 + topView.bottom, 63, 63)];
    _headImageView.image = [UIImage imageWithSize:CGSizeMake(80, 80) color:kDMPinkColor];
    _headImageView.layer.cornerRadius = 63/2;
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.borderColor = kSeperatorColor.CGColor;
    _headImageView.layer.borderWidth = 0.5;
    [self.contentView addSubview:_headImageView];
    
    _countImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_headImageView.right + 3 - 20, _headImageView.top - 3, 20, 20)];
    _countImageView.image = [UIImage imageWithColor:[UIColor colorWithHexString:@"f46c6b"] size:CGSizeMake(20, 20)];
    _countImageView.layer.cornerRadius = 10;
    _countImageView.clipsToBounds = YES;

    [self.contentView addSubview:_countImageView];
    
    _nameLabel = [self createLabelWithTextColor:kDMDefaultBlackStringColor font:FONT(12) textAlignment:NSTextAlignmentLeft text:@""];
    _timeLabel = [self createLabelWithTextColor:kDMDefaultGrayStringColor font:FONT(9) textAlignment:NSTextAlignmentRight text:@""];
    
    _messageLabel = [self createLabelWithTextColor:kDMDefaultGrayStringColor font:FONT(9) textAlignment:NSTextAlignmentLeft text:@""];
    _messageLabel.numberOfLines = 0;
    _countLabel = [self createLabelWithTextColor:[UIColor whiteColor] font:FONT(12) textAlignment:NSTextAlignmentCenter text:@""];


    _nameLabel.frame = CGRectMake(_headImageView.right + 15, topView.bottom + 8, 170, AUTOSIZE(13));
    _timeLabel.frame = CGRectMake(kScreenWidth - 200 - AUTOSIZE(15), topView.bottom + 14, 200, AUTOSIZE(10));
    _messageLabel.frame = CGRectMake(_nameLabel.left, _nameLabel.bottom + 8, kScreenWidth - _headImageView.right - AUTOSIZE(30), 95 - _nameLabel.bottom - 8 - 15);
    _countLabel.frame = _countImageView.frame;


}

-(void)setItem:(DMRecordsListItem *)item {
    if (!item) {
        return;
    }
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:item.headimgid] placeholderImage:[UIImage imageWithSize:CGSizeMake(80, 80) color:kDMPinkColor]];
    _nameLabel.text = item.name;
    _timeLabel.text = item.lastmsgtime;
    _messageLabel.text = item.lastmsg;
    if ([item.noread isEqualToString:@"0"] || !item.noread) {
        _countLabel.hidden = YES;
        _countImageView.hidden = YES;
    } else {
        _countLabel.hidden = NO;
        _countImageView.hidden = NO;
        _countLabel.text = item.noread;
    }
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

@end
