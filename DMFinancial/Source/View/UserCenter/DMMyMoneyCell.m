//
//  DMMyMoneyCell.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/10.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMMyMoneyCell.h"

@implementation DMMyMoneyCell {
    UILabel *_nameLabel;//条目名称
    UILabel *_timeLabel;//镖银改变时间
    UILabel *_currentMoneyLabel;//当前镖银
    UILabel *_changedMoneyLabel;//改变的镖银
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    _nameLabel = [self createLabelWithTextColor:[UIColor colorWithHexString:@"999999"] font:FONT(10) textAlignment:NSTextAlignmentLeft text:@""];
    _timeLabel = [self createLabelWithTextColor:[UIColor colorWithHexString:@"999999"] font:FONT(10) textAlignment:NSTextAlignmentRight text:@""];
    _currentMoneyLabel = [self createLabelWithTextColor:kDMDefaultBlackStringColor font:FONT(12) textAlignment:NSTextAlignmentLeft text:@""];
    _changedMoneyLabel = [self createLabelWithTextColor:[UIColor colorWithHexString:@"39a618"] font:FONT(18) textAlignment:NSTextAlignmentRight text:@""];

    _nameLabel.frame = CGRectMake(AUTOSIZE(40), AUTOSIZE(10), 200, AUTOSIZE(10));
    _timeLabel.frame = CGRectMake(kScreenWidth - 120 - AUTOSIZE(40), AUTOSIZE(10), 120, AUTOSIZE(10));
    _currentMoneyLabel.frame = CGRectMake(AUTOSIZE(40), _nameLabel.bottom + 15, 200, AUTOSIZE(13));
    _changedMoneyLabel.frame = CGRectMake(_timeLabel.left, _currentMoneyLabel.top - AUTOSIZE(3), 120, AUTOSIZE(18));

}


-(void)setMoneyItem:(NSArray *)moneyItem {
    NSInteger money = [[moneyItem objectAt:3] integerValue];
    _moneyItem = moneyItem;
    _nameLabel.text = [moneyItem objectAt:0];
    _timeLabel.text = [moneyItem objectAt:1];
    _currentMoneyLabel.text = [NSString stringWithFormat:@"当前镖银:%@",[moneyItem objectAt:2]];
    if (money >= 0) {
        _changedMoneyLabel.textColor = [UIColor colorWithHexString:@"39a618"];
        _changedMoneyLabel.text = [NSString stringWithFormat:@"+%@",[moneyItem objectAt:3]];

    } else {
        _changedMoneyLabel.textColor = [UIColor colorWithHexString:@"d02d2d"];
        _changedMoneyLabel.text = [moneyItem objectAt:3];

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
