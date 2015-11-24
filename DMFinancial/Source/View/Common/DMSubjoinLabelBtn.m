//
//  DMSubjoinLabelBtn.m
//  DamaiPlayPhone
//
//  Created by SongDong on 14-12-29.
//  Copyright (c) 2014年 陈彦岐. All rights reserved.
//

#import "DMSubjoinLabelBtn.h"

@interface DMSubjoinLabelBtn()


@end

@implementation DMSubjoinLabelBtn

-(id)initWithTitle:(NSString *)title frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setTitle:title forState:UIControlStateNormal];
        self.backgroundColor = [UIColor clearColor];
        //[self createFlexibleLabel];
    }
    return self;
}

//创建右上角 数量label
/*-(void)createFlexibleLabel
{
    _flexibleLabel = [[UILabel alloc] init];
    
    //根据btn的宽度，title的宽度计算这个label的位置宽度
    NSString *title = self.titleLabel.text;
    UIFont *titleFont = [UIFont systemFontOfSize:15];
    
    CGSize btnTitleSize = [title boundingRectWithSize:CGSizeMake(999, self.height)
                                              options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin)
                                           attributes:@{NSFontAttributeName:titleFont}
                                              context:nil].size;
    
    CGFloat titleWidth = btnTitleSize.width;
    CGFloat left = (self.width-titleWidth)/2+titleWidth+1;
    
    _flexibleLabel.frame = CGRectMake(left, 0, (self.width-titleWidth)/2, 20);
    _flexibleLabel.backgroundColor = [UIColor clearColor];
    _flexibleLabel.font = [UIFont systemFontOfSize:12];
    _flexibleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    
    [self addSubview:_flexibleLabel];
}*/

/*-(void)setFlexibleLabel:(UILabel *)flexibleLabel
{
    [_flexibleLabel removeFromSuperview];
    _flexibleLabel = flexibleLabel;
    [self addSubview:_flexibleLabel];
}*/

-(void)setBgImageView:(UIImageView *)bgImageView
{
    [_bgImageView removeFromSuperview];
    _bgImageView = bgImageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
