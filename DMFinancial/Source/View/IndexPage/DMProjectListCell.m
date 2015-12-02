//
//  DMProjectListCell.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/26.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMProjectListCell.h"

@implementation DMProjectListCell {
    UILabel *_nameLabel;//资产名称
    UILabel *_yieldTitleLabel;//收益率标题
    UILabel *_yieldLabel;//收益率
    UILabel *_managementLabel;//机构
    UILabel *_decLabel;//描述
    UIImageView *_typeIconImageView;//类型图标
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    topView.backgroundColor = kTableViewBgColor;
    [self.contentView addSubview:topView];
    
    CGFloat top = 10;
    CGFloat left = 10;

//    [self drawSolidLineWithFrame:CGRectMake(0, top, kScreenWidth, 0.5) color:kSeperatorColor];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, top + 6, kScreenWidth - 10, 14)];
    _nameLabel.font = FONT(14);
    _nameLabel.textColor = kDMDefaultBlackStringColor;
    [self addSubview:_nameLabel];
    
    _decLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, _nameLabel.bottom + 6, kScreenWidth - 10, 14)];
    _decLabel.font = FONT(13);
    _decLabel.textColor = kDMDefaultBlackStringColor;
    [self addSubview:_decLabel];
    
    _managementLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, _decLabel.bottom + 16, kScreenWidth - 10, 14)];
    _managementLabel.font = FONT(12);
    _managementLabel.textColor = kDMDefaultGrayStringColor;
    [self addSubview:_managementLabel];
    
    _typeIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 30 - 10, top, 30, 10)];
    _typeIconImageView.backgroundColor = [UIColor redColor];
    [self addSubview:_typeIconImageView];

    _yieldTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, _typeIconImageView.bottom + 10, kScreenWidth - 10, 14)];
    _yieldTitleLabel.textAlignment = NSTextAlignmentRight;
    _yieldTitleLabel.font = FONT(12);
    _yieldTitleLabel.textColor = kDMDefaultGrayStringColor;
    [self addSubview:_yieldTitleLabel];
    _yieldTitleLabel.right = _typeIconImageView.right;
    
    _yieldLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, _yieldTitleLabel.bottom, kScreenWidth - 10, 40)];
    _yieldLabel.textAlignment = NSTextAlignmentRight;
    _yieldLabel.font = BOLDFONT(25);
    _yieldLabel.textColor = kDMPinkColor;
    [self addSubview:_yieldLabel];
    _yieldLabel.right = _typeIconImageView.right;


}

-(void)setItem:(DMProjectListItem *)item {
    _item = item;
    _nameLabel.text = item.name;
    _yieldLabel.text = item.yield;
    _decLabel.text = @"期限:30天   100元起投";
    NSString *string = @"小牛在线   国有资产知名保险公司承保";
    NSMutableAttributedString *attributedString = [string replaceWithColor:kDMPinkColor font:_managementLabel.font string:[NSString stringWithFormat:@"%@",@"国有资产知名保险公司承保"]];
    _managementLabel.attributedText = attributedString;
    
    _yieldTitleLabel.text = @"预期年化收益率";
    
    NSMutableAttributedString *attributedString1 = [item.yield replaceWithColor:kDMPinkColor font:BOLDFONT(13) string:@"%"];
    _yieldLabel.attributedText = attributedString1;

}

@end
