//
//  DMRoundedImageView.m
//  DamaiIphone
//
//  Created by SongDong on 14-7-16.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "DMRoundedImageView.h"

@implementation DMRoundedImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //通过图片遮挡创建圆形图片
        UIImage *kongImage = [UIImage imageWithResourcesPathCompontent:@"kong.png"];
        UIImageView *coverImageView = [[UIImageView alloc] init];
        coverImageView.frame = CGRectMake(0.0, 0.0, self.width, self.height);
        [coverImageView setImage:kongImage];
        [self addSubview:coverImageView];
    }
    return self;
}

//绘图创建圆形图片
-(void)createRoundedImageView:(UIImage *)image borderSize:(NSInteger)borderSize
{
    UIImage *roundedImage = [self circleImage:image withParam:0.0];
    [self setImage:roundedImage];
}

-(void)setPrototypeImage:(UIImage *)prototypeImage
{
    if (_prototypeImage != prototypeImage)
    {
        _prototypeImage = prototypeImage;
        [self setImage:_prototypeImage];
        //[self createRoundedImageView:prototypeImage borderSize:_borderSize];
    }
}

-(void)setBorderSize:(NSInteger)borderSize
{
    if (_borderSize != borderSize)
    {
        _borderSize = borderSize;
    }
}

-(UIImage*)circleImage:(UIImage*)image withParam:(CGFloat)inset
{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, _borderSize);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGRect rect = CGRectMake(inset,
                             inset,
                             image.size.width - inset * 2.0f,
                             image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);

    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 5);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGRect r = CGRectMake(10, 10, image.size.width - 20, image.size.height - 20);
    CGContextAddEllipseInRect(context, r);
    CGContextFillEllipseInRect(context, r);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
