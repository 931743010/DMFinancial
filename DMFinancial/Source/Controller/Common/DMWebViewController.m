//
//  DMWebViewController.m
//  DamaiIphone
//
//  Created by lixiang on 14-1-13.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "DMWebViewController.h"
#import "DMGlobalVar.h"
#import "NSStringAdditions.h"
#import "WCAlertView.h"
#import "DMWebView.h"
@interface DMWebViewController () <DMWebViewDelegate> {
    DMWebView                   *_webView;
    id _navPanTarget;
    SEL _navPanAction;
    UIBarButtonItem *_closeButtonItem;
}
@property (nonatomic, strong) NSString *shareTitle;

@end

@implementation DMWebViewController

-(void)dealloc {
    _webView.delegate = nil;
    [_webView stopLoading];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleString;
    
    // 获取系统默认手势Handler并保存
        NSMutableArray *gestureTargets = [self.navigationController.interactivePopGestureRecognizer valueForKey:@"_targets"];
        id gestureTarget = [gestureTargets firstObject];
        _navPanTarget = [gestureTarget valueForKey:@"_target"];
        _navPanAction = NSSelectorFromString(@"handleNavigationTransition:");

    self.navigationController.interactivePopGestureRecognizer.enabled = NO;

    _webView = [[DMWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.webViewDelegate = self;
    _webView.scalesPageToFit=YES;
    
    
    NSString *oldAgent = [_webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSString *myAgent = [NSString stringWithFormat:@"%@damai",oldAgent];
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:myAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    
    [self.view addSubview:_webView];
    if (self.htmlStr) {
        [_webView loadHTMLString:self.htmlStr baseURL:nil];
    } else {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.httpUrl]
                                               cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                           timeoutInterval:5]];
    }
    
    _closeButtonItem = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(closeItem:)];
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:self.navigationItem.leftBarButtonItems];

    [_closeButtonItem setImageInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    
    [items addObject:_closeButtonItem];
    
    self.navigationItem.leftBarButtonItems = items;
}

#pragma mark -
#pragma mark ButtonClicked
- (void)backButtonAction:(id)sender
{
    if (_webView.canGoBack) {
        _closeButtonItem.image = [UIImage imageNamed:@"Login_close"];
        [_webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"absoluteString:%@", request.URL.absoluteString);
    
//    NSString *absoluteString = request.URL.absoluteString;
    
    return YES;
}

/**
 *  关闭按钮回到RootViewController
 *
 *  @param item 按钮对象
 */
- (void)closeItem:(UIBarButtonItem *)item
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)DMWebView:(DMWebView *)webView panPopGesture:(UIPanGestureRecognizer *)pan{
    if (_navPanTarget && [_navPanTarget respondsToSelector:_navPanAction]) {
        
        [_navPanTarget performSelector:_navPanAction withObject:pan];
    }
}

- (void)DMWebViewBeginDragging:(DMWebView *)webView {
    self.navigationController.navigationBar.userInteractionEnabled = NO;
}

- (void)DMWebViewEndDragging:(DMWebView *)webView {
    
}

- (void)DMWebViewDidBack:(DMWebView *)webView {
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    if (webView.canGoBack) {
        _closeButtonItem.image = [UIImage imageNamed:@"Login_close"];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //    [self hideLoadingView];
    NSString *string = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //    NSString *href = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    
    NSRange range = [string rangeOfString:@"-"];
    if (range.location != NSNotFound && range.location + 1 != NSNotFound ) {
        string = [string substringFromIndex:range.location + 1];
    }
    
    if (self.titleString.length > 0 ) {
        string = self.titleString;
    }
    self.title = string;
    self.shareTitle = string;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

}

//- (NSDictionary*)dictionaryFromQuery:(NSString*)query {
//    NSURLComponents*wxNASAURLComponents = [NSURLComponents componentsWithString:query];
//    NSMutableDictionary *queryItemDict = [NSMutableDictionary dictionary];
//    NSArray* queryItems = wxNASAURLComponents.queryItems;
//    for (NSURLQueryItem* item in queryItems) {
//            [queryItemDict setObject:item.value forKey:item.name];
//    }
//    return queryItemDict;
//}
- (NSDictionary*)dictionaryFromQuery:(NSString*)query usingEncoding:(NSStringEncoding)encoding {
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:query];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSString* value = [[kvPair objectAtIndex:1]
                               stringByReplacingPercentEscapesUsingEncoding:encoding];
            [pairs setObject:value forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:pairs];
}

@end
