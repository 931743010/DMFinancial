//
//  DMJijinDetailChartsCell.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/11.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMJijinDetailChartsCell.h"

@implementation DMJijinDetailChartsCell {
    DMButton *_jingzhizengzhangButton;//净值增长率
    DMButton *_jingzhizoushiButton;//净值走势
    DMButton *_yiyueButton;//一个月
    DMButton *_sanyueButton;//三个月
    DMButton *_liuyueButton;//六个月
    DMButton *_yinianButton;//一年
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.height = 380;
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    
    _jingzhizengzhangButton = [[DMButton alloc] initWithFrame:CGRectMake(25, 15, (kScreenWidth - 50)/2, 37)];
    [_jingzhizengzhangButton setTitle:@"净值增长率" forState:UIControlStateNormal];
    _jingzhizengzhangButton.backgroundColor = kDMPinkColor;
    [_jingzhizengzhangButton.titleLabel setFont:FONT(13)];
    [_jingzhizengzhangButton buttonClickedcompletion:^(id returnData) {
        _jingzhizengzhangButton.backgroundColor = kDMPinkColor;
        _jingzhizoushiButton.backgroundColor = kDMDefaultGrayStringColor;
    }];
    [self.contentView addSubview:_jingzhizengzhangButton];
    
    _jingzhizoushiButton = [[DMButton alloc] initWithFrame:CGRectMake(_jingzhizengzhangButton.right - 0.5, 15, (kScreenWidth - 50)/2, 37)];
    [_jingzhizoushiButton setTitle:@"净值走势" forState:UIControlStateNormal];
    _jingzhizoushiButton.backgroundColor = kDMDefaultGrayStringColor;
    [_jingzhizoushiButton.titleLabel setFont:FONT(13)];
    [_jingzhizoushiButton buttonClickedcompletion:^(id returnData) {
        _jingzhizengzhangButton.backgroundColor = kDMDefaultGrayStringColor;
        _jingzhizoushiButton.backgroundColor = kDMPinkColor;
    }];
    [self.contentView addSubview:_jingzhizoushiButton];

    CGFloat width = (kScreenWidth - 50 - 13*3)/4;
    _yiyueButton = [[DMButton alloc] initWithFrame:CGRectMake(25, self.height - 50, width, 30)];
    [_yiyueButton setTitle:@"一个月" forState:UIControlStateNormal];
    _yiyueButton.backgroundColor = kDMDefaultGrayStringColor;
    [_yiyueButton.titleLabel setFont:FONT(13)];
    [_yiyueButton buttonClickedcompletion:^(id returnData) {
        _yiyueButton.backgroundColor = kDMDefaultGrayStringColor;
        _sanyueButton.backgroundColor = [UIColor whiteColor];
        _liuyueButton.backgroundColor = [UIColor whiteColor];
        _yinianButton.backgroundColor = [UIColor whiteColor];
    }];
    [self.contentView addSubview:_yiyueButton];

    _sanyueButton = [[DMButton alloc] initWithFrame:CGRectMake(_yiyueButton.right + 13, self.height - 50, width, 30)];
    [_sanyueButton setTitle:@"三个月" forState:UIControlStateNormal];
    _sanyueButton.backgroundColor = kDMDefaultGrayStringColor;
    [_sanyueButton.titleLabel setFont:FONT(13)];
    [_sanyueButton buttonClickedcompletion:^(id returnData) {
        _yiyueButton.backgroundColor = [UIColor whiteColor];
        _sanyueButton.backgroundColor = kDMDefaultGrayStringColor;
        _liuyueButton.backgroundColor = [UIColor whiteColor];
        _yinianButton.backgroundColor = [UIColor whiteColor];
    }];
    [self.contentView addSubview:_sanyueButton];

    _liuyueButton = [[DMButton alloc] initWithFrame:CGRectMake(_sanyueButton.right + 13, self.height - 50, width, 30)];
    [_liuyueButton setTitle:@"六个月" forState:UIControlStateNormal];
    _liuyueButton.backgroundColor = kDMDefaultGrayStringColor;
    [_liuyueButton.titleLabel setFont:FONT(13)];
    [_liuyueButton buttonClickedcompletion:^(id returnData) {
        _yiyueButton.backgroundColor = [UIColor whiteColor];
        _sanyueButton.backgroundColor = [UIColor whiteColor];
        _liuyueButton.backgroundColor = kDMDefaultGrayStringColor;
        _yinianButton.backgroundColor = [UIColor whiteColor];
    }];
    [self.contentView addSubview:_liuyueButton];

    _yinianButton = [[DMButton alloc] initWithFrame:CGRectMake(_liuyueButton.right + 13, self.height - 50, width, 30)];
    [_yinianButton setTitle:@"一年" forState:UIControlStateNormal];
    _yinianButton.backgroundColor = kDMDefaultGrayStringColor;
    [_yinianButton.titleLabel setFont:FONT(13)];
    [_yinianButton buttonClickedcompletion:^(id returnData) {
        _yiyueButton.backgroundColor = [UIColor whiteColor];
        _sanyueButton.backgroundColor = [UIColor whiteColor];
        _liuyueButton.backgroundColor = [UIColor whiteColor];
        _yinianButton.backgroundColor = kDMDefaultGrayStringColor;
    }];
    [self.contentView addSubview:_yinianButton];

    _yiyueButton.backgroundColor = kDMDefaultGrayStringColor;
    _sanyueButton.backgroundColor = [UIColor whiteColor];
    _liuyueButton.backgroundColor = [UIColor whiteColor];
    _yinianButton.backgroundColor = [UIColor whiteColor];

}

@end
