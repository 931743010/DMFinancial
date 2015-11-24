//
//  DMActivityCell.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/24.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMActivityCell.h"
#import "DMActivity.h"

@implementation DMActivityCell {
    UIView *_bgView;
    UIImageView *_bigImageView;
    
    UILabel *_nameLabel;//名称
    UILabel *_timeLabel;//时间
    UILabel *_descLabel;//
    UIView *_subView;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(AUTOSIZE(15), AUTOSIZE(15), kScreenWidth - AUTOSIZE(30), 0)];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.borderColor = kSeperatorColor.CGColor;
    _bgView.layer.borderWidth = 0.5;
    [self.contentView addSubview:_bgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(selecedCell)];
    [_bgView addGestureRecognizer:tap];
    _bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(AUTOSIZE(6), AUTOSIZE(6), _bgView.width - AUTOSIZE(12), AUTOSIZE(110))];
    [_bgView addSubview:_bigImageView];

    _nameLabel = [self createLabelWithTextColor:[UIColor colorWithHexString:@"999999"] font:FONT(12) textAlignment:NSTextAlignmentLeft text:@""];
    [_bgView addSubview:_nameLabel];
    _timeLabel = [self createLabelWithTextColor:[UIColor colorWithHexString:@"999999"] font:FONT(10) textAlignment:NSTextAlignmentRight text:@""];
    [_bgView addSubview:_timeLabel];

    _descLabel = [self createLabelWithTextColor:kDMDefaultBlackStringColor font:FONT(12) textAlignment:NSTextAlignmentLeft text:@""];
    [_bgView addSubview:_descLabel];

    _subView = [[UIView alloc] init];
    [_bgView addSubview:_subView];
}

-(void)selecedCell {
    if (_delegate && [_delegate respondsToSelector:@selector(selecedCellWithItem:)]) {
        DMActivity *item = [_array objectAt:0];
        [_delegate selecedCellWithItem:item];
    }

}

-(void)setArray:(NSArray *)array {
    _array = array;
    
    DMActivity *item = [array objectAt:0];
    [_bigImageView sd_setImageWithURL:[NSURL URLWithString:item.actimg] placeholderImage:[UIImage imageWithSize:_bigImageView.frame.size color:[UIColor grayColor]]];
    _nameLabel.text = item.acttitle;
    _nameLabel.frame = CGRectMake(AUTOSIZE(20), _bigImageView.bottom + AUTOSIZE(9), 100, AUTOSIZE(13));
    [_nameLabel adjustFontWithMaxSize:CGSizeMake(200, AUTOSIZE(13))];

    _timeLabel.text = item.acttime;
    _timeLabel.frame = CGRectMake(_nameLabel.right + 5, _nameLabel.top, _bgView.width - _nameLabel.right - 5 - AUTOSIZE( 20), _nameLabel.height);
    _descLabel.text = item.summary;
    _descLabel.left = _nameLabel.left;
    _descLabel.top = _nameLabel.bottom + AUTOSIZE(14);
    [_descLabel adjustFontWithMaxSize:CGSizeMake(_bgView.width - AUTOSIZE(40), 11111)];
    [_subView removeSubviews];
    CGFloat top = 0;
    _subView.frame = CGRectMake(0, _descLabel.bottom + AUTOSIZE(14), _bgView.width, 0);
    for (NSUInteger i = 1; i < array.count; i++) {

        DMActivity *item = [array objectAt:i];
        UIView *view = [self getSubMessageViewWithActivity:item];
        view.top = top;
        top += view.height;
        [_subView addSubview:view];
    }
    _subView.height = top;
    _bgView.height = _subView.bottom;
    self.height = _bgView.height + AUTOSIZE(15);
}

- (UILabel *)createLabelWithTextColor:(UIColor *)color font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text {
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.textAlignment =textAlignment;
    lable.textColor = color;
    lable.text = text;
    lable.font = font;
    return lable;
}

- (UIView *)getSubMessageViewWithActivity:(DMActivity *)item {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _bgView.width, AUTOSIZE(65))];
    [view drawSolidLineWithFrame:CGRectMake(AUTOSIZE(5), 0, _bgView.width - AUTOSIZE(10), 0.5) color:kSeperatorColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(AUTOSIZE(20), AUTOSIZE(7), AUTOSIZE(50), AUTOSIZE(50))];
    [imageView sd_setImageWithURL:[NSURL URLWithString:item.actlogo]];
    [view addSubview:imageView];
    
    UILabel *titleLabel = [self createLabelWithTextColor:kDMDefaultBlackStringColor font:FONT(12) textAlignment:NSTextAlignmentLeft text:item.acttitle];
    titleLabel.frame = CGRectMake(imageView.right + AUTOSIZE(12), imageView.top, _bgView.width - imageView.right - AUTOSIZE(12) - AUTOSIZE(12), AUTOSIZE(14));
    [view addSubview:titleLabel];
    
    UILabel *infoLabel = [self createLabelWithTextColor:kDMDefaultGrayStringColor font:FONT(12) textAlignment:NSTextAlignmentLeft text:item.acttitle];
    infoLabel.numberOfLines = 0;
    infoLabel.frame = CGRectMake(imageView.right + AUTOSIZE(12), titleLabel.bottom + AUTOSIZE(5), _bgView.width - imageView.right - AUTOSIZE(12) - AUTOSIZE(12), AUTOSIZE(14));
    [infoLabel adjustFontWithMaxSize:CGSizeMake(infoLabel.width, AUTOSIZE(35))];
    [view addSubview:infoLabel];

    DMButton *button = [[DMButton alloc] initWithFrame:view.bounds];
    [button buttonClickedcompletion:^(id returnData) {
        if (_delegate && [_delegate respondsToSelector:@selector(selecedCellWithItem:)]) {
            [_delegate selecedCellWithItem:item];
        }
    }];
    [view addSubview:button];
    return view;
}
@end
