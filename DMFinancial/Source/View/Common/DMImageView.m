//
//  DMImageView.m
//  CommonLibrary
//
//  Created by lixiang on 14-4-1.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "DMImageView.h"
#import "UIImageAdditions.h"

@implementation DMImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}

//- (void)setImage:(UIImage *)image {
//    [super setImage:image];
//    self.alpha = 0.0;
//    [UIView animateWithDuration:1.0
//                     animations:^{
//                         self.alpha = 1.0;
//                     }];
//}
//

@end
