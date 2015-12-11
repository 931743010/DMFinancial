//
//  DMDetailTopView.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/9.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMDetailTopView.h"

@implementation DMDetailTopView {
    UILabel *_nameLabel;//名称
    UILabel *_descLabel;//描述
    DMButton *_collectionButton;//收藏按钮
    UILabel *_titleLabel1;
    UILabel *_label1;
    UILabel *_titleLabel2;
    UILabel *_label2;
    UILabel *_titleLabel3;
    UILabel *_label3;

}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews {
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.width - 20, 0)];
    _nameLabel.textColor = kDMDefaultBlackStringColor;
    _nameLabel.font = FONT(13);
    _nameLabel.numberOfLines = 0;
    [self addSubview:_nameLabel];
    
    _descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _descLabel.textColor = kDMDefaultBlackStringColor;
    _descLabel.font = FONT(13);
    _descLabel.numberOfLines = 0;
    [self addSubview:_descLabel];
    
    _collectionButton = [[DMButton alloc] initWithFrame:CGRectZero];
    _collectionButton.backgroundColor = [UIColor redColor];
    [_collectionButton buttonClickedcompletion:^(id returnData) {
        if (_delegate && [_delegate respondsToSelector:@selector(collectionProjectWithId:type:)]) {
            [_delegate collectionProjectWithId:_item.itemId type:_item.assetsType];
        }
    }];
    [self addSubview:_collectionButton];
    
    _titleLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel1.textColor = kDMDefaultBlackStringColor;
    _titleLabel1.font = FONT(13);
    _titleLabel1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel1];

    _label1 = [[UILabel alloc] initWithFrame:CGRectZero];
    _label1.textColor = kDMDefaultBlackStringColor;
    _label1.font = FONT(13);
    _label1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label1];

    _titleLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel2.textColor = kDMDefaultBlackStringColor;
    _titleLabel2.font = FONT(13);
    _titleLabel2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel2];

    _label2 = [[UILabel alloc] initWithFrame:CGRectZero];
    _label2.textColor = kDMDefaultBlackStringColor;
    _label2.font = FONT(13);
    _label2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label2];

    _titleLabel3 = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel3.textColor = kDMDefaultBlackStringColor;
    _titleLabel3.font = FONT(13);
    _titleLabel3.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel3];

    _label3 = [[UILabel alloc] initWithFrame:CGRectZero];
    _label3.textColor = kDMDefaultBlackStringColor;
    _label3.font = FONT(13);
    _label3.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label3];

}

-(void)setItem:(DMProjectListItem *)item {
    _item = item;
    _nameLabel.text = item.name;
    [_nameLabel adjustFontAttributeWithMaxSize:CGSizeMake(_nameLabel.width, 1111)];
    _descLabel.text = item.dec;
    _descLabel.frame = CGRectMake(_nameLabel.left, _nameLabel.bottom + 5, self.width - 20, 20);
    
    _collectionButton.frame = CGRectMake(0, _descLabel.top, 30, 30);
    _collectionButton.right = self.width - _collectionButton.width - 10;
    CGFloat width = self.width/3;
    _titleLabel1.frame = CGRectMake(0, _descLabel.bottom + 10, width, 15);
    _titleLabel2.frame = CGRectMake(width, _titleLabel1.top, width, 15);
    _titleLabel3.frame = CGRectMake(width*2, _titleLabel1.top, width, 15);
    _label1.frame = CGRectMake(0, _titleLabel1.bottom, width, 30);
    _label2.frame = CGRectMake(width, _titleLabel1.bottom, width, 30);
    _label3.frame = CGRectMake(width*2, _titleLabel1.bottom, width, 30);

    if (item.assetsType == DMAssetsType1) {
        _titleLabel1.text = @"万份收益";
        _titleLabel2.text = @"近七日年化";
        _titleLabel3.text = @"投资风险";
    } else if (item.assetsType == DMAssetsType2) {
        _titleLabel1.text = @"最新净值";
        _titleLabel2.text = @"日涨跌幅";
        _titleLabel3.text = @"投资风险";
    } else if (item.assetsType == DMAssetsType3) {
        _titleLabel1.text = @"年化收益率";
        _titleLabel2.text = @"投资期限";
        _titleLabel3.text = @"投资风险";
    } else if (item.assetsType == DMAssetsType4) {
        _titleLabel1.text = @"年化收益";
        _titleLabel2.text = @"投资期限";
        _titleLabel3.text = @"投资风险";
    } else if (item.assetsType == DMAssetsType5) {
        _titleLabel1.text = @"预期年化";
        _titleLabel2.text = @"投资期限";
        _titleLabel3.text = @"投资风险";
    }
    _label1.text = @"10%";
    _label2.text = @"90天";
    _label3.text = @"高";
}

@end
