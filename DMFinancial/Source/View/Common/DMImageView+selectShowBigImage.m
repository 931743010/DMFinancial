//
//  DMImageView+selectShowBigImage.m
//  CommonLibrary
//
//  Created by 陈彦岐 on 15/5/5.
//  Copyright (c) 2015年 damai. All rights reserved.
//

#import "DMImageView+selectShowBigImage.h"
#import "UIViewAdditions.h"
#import "UIImageView+WebCache.h"
#import <objc/runtime.h>


static char kURLKey;
static char kImgeKey;
@implementation DMImageView (selectShowBigImage)

- (void)setBigImageUrl:(NSString *)url placeholderImage:(UIImage *)image {
    
    objc_setAssociatedObject(self, &kURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &kImgeKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //清除所有手势
    for (UIGestureRecognizer *gestureRecognizer in self.gestureRecognizers) {
        [self removeGestureRecognizer:gestureRecognizer];
    }
    //添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(selectedImageView)];
    [self addGestureRecognizer:tap];
}

- (void)selectedImageView {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIImage *placeImage = (UIImage *)objc_getAssociatedObject(self, &kImgeKey);
    UIView *view = [[UIView alloc] initWithFrame:window.bounds];
    view.backgroundColor = [UIColor blackColor];
    UIImageView *bigImageView = [[UIImageView alloc]init];
    bigImageView.backgroundColor = [UIColor redColor];
    [view addSubview:bigImageView];
    bigImageView.width = view.bounds.size.width;
    CGFloat scale = view.bounds.size.width / placeImage.size.width;
    bigImageView.height = placeImage.size.height * scale;
    bigImageView.centerX = view.width * 0.5;
    bigImageView.centerY = view.height *0.5;
    NSString *urlStr =  (NSString *)objc_getAssociatedObject(self, &kURLKey);
    [bigImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]
                          placeholderImage:placeImage];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(selectedBlackView:)];
    [view addGestureRecognizer:tap];

    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

- (void)selectedBlackView:(UITapGestureRecognizer *)tapGesture {
    [tapGesture.view removeFromSuperview];
}

@end
