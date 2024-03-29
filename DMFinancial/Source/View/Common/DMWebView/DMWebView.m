//
//  DMWebView.m
//  DMWebViewDemo
//
//  Created by 陈彦岐 on 15/10/27.
//  Copyright (c) 2015年 dongle. All rights reserved.
//

#import "DMWebView.h"
@interface DMWebView()<UIWebViewDelegate>
@end

@implementation DMWebView{
    UIGestureRecognizer* popGesture_;
    CGFloat panStartX_;
    
    NSMutableArray *historyStack_;
    UIImageView *_historyView;
    
    id<UIWebViewDelegate> originDelegate_;
}

+ (UIImage *)screenshotOfView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, 0.0);
    
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    }
    else{
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (void)addShadowToView:(UIView *)view{
    CALayer *layer = view.layer;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:layer.bounds];
    layer.shadowPath = path.CGPath;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeZero;
    layer.shadowOpacity = 0.4f;
    layer.shadowRadius = 8.0f;
}

- (void)setDelegate:(id<UIWebViewDelegate>)delegate{
    originDelegate_ = delegate;
}

- (id<UIWebViewDelegate>)delegate{
    return originDelegate_;
}

- (void)goBack{
    [super goBack];
    
    [historyStack_ removeLastObject];
}

- (void)setEnablePanGesture:(BOOL)enablePanGesture{
    popGesture_.enabled = enablePanGesture;
}

- (BOOL)enablePanGesture{
    return popGesture_.enabled;
}

- (UIImageView *)historyView{
    if (!_historyView) {
        if (self.superview) {
            _historyView = [[UIImageView alloc] initWithFrame:self.bounds];
            [self.superview insertSubview:_historyView belowSubview:self];
        }
    }
    
    return _historyView;
}
- (id)init{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    historyStack_ = [NSMutableArray array];
    
    popGesture_ = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:popGesture_];
    
    [super setDelegate:self];
    
    [DMWebView addShadowToView:self];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self historyView].frame = self.bounds;
}

#pragma mark === gesture===
- (void)panGesture:(UIPanGestureRecognizer *)sender{
    CGPoint point = [sender translationInView:self];
    if (point.x >= 0 || sender.state == UIGestureRecognizerStateEnded) {
        if (![self canGoBack] || historyStack_.count == 0) {
            if (self.webViewDelegate && [self.webViewDelegate respondsToSelector:@selector(DMWebView:panPopGesture:)]) {
                [self.webViewDelegate DMWebView:self panPopGesture:sender];
            }
            
            return;
        }
    }
    if (sender.state == UIGestureRecognizerStateBegan) {
        panStartX_ = point.x;
        if (self.webViewDelegate && [self.webViewDelegate respondsToSelector:@selector(DMWebViewBeginDragging:)]) {
            [self.webViewDelegate DMWebViewBeginDragging:self];
        }
        
    }
    else if (sender.state == UIGestureRecognizerStateChanged){
        CGFloat deltaX = point.x - panStartX_;
        if (deltaX > 0) {
            if ([self canGoBack]) {
                assert([historyStack_ count] > 0);
                
                CGRect rc = self.frame;
                rc.origin.x = deltaX;
                self.frame = rc;
                [self historyView].image = [[historyStack_ lastObject] objectForKey:@"preview"];
                rc.origin.x = -self.bounds.size.width/2.0f + deltaX/2.0f;
                [self historyView].frame = rc;
            }
        }
    }
    else if (sender.state == UIGestureRecognizerStateEnded){
        
        if (self.webViewDelegate && [self.webViewDelegate respondsToSelector:@selector(DMWebViewEndDragging:)]) {
            [self.webViewDelegate DMWebViewEndDragging:self];
        }
        
        CGFloat deltaX = point.x - panStartX_;
        CGFloat duration = .5f;
        if ([self canGoBack]) {
            if (deltaX > self.bounds.size.width/4.0f) {
                [UIView animateWithDuration:(1.0f - deltaX/self.bounds.size.width)*duration animations:^{
                    CGRect rc = self.frame;
                    rc.origin.x = self.bounds.size.width;
                    self.frame = rc;
                    rc.origin.x = 0;
                    [self historyView].frame = rc;
                } completion:^(BOOL finished) {
                    CGRect rc = self.frame;
                    rc.origin.x = 0;
                    self.frame = rc;
                    [self goBack];
                    
                    [self historyView].image = nil;
                }];
                if (self.webViewDelegate && [self.webViewDelegate respondsToSelector:@selector(DMWebViewDidBack:)]) {
                    [self.webViewDelegate DMWebViewDidBack:self];
                }
                
            }
            else{
                [UIView animateWithDuration:(deltaX/self.bounds.size.width)*duration animations:^{
                    CGRect rc = self.frame;
                    rc.origin.x = 0;
                    self.frame = rc;
                    rc.origin.x = -self.bounds.size.width/2.0f;
                    [self historyView].frame = rc;
                } completion:^(BOOL finished) {
                    
                }];
            }
        }
    }
}

#pragma mark ===uiwebview===
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    BOOL ret = YES;
    
    if (originDelegate_ && [originDelegate_ respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        ret = [originDelegate_ webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    if (self.webViewDelegate && [self.webViewDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        ret = [self.webViewDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    BOOL isFragmentJump = NO;
    if (request.URL.fragment) {
        NSString *nonFragmentURL = [request.URL.absoluteString stringByReplacingOccurrencesOfString:[@"#" stringByAppendingString:request.URL.fragment] withString:@""];
        isFragmentJump = [nonFragmentURL isEqualToString:webView.request.URL.absoluteString];
    }
    
    BOOL isTopLevelNavigation = [request.mainDocumentURL isEqual:request.URL];
    
    BOOL isHTTP = [request.URL.scheme isEqualToString:@"http"] || [request.URL.scheme isEqualToString:@"https"];
    if (ret && !isFragmentJump && isHTTP && isTopLevelNavigation) {
        if ((navigationType == UIWebViewNavigationTypeLinkClicked || navigationType == UIWebViewNavigationTypeOther) && [[webView.request.URL description] length]) {
            if (![[[historyStack_ lastObject] objectForKey:@"url"] isEqualToString:[self.request.URL description]]) {
                UIImage *curPreview = [DMWebView screenshotOfView:self];
                [historyStack_ addObject:@{@"preview":curPreview, @"url":[self.request.URL description]}];
            }
        }
    }
    return ret;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    if (originDelegate_ && [originDelegate_ respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [originDelegate_ webViewDidStartLoad:webView];
    }
    
    if (self.webViewDelegate && [self.webViewDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.webViewDelegate webViewDidStartLoad:webView];
    }

}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (originDelegate_ && [originDelegate_ respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [originDelegate_ webViewDidFinishLoad:webView];
    }
    if (self.webViewDelegate && [self.webViewDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.webViewDelegate webViewDidFinishLoad:webView];
    }

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (originDelegate_ && [originDelegate_ respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [originDelegate_ webView:webView didFailLoadWithError:error];
    }
    if (self.webViewDelegate && [self.webViewDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.webViewDelegate webView:webView didFailLoadWithError:error];
    }

}



@end
