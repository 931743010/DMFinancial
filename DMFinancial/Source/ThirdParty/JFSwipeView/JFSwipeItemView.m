//
//  JFSwipeItemView.m
//  IndexPagesDemo
//
//  Created by Joseph Fu on 14/11/7.
//  Copyright (c) 2014年 Joseph Fu. All rights reserved.
//

#import "JFSwipeItemView.h"

@interface JFSwipeItemView ()
@property (nonatomic, strong, readwrite) UIView *contentView;
@end

@implementation JFSwipeItemView
@synthesize normalColorElements = _normalColorElements;
@synthesize selectedColorElements = _selectedColorElements;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:_titleLabel];
        
        _alphaOfNormalColor = 1.0;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (_selected == selected) {
        return;
    }
    
    _selected = selected;
    if (animated) {
        [UIView animateWithDuration:0.25
                         animations:^{
                             [self changeStyle];
                         }];
    } else {
        [self changeStyle];
    }
}

- (void)changeStyle
{
    if (_selected) {
        self.titleLabel.textColor = [self colorWithPercent:1];
//        [self makeScale:1.0];
        if (self.selectedFont) {
            self.titleLabel.font = self.selectedFont;
        }
    } else {
        self.titleLabel.textColor = [self colorWithPercent:0];
//        [self makeScale:15.0/17.0];
        self.titleLabel.font = self.normalFont;
    }

}

- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}

- (void)setNormalFont:(UIFont *)normalFont {
    self.titleLabel.font = normalFont;
}

- (CGFloat)valueWithPercent:(CGFloat)percent
                   minValue:(CGFloat)min
                   maxValue:(CGFloat)max
{
    return min + (max - min) * percent;
}

- (NSArray *)normalColorElements
{
    if (!_normalColorElements) {
        _normalColorElements = @[@80, @70, @71];
    }
    return _normalColorElements;
}

- (NSArray *)selectedColorElements
{
    if (!_selectedColorElements) {
        _selectedColorElements = @[@254, @80, @86];
    }
    return _selectedColorElements;
}

- (void)setNormalColorElements:(NSArray *)normalColorElements
{
    NSAssert(normalColorElements.count == 3, @"必须提供3个值，分别为R G B");
    if (_normalColorElements != normalColorElements) {
         _normalColorElements = normalColorElements;
    }
}

- (void)setSelectedColorElements:(NSArray *)selectedColorElements
{
    NSAssert(selectedColorElements.count == 3, @"必须提供3个值，分别为R G B");
    if (_selectedColorElements != selectedColorElements) {
        _selectedColorElements = selectedColorElements;
    }
}

- (UIColor *)colorWithPercent:(CGFloat)percent
{
    CGFloat min = [self.normalColorElements[0] floatValue];
    CGFloat max = [self.selectedColorElements[0] floatValue];
    CGFloat redValue = [self valueWithPercent:percent
                                   minValue:min
                                   maxValue:max];
    min = [self.normalColorElements[1] floatValue];
    max = [self.selectedColorElements[1] floatValue];
    CGFloat greenValue = [self valueWithPercent:percent
                                     minValue:min
                                     maxValue:max];
    min = [self.normalColorElements[2] floatValue];
    max = [self.selectedColorElements[2] floatValue];
    CGFloat blueValue = [self valueWithPercent:percent
                                    minValue:min
                                    maxValue:max];
    
    CGFloat alpha = [self valueWithPercent:percent minValue:self.alphaOfNormalColor maxValue:1.0];
    __autoreleasing UIColor *color =  RGBA(redValue, greenValue, blueValue, alpha);
    return color;
}


- (void)setProgressForWillSelected:(CGFloat)progressForWillSelected
{
    UIColor *color = [self colorWithPercent:progressForWillSelected];
    self.titleLabel.textColor = color;
}

- (void)prepareForReuse
{
    self.selected = NO;
    self.titleLabel.transform = CGAffineTransformIdentity;
    self.titleLabel.layer.transform = CATransform3DIdentity;
}

- (void)makeScale:(float)scale
{
    if (scale == 1.0) {
        self.titleLabel.layer.transform = CATransform3DIdentity;
    }
    else {
        self.titleLabel.layer.transform = CATransform3DMakeScale(scale, scale, 1);
    }
}

@end
