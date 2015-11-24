//
//  DMRoundLabel.m
//  DamaiIphone
//
//  Created by lixiang on 14-2-18.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "DMRoundLabel.h"

@implementation DMRoundLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _fontSize = 12.0f;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _fontSize = 12.0f;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect rect = self.frame;
    rect.size.width = [self estimateWidth];
    self.frame = rect;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.bgColor.CGColor);
    CGFloat radius = (int)CGRectGetHeight(self.bounds)/2;
    CGContextMoveToPoint(context, radius, 0);
    CGContextAddArcToPoint(context, 0, 0, 0, radius, radius);
    CGContextAddArcToPoint(context, 0, radius*2, radius, radius*2, radius);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.bounds)-radius, CGRectGetMaxY(self.bounds));
    CGContextAddArcToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds), CGRectGetMaxX(self.bounds), radius, radius);
    CGContextAddArcToPoint(context, CGRectGetMaxX(self.bounds), 0, CGRectGetMaxX(self.bounds)-radius, 0, radius);
    CGContextAddLineToPoint(context, radius, 0);
    CGContextDrawPath(context, kCGPathFill);
    
    [_contentColor setFill];
    CGFloat width;
    NSDictionary *dic = @{NSFontAttributeName:FONT(self.fontSize)};
    width = [_content sizeWithAttributes:dic].width;
    [_content drawInRect:CGRectMake(radius, (int)((rect.size.height-self.fontSize)/2), width, rect.size.height) withAttributes:dic];

}

- (void)setContent:(NSString *)content {
    if (_content != content) {
        _content = content;
    }
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (CGFloat)estimateWidth {
    CGFloat radius = (int)CGRectGetHeight(self.bounds)/2;
    CGFloat width;
    NSDictionary *dic = @{NSFontAttributeName:FONT(self.fontSize)};
    width = [_content sizeWithAttributes:dic].width;
    return width + radius*2;
}

@end
