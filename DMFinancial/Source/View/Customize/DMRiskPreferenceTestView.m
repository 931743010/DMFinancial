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

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
//    UIColor *color = [UIColor whiteColor];
//    [color set];  //设置线条颜色
//    
//    UIBezierPath* aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150)
//                                                         radius:75
//                                                     startAngle:0
//                                                       endAngle:150
//                                                      clockwise:YES];
//    
//    aPath.lineWidth = 5.0;
//    aPath.lineCapStyle = kCGLineCapRound;  //线条拐角
//    aPath.lineJoinStyle = kCGLineCapRound;  //终点处理
//    
//    [aPath stroke];
    
//    UIColor *color = [UIColor whiteColor];
//    [color set];  //设置线条颜色
//    
//    UIBezierPath* aPath = [UIBezierPath bezierPath];
//    
//    aPath.lineWidth = 5.0;
//    aPath.lineCapStyle = kCGLineCapRound;  //线条拐角
//    aPath.lineJoinStyle = kCGLineCapRound;  //终点处理
//    
//    [aPath moveToPoint:CGPointMake(20, 100)];
//    
//    [aPath addQuadCurveToPoint:CGPointMake(120, 100) controlPoint:CGPointMake(70, 0)];
//    
//    [aPath stroke];
    
    UIColor *color = [UIColor whiteColor];
    [color set];  //设置线条颜色
    
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 1.0;
    
    aPath.lineCapStyle = kCGLineCapRound;  //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound;  //终点处理
    
    // Set the starting point of the shape.
    [aPath moveToPoint:CGPointMake(0, 200.0)];
    
    // Draw the lines
    CGFloat xTickMark = kScreenWidth/30;
    CGFloat x = 0;
    CGFloat y = 0;
    for (NSUInteger i = 0; i < 30; i++) {
        x += xTickMark;
        y = 200 - (arc4random() % 30)*5;
        [aPath addLineToPoint:CGPointMake(x, y)];

    }
    [aPath addLineToPoint:CGPointMake(kScreenWidth + 1, 200)];
    [aPath closePath]; //第五条线通过调用closePath方法得到的
    
    [aPath fill]; //Draws line 根据坐标点连线

}
@end
