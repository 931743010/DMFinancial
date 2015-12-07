//
//  DMCustomizeSliderView.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/7.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMCustomizeSliderView.h"

@implementation DMCustomizeSliderView {
    UIImageView *_selectIconImageView;
    NSInteger _index;
}


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame options:(NSArray *)options{
    self = [super initWithFrame:frame];
    if (self) {
        self.optionsArray = options;
    }
    return self;
}

-(void)createSubViews {
    //先清空view
    [self removeSubviews];
    UIPanGestureRecognizer *tap1 = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(panGesture:)];
    [self addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(tapGesture:)];
    [self addGestureRecognizer:tap];
    
    
    UIImageView *optionsBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
    optionsBgImageView.backgroundColor = [UIColor redColor];
    [self addSubview:optionsBgImageView];
    
    _selectIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake([self adjustPosition:0] - 10, 0, 20, 20)];
    _selectIconImageView.backgroundColor = [UIColor blueColor];
    [self addSubview:_selectIconImageView];

   //计算每个选项的宽度 左右各留出10的空隙
    CGFloat optionWidth = self.frame.size.width/self.optionsArray.count;
    CGFloat left = 0;

    for (NSUInteger i = 0; i < self.optionsArray.count; i++) {
        NSString *string = [self.optionsArray objectAt:i];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(left, 20 + 5, optionWidth, 20)];
        label.text = string;
        label.textColor = [UIColor whiteColor];
        label.font = FONT(11);
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        left += optionWidth;
    }
}

-(void)setOptionsArray:(NSArray *)optionsArray {
    _optionsArray = optionsArray;
    [self createSubViews];
}

//调整selectIconImageView的中心点位置
-(CGFloat)adjustPosition:(CGFloat)left {
    CGFloat optionWidth = self.frame.size.width/self.optionsArray.count;

    NSInteger index = left/optionWidth;
    left = (index + 0.5) * optionWidth;
    _index = index;
    return left;
}

-(void)tapGesture:(UITapGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self];
    DMLOG(@"location=%@",@(location.x));
    CGFloat left = location.x;
    _selectIconImageView.left = left - _selectIconImageView.width/2;
    left = [self adjustPosition:left];
    [UIView animateWithDuration:0.25 animations:^{
        _selectIconImageView.left = left - _selectIconImageView.width/2;
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectedOption:index:)]) {
            [self.delegate selectedOption:[self.optionsArray objectAt:_index] index:_index];
        }
    }];

}
- (void)panGesture:(UIPanGestureRecognizer *)sender{
    CGPoint location = [sender locationInView:self];
//    DMLOG(@"location=%@",@(location.x));
//    DMLOG(@"self.width=%@",@(self.width));

    CGFloat left = location.x;
    CGFloat optionWidth = self.frame.size.width/self.optionsArray.count;

    if (left < optionWidth/2) {
        left = optionWidth/2;
    }
    if (left > self.width - optionWidth/2) {
        left = self.width - optionWidth/2;
    }
    _selectIconImageView.left = left - _selectIconImageView.width/2;
    
    if (sender.state == UIGestureRecognizerStateEnded){
        left = [self adjustPosition:left];
        [UIView animateWithDuration:0.1 animations:^{
            _selectIconImageView.left = left - _selectIconImageView.width/2;
        } completion:^(BOOL finished) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(selectedOption:index:)]) {
                [self.delegate selectedOption:[self.optionsArray objectAt:_index] index:_index];
            }
        }];

    }
}

@end
