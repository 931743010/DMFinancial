//
//  DMNewcomerCell.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/30.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMNewcomerCell.h"

@implementation DMNewcomerCell {
    UIImageView *_imageView;//背景图片
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews {
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.backgroundColor = [UIColor grayColor];
    [self addSubview:_imageView];
}

-(void)setItem:(DMNewcomerItem *)item {
    [_imageView sd_setImageWithURL:[NSURL URLWithString:item.imageUrl] placeholderImage:nil];
}

@end
