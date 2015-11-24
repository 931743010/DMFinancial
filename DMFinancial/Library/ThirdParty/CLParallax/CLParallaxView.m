//
//  CLParallaxView.m
//  CLParallaxViewController
//
//  Created by lixiang on 14-4-17.
//  Copyright (c) 2014年 lixiang. All rights reserved.
//

#import "CLParallaxView.h"

@implementation CLParallaxView

- (void)dealloc {
    [_rootView removeObserver:self forKeyPath:@"contentOffset"];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)configWithParallaxContentView:(UIView *)parallaxContentView
                             rootView:(UIScrollView *)rootView
                       parallaxHeight:(CGFloat)parallaxHeight {
    
    _parallaxContentView       = parallaxContentView;
    _rootView                  = rootView;
    _parallaxHeight            = parallaxHeight;
    
    parallaxContentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), parallaxHeight);
    rootView.frame = self.bounds;
    rootView.contentInset = UIEdgeInsetsMake(parallaxHeight, 0, 0, 0);
//    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, parallaxHeight, CGRectGetWidth(rootView.bounds),CGRectGetHeight(rootView.bounds))];
//    bgview.backgroundColor = rootView.backgroundColor;
//    [rootView insertSubview:bgview atIndex:0];
    rootView.backgroundColor = [UIColor clearColor];
    rootView.showsVerticalScrollIndicator = NO;
    
    [self addSubview:parallaxContentView];
    [self addSubview:rootView];
    [rootView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];

}

#pragma mark ========== UIScrollViewDelegate ==========
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        UIView *parallaxContentView = self.parallaxContentView;
        CGRect originParallaxFrame = parallaxContentView.frame;

        float y = _rootView.contentOffset.y + _parallaxHeight;
//        NSLog(@"offset = %@", NSStringFromCGPoint(self.rootView.contentOffset));
//        NSLog(@"y =%f", y);
        if (y > 0) {
//            NSLog(@"top: %f", CGRectGetMinY(originParallaxFrame));
//            NSLog(@"sss: %f", originParallaxFrame.origin.y);
            
            CGFloat newHeight = _parallaxHeight - y;
            [parallaxContentView setHidden:(newHeight <= 0)];
            
            if (!parallaxContentView.hidden) {
                parallaxContentView.frame = CGRectMake(originParallaxFrame.origin.x,
                                                       originParallaxFrame.origin.y,
                                                       CGRectGetWidth(originParallaxFrame),
                                                       newHeight);
            }
        } else {
            CGFloat newHeight = _parallaxHeight - y;
            parallaxContentView.hidden = NO;
            parallaxContentView.frame = CGRectMake(originParallaxFrame.origin.x,
                                                   originParallaxFrame.origin.y,
                                                   CGRectGetWidth(originParallaxFrame),
                                                   newHeight);
        }
    }
}

@end
