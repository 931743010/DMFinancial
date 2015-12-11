//
//  DMWebView.h
//  DMWebViewDemo
//
//  Created by 陈彦岐 on 15/10/27.
//  Copyright (c) 2015年 dongle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DMWebView;
@protocol DMWebViewDelegate <NSObject>
@optional
- (void)DMWebView:(DMWebView *)webView panPopGesture:(UIPanGestureRecognizer *)pan;
- (void)DMWebViewBeginDragging:(DMWebView *)webView;
- (void)DMWebViewEndDragging:(DMWebView *)webView;
- (void)DMWebViewDidBack:(DMWebView *)webView;
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;

@end

@interface DMWebView : UIWebView
@property(nonatomic, weak) id<DMWebViewDelegate> webViewDelegate;
@property(nonatomic, assign) BOOL enablePanGesture;

@end
