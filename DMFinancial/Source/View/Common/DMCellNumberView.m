//
//  DMCellNumberView.m
//  DamaiIphone
//
//  Created by 陈彦岐 on 14-2-17.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "DMCellNumberView.h"

@implementation DMCellNumberView

-(id)initWithFrame:(CGRect)frame withIndex:(int)index withColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if(self){
        _index =index;
        _color = color;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    //实心圆
//    if(isDrawRect){
//        CGContextAddEllipseInRect(context, CGRectMake(19, yuanTop, 26, 26));
//        CGContextSetFillColorWithColor(context, yuanColor.CGColor);//渐变的颜色
//        CGContextFillPath(context);
//    }else{
//        CGContextAddEllipseInRect(context, CGRectMake(19, yuanTop, 26, 26));
//        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);//白色
//        CGContextFillPath(context);
//    }
    
    
    //空心圆
    CGContextAddEllipseInRect(context, CGRectMake(1, 1, self.width - 2, self.height - 2));
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);//最大的颜色
    CGContextStrokePath(context);
    //文字
    
    CGContextSetFillColorWithColor(context, self.color.CGColor);//红色的字

    NSString *indexStr =[NSString stringWithFormat:@"%d",_index];
    if(indexStr.length==1){
        [indexStr drawAtPoint:CGPointMake(7, 3) withAttributes:@{NSFontAttributeName:FONT(11)}];
    }else if(indexStr.length==2){
        [indexStr drawAtPoint:CGPointMake(4, 3) withAttributes:@{NSFontAttributeName:FONT(11)}];
    }else{
        
    }
}

@end
