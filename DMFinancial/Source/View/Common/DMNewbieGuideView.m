//
//  DMNewbieGuideView.m
//  DamaiIphone
//
//  Created by SongDong on 14-7-29.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "DMNewbieGuideView.h"

@implementation DMNewbieGuideView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}

/**
 *  显示新手引导view
 *  imageName新手引导界面背景图片名称（xxx.ipg/png)  view要加到的view
 */
-(void)showNewbieGuideViewWithImageName:(NSString *)imageName
                             inView:(UIView *)view
                      dismissbBlock:(dismissGuideViewBlock)block
{
    NSArray *imageNames = nil;
    if (imageName)
    {
        imageNames = [NSArray arrayWithObjects:imageName, nil];
    }
    [self showNewbieGuideViewWithImageNames:imageNames
                                     inView:view
                              dismissbBlock:block];
}


/**
 *  显示新手引导view
 *  imageName新手引导界面背景图片名称（xxx.ipg/png)数组  view要加到的view
 */
-(void)showNewbieGuideViewWithImageNames:(NSArray *)imageNameArray
                             inView:(UIView *)view
                      dismissbBlock:(dismissGuideViewBlock)block
{
    self.imageNameArray = imageNameArray;
    if (CGRectIsEmpty(self.frame) || CGRectIsNull(self.frame))
    {
        self.frame = view.bounds;
    }
    self.dismissblock = block;
    
    [view addSubview:self];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    
    
    self.guideImageView =[[UIImageView alloc] initWithFrame:self.bounds];
    UIImage *image = [UIImage imageWithResourcesPathCompontent:[self.imageNameArray objectAtIndex:0]];
    self.guideImageView.image = image;
    [self addSubview:self.guideImageView];
}

static int imageIndex = 0;
- (void)tapAction:(UITapGestureRecognizer *)gestureRecognizer
{
    imageIndex++;
    if (imageIndex < self.imageNameArray.count)
    {
        self.guideImageView.image = [UIImage imageWithResourcesPathCompontent:
                                     [self.imageNameArray objectAtIndex:imageIndex]];
    }
    else
    {
        imageIndex = 0;
        [self removeFromSuperview];
        if (self.dismissblock)
        {
            self.dismissblock();
        }
    }
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
