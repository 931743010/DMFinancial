//
//  DMDetailProjSeatImgView.m
//  DamaiIphone
//
//  Created by 陈彦岐 on 14-2-19.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "DMDetailProjSeatImgView.h"

@interface DMDetailProjSeatImgView () <UIScrollViewDelegate>{
	UIScrollView *_scrollView;
    UIImageView *_imageView;
}

@end

@implementation DMDetailProjSeatImgView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 4000)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 1;
        [self addSubview:view];
        UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(handleSingleFingerEvent:)];
        //        singleFingerOne.numberOfTouchesRequired = 1; //手指数
        //        singleFingerOne.numberOfTapsRequired = 1; //tap次数
        singleFingerOne.delegate = self;
        [self addGestureRecognizer:singleFingerOne];
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.delegate = self;
        
        [self addSubview:_scrollView];
        _scrollView.contentSize = CGSizeMake(1000, 1000);
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _imageView.userInteractionEnabled = NO;
        [_scrollView addSubview:_imageView];
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    _scrollView.frame = self.frame;
}

-(void)setSeatImageUrl:(NSString *)seatImageUrl {
    
    _seatImageUrl = seatImageUrl;
//    [self loadImage:seatImageUrl];
    [NSThread detachNewThreadSelector:@selector(loadImage:) toTarget:self withObject:seatImageUrl];
}
// 加载图片
- (void)loadImage:(NSString *)imageURL
{
//    __weak DMDetailProjSeatImgView *weakView = self;
//    __weak UIImageView *weakImageView = _imageView;
//    
//    [_imageView sd_setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]]
//                      placeholderImage:nil
//                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//                                   [weakView updateView:image];
//                               } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//                                   weakImageView.frame = CGRectMake(0, 0, 0, 0);
//                               }];
//
//
    UIImage *image = [UIImage imageWithContentsOfURL:[NSURL URLWithString:imageURL]];
    [self performSelectorOnMainThread:@selector(updateView:) withObject:image waitUntilDone:YES];
    
}
- (void)updateView:(UIImage *)image {
    
    if (!image) {
        return;
    }
    _imageView.frame = CGRectMake(0, 0, 0, 0);
    _scrollView.frame = self.frame;
    _scrollView.center = self.center;

    CGFloat origin_x = fabs(_imageView.frame.size.width - image.size.width)/2.0;
    CGFloat origin_y = fabs(_imageView.frame.size.height - image.size.height)/2.0;
    _imageView.frame = CGRectMake(origin_x, origin_y, _scrollView.frame.size.width, _scrollView.frame.size.width*image.size.height/image.size.width);
    _imageView.center = _scrollView.center;
    [_imageView setImage:image];
    /*
     
     ** 设置UIScrollView的最大和最小放大级别（注意如果MinimumZoomScale == MaximumZoomScale，
     
     ** 那么UIScrllView就缩放不了了
     
     */
    _scrollView.minimumZoomScale = 0.5f;
    _scrollView.maximumZoomScale = 3.0f;
    _scrollView.zoomScale = 1.0f;
}
// 显示加载失败的提示对话框
- (void)showLoadFailedAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                          
                                                    message:@"加载图片失败"
                          
                                                   delegate:nil
                          
                                          cancelButtonTitle:@"确定"
                          
                                          otherButtonTitles:nil];
    [alert show];
}
//处理单指事件
- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)sender
{
    if (sender.numberOfTapsRequired == 1) {
        //单指单击
        if (!IsNilOrNull(_delegate) && [_delegate respondsToSelector:@selector(closeView:)]) {
            [_delegate closeView:self];
        }
    }else if(sender.numberOfTapsRequired == 2){
        //单指双击
        NSLog(@"单指双击");
    }
}

#pragma mark ---------- UIScrollViewDelegate ----------

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    //    [self layout];
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    _imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                    scrollView.contentSize.height * 0.5 + offsetY);
    //    _imageView.frame = CGRectMake(scrollView.left + 50, scrollView.top + 50, scrollView.width - 100, scrollView.height - 100);
}

@end
