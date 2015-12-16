//
//  DMJijinDetailChartsCell.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/11.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMJijinDetailChartsCell.h"
#import "DMJijinDetailChartsView.h"

@implementation DMJijinDetailChartsCell {
    DMButton *_jingzhizengzhangButton;//净值增长率
    DMButton *_jingzhizoushiButton;//净值走势
    DMButton *_yiyueButton;//一个月
    DMButton *_sanyueButton;//三个月
    DMButton *_liuyueButton;//六个月
    DMButton *_yinianButton;//一年
    UILabel *_descLabel;//
    DMJijinDetailChartsView *_jijinDetailChartsView;
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
    _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(27, _jingzhizengzhangButton.bottom + 14, kScreenWidth - 54, 30)];
    _descLabel.layer.cornerRadius = 15;
    _descLabel.layer.borderWidth = 0.5;
    _descLabel.layer.borderColor = kDMDefaultGrayStringColor.CGColor;
    _descLabel.font = FONT(13);
    _descLabel.textAlignment = NSTextAlignmentCenter;
    _descLabel.textColor = kDMDefaultGrayStringColor;
    [self.contentView addSubview:_descLabel];
    
    
    _jijinDetailChartsView = [[DMJijinDetailChartsView alloc] initWithFrame:CGRectMake(16, _descLabel.bottom + 5, kScreenWidth - 32, 220)];
    _jijinDetailChartsView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:_jijinDetailChartsView];
    [self createMonthButton];
}


- (void)createMonthButton {
    CGFloat width = (kScreenWidth - 50 - 13*3)/4;
    _yiyueButton = [[DMButton alloc] initWithFrame:CGRectMake(25, self.height - 50, width, 30)];
    [_yiyueButton setTitle:@"一个月" forState:UIControlStateNormal];
    [_yiyueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _yiyueButton.layer.cornerRadius = 15;
    _yiyueButton.layer.borderWidth = 0.5;
    _yiyueButton.layer.borderColor = kDMDefaultGrayStringColor.CGColor;
    _yiyueButton.backgroundColor = kDMDefaultGrayStringColor;
    [_yiyueButton.titleLabel setFont:FONT(13)];
    [_yiyueButton buttonClickedcompletion:^(id returnData) {
        _yiyueButton.backgroundColor = [UIColor colorWithHexString:@"ff8b2e"];
        _sanyueButton.backgroundColor = [UIColor whiteColor];
        _liuyueButton.backgroundColor = [UIColor whiteColor];
        _yinianButton.backgroundColor = [UIColor whiteColor];
        [_yiyueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sanyueButton setTitleColor:kDMDefaultBlackStringColor forState:UIControlStateNormal];
        [_liuyueButton setTitleColor:kDMDefaultBlackStringColor forState:UIControlStateNormal];
        [_yinianButton setTitleColor:kDMDefaultBlackStringColor forState:UIControlStateNormal];
        
        _yiyueButton.layer.borderColor = [UIColor colorWithHexString:@"ff8b2e"].CGColor;
        _sanyueButton.layer.borderColor = kDMDefaultGrayStringColor.CGColor;
        _liuyueButton.layer.borderColor = kDMDefaultGrayStringColor.CGColor;
        _yinianButton.layer.borderColor = kDMDefaultGrayStringColor.CGColor;

    }];
    [self.contentView addSubview:_yiyueButton];
    
    _sanyueButton = [[DMButton alloc] initWithFrame:CGRectMake(_yiyueButton.right + 13, self.height - 50, width, 30)];
    [_sanyueButton setTitle:@"三个月" forState:UIControlStateNormal];
    _sanyueButton.backgroundColor = kDMDefaultGrayStringColor;
    _sanyueButton.layer.cornerRadius = 15;
    _sanyueButton.layer.borderWidth = 0.5;
    _sanyueButton.layer.borderColor = kDMDefaultGrayStringColor.CGColor;
    
    [_sanyueButton.titleLabel setFont:FONT(13)];
    [_sanyueButton buttonClickedcompletion:^(id returnData) {
        _yiyueButton.backgroundColor = [UIColor whiteColor];
        _sanyueButton.backgroundColor = [UIColor colorWithHexString:@"ff8b2e"];
        _liuyueButton.backgroundColor = [UIColor whiteColor];
        _yinianButton.backgroundColor = [UIColor whiteColor];
        
        [_yiyueButton setTitleColor:kDMDefaultBlackStringColor forState:UIControlStateNormal];
        [_sanyueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_liuyueButton setTitleColor:kDMDefaultBlackStringColor forState:UIControlStateNormal];
        [_yinianButton setTitleColor:kDMDefaultBlackStringColor forState:UIControlStateNormal];
        
        _yiyueButton.layer.borderColor = kDMDefaultGrayStringColor.CGColor;
        _sanyueButton.layer.borderColor = [UIColor colorWithHexString:@"ff8b2e"].CGColor;
        _liuyueButton.layer.borderColor = kDMDefaultGrayStringColor.CGColor;
        _yinianButton.layer.borderColor = kDMDefaultGrayStringColor.CGColor;

    }];
    [self.contentView addSubview:_sanyueButton];
    
    _liuyueButton = [[DMButton alloc] initWithFrame:CGRectMake(_sanyueButton.right + 13, self.height - 50, width, 30)];
    [_liuyueButton setTitle:@"六个月" forState:UIControlStateNormal];
    _liuyueButton.backgroundColor = kDMDefaultGrayStringColor;
    [_liuyueButton.titleLabel setFont:FONT(13)];
    _liuyueButton.layer.cornerRadius = 15;
    _liuyueButton.layer.borderWidth = 0.5;
    _liuyueButton.layer.borderColor = kDMDefaultGrayStringColor.CGColor;
    
    [_liuyueButton buttonClickedcompletion:^(id returnData) {
        _yiyueButton.backgroundColor = [UIColor whiteColor];
        _sanyueButton.backgroundColor = [UIColor whiteColor];
        _liuyueButton.backgroundColor = [UIColor colorWithHexString:@"ff8b2e"];
        _yinianButton.backgroundColor = [UIColor whiteColor];
        
        [_yiyueButton setTitleColor:kDMDefaultBlackStringColor forState:UIControlStateNormal];
        [_sanyueButton setTitleColor:kDMDefaultBlackStringColor forState:UIControlStateNormal];
        [_liuyueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_yinianButton setTitleColor:kDMDefaultBlackStringColor forState:UIControlStateNormal];
        
        _yiyueButton.layer.borderColor = kDMDefaultGrayStringColor.CGColor;
        _sanyueButton.layer.borderColor = kDMDefaultGrayStringColor.CGColor;
        _liuyueButton.layer.borderColor = [UIColor colorWithHexString:@"ff8b2e"].CGColor;
        _yinianButton.layer.borderColor = kDMDefaultGrayStringColor.CGColor;

    }];
    [self.contentView addSubview:_liuyueButton];
    
    _yinianButton = [[DMButton alloc] initWithFrame:CGRectMake(_liuyueButton.right + 13, self.height - 50, width, 30)];
    [_yinianButton setTitle:@"一年" forState:UIControlStateNormal];
    _yinianButton.backgroundColor = kDMDefaultGrayStringColor;
    [_yinianButton.titleLabel setFont:FONT(13)];
    _yinianButton.layer.cornerRadius = 15;
    _yinianButton.layer.borderWidth = 0.5;
    _yinianButton.layer.borderColor = kDMDefaultGrayStringColor.CGColor;
    
    [_yinianButton buttonClickedcompletion:^(id returnData) {
        _yiyueButton.backgroundColor = [UIColor whiteColor];
        _sanyueButton.backgroundColor = [UIColor whiteColor];
        _liuyueButton.backgroundColor = [UIColor whiteColor];
        _yinianButton.backgroundColor = [UIColor colorWithHexString:@"ff8b2e"];
        
        [_yiyueButton setTitleColor:kDMDefaultBlackStringColor forState:UIControlStateNormal];
        [_sanyueButton setTitleColor:kDMDefaultBlackStringColor forState:UIControlStateNormal];
        [_liuyueButton setTitleColor:kDMDefaultBlackStringColor forState:UIControlStateNormal];
        [_yinianButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _yiyueButton.layer.borderColor = kDMDefaultGrayStringColor.CGColor;
        _sanyueButton.layer.borderColor = kDMDefaultGrayStringColor.CGColor;
        _liuyueButton.layer.borderColor = kDMDefaultGrayStringColor.CGColor;
        _yinianButton.layer.borderColor = [UIColor colorWithHexString:@"ff8b2e"].CGColor;

    }];
    [self.contentView addSubview:_yinianButton];
    
    
    _yiyueButton.backgroundColor = [UIColor colorWithHexString:@"ff8b2e"];
    _sanyueButton.backgroundColor = [UIColor whiteColor];
    _liuyueButton.backgroundColor = [UIColor whiteColor];
    _yinianButton.backgroundColor = [UIColor whiteColor];
    
    [_yiyueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sanyueButton setTitleColor:kDMDefaultBlackStringColor forState:UIControlStateNormal];
    [_liuyueButton setTitleColor:kDMDefaultBlackStringColor forState:UIControlStateNormal];
    [_yinianButton setTitleColor:kDMDefaultBlackStringColor forState:UIControlStateNormal];
    
    _yiyueButton.layer.borderColor = [UIColor colorWithHexString:@"ff8b2e"].CGColor;
    _sanyueButton.layer.borderColor = kDMDefaultGrayStringColor.CGColor;
    _liuyueButton.layer.borderColor = kDMDefaultGrayStringColor.CGColor;
    _yinianButton.layer.borderColor = kDMDefaultGrayStringColor.CGColor;

}

-(void)changeMonth:(NSInteger)month {
    if (month == 1) {
        
    } else if (month == 3) {
        
    } else if (month == 6) {
        
    } else if (month == 12) {
        
    } else {
        
    }
}

-(void)setItem:(NSString *)item {
    _item = item;
    
    NSMutableAttributedString *attributedString1 = [@"期间涨跌10.94% " replaceWithColor:kDMPinkColor font:BOLDFONT(13) string:@"10.94%"];
    NSMutableAttributedString *attributedString2 = [@"    同类平均-0.54%" replaceWithColor:[UIColor greenColor] font:BOLDFONT(13) string:@"-0.54%"];

    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] init];
    [att appendAttributedString:attributedString1];
    [att appendAttributedString:attributedString2];
    _descLabel.attributedText = att;
}
@end
