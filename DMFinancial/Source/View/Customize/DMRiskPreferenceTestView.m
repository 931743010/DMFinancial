//
//  DMRiskPreferenceTestView.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/7.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMRiskPreferenceTestView.h"

@implementation DMRiskPreferenceTestItem

@end

@implementation DMRiskPreferenceTestView {
    UILabel *_titleLabel;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews {
    
}

-(void)setItem:(DMRiskPreferenceTestItem *)item {
    _item = item;
    [self removeSubviews];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 0)];
    _titleLabel.textColor = kDMDefaultBlackStringColor;
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = FONT(13);
    _titleLabel.text = item.question;
    [_titleLabel adjustFontWithMaxSize:CGSizeMake(_titleLabel.width, 1111)];
    [self addSubview:_titleLabel];
    
    CGFloat top = _titleLabel.bottom + 5;
    for (NSUInteger i = 0; i < item.answerList.count; i++) {
        UILabel *answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, top, self.width, 20)];
        answerLabel.textColor = kDMDefaultBlackStringColor;
        answerLabel.numberOfLines = 0;
        answerLabel.font = FONT(13);
        answerLabel.text = [item.answerList objectAt:i];
        [answerLabel adjustFontWithMaxSize:CGSizeMake(answerLabel.width, 1111)];
        answerLabel.height += 5;
        answerLabel.width = self.width;
        answerLabel.tag = i;
        answerLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(selectAnswer:)];
        [answerLabel addGestureRecognizer:tap];
        [self addSubview:answerLabel];
        top += answerLabel.height + 10;
    }
    self.height = top + 5;
}

-(void)selectAnswer:(UITapGestureRecognizer *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedAnswer:tag:)]) {
        [self.delegate selectedAnswer:sender.view.tag tag:self.item.index.integerValue];
    }
    _titleLabel.text = [NSString stringWithFormat:@"%@%@",_item.question,[self getIndex:sender.view.tag]];
    _titleLabel.width = self.width;
    [_titleLabel adjustFontWithMaxSize:CGSizeMake(_titleLabel.width, 1111)];
}
-(NSString *)getIndex:(NSInteger)index {
    NSArray *array = @[@"A",@"B",@"C",@"D",@"E",@"F"];
    return [array objectAt:index];
}
@end
