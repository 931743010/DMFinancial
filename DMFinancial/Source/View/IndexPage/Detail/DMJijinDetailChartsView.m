//
//  DMJijinDetailChartsView.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/15.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMJijinDetailChartsView.h"

@implementation DMJijinDetailChartsView {
    UILabel *_dangqianLabel;
    UILabel *_tongleiLabel;
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

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIColor *color = [UIColor colorWithHexString:@"88beed"];
    [color set];  //设置线条颜色
    
    UIBezierPath* path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(0, 200.0)];
    
    
    UIBezierPath* pathLine1 = [UIBezierPath bezierPath];
    pathLine1.lineWidth = 1.0;
    [pathLine1 moveToPoint:CGPointMake(0, 200.0)];

    // Draw the lines
    CGFloat xTickMark = kScreenWidth/30;
    CGFloat x = 0;
    CGFloat y = 0;

    for (NSUInteger i = 0; i < 30; i++) {
        x += xTickMark;
        y = 200 - (arc4random() % 30)*5;
        [path1 addLineToPoint:CGPointMake(x, y)];
        
        [pathLine1 addLineToPoint:CGPointMake(x, y)];

    }
    
    [path1 addLineToPoint:CGPointMake(kScreenWidth, 200)];
    [path1 closePath]; //第五条线通过调用closePath方法得到的
    [path1 fillWithBlendMode:kCGBlendModeNormal alpha:0.5]; //Draws line 根据坐标点连线

    [pathLine1 stroke]; //Draws line 根据坐标点连线
    
    
    
    [[UIColor colorWithHexString:@"fdc799"] set];  //设置线条颜色
    
    UIBezierPath* path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(0, 200.0)];
    
    
    UIBezierPath* pathLine2 = [UIBezierPath bezierPath];
    pathLine2.lineWidth = 1.0;
    [pathLine2 moveToPoint:CGPointMake(0, 200.0)];
    
    // Draw the lines
    CGFloat xTickMark2 = kScreenWidth/30;
    CGFloat x2 = 0;
    CGFloat y2 = 0;
    
    for (NSUInteger i = 0; i < 30; i++) {
        x2 += xTickMark2;
        y2 = 200 - (arc4random() % 30)*5;
        [path2 addLineToPoint:CGPointMake(x2, y2)];
        
        [pathLine2 addLineToPoint:CGPointMake(x2, y2)];
        
    }
    
    [path2 addLineToPoint:CGPointMake(kScreenWidth, 200)];
    [path2 closePath]; //第五条线通过调用closePath方法得到的
    [path2 fillWithBlendMode:kCGBlendModeNormal alpha:0.5]; //Draws line 根据坐标点连线
    
    [pathLine2 stroke]; //Draws line 根据坐标点连线

}


@end
