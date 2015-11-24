//
//  DMWebViewController.m
//  DamaiIphone
//
//  Created by lixiang on 14-1-13.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "DMWebViewController.h"
//#import "DMProjectDetailViewController.h"
#import "DMGlobalVar.h"
#import "NSStringAdditions.h"
////#import "CHTumblrMenuView.h"
//#import "DMProjectShareViewController.h"
//#import "DMShare.h"
//#import "DMTencentShare.h"
//#import "DMUserCenterViewController.h"
//#import "DMUserOrderListViewController.h"
#import "WCAlertView.h"
@interface DMWebViewController () <UIWebViewDelegate> {
    UIWebView                   *_webView;
    UIButton                    *_backBtn;
    UIButton                    *_shareBtn;
}

@property (nonatomic, strong) NSString *shareTitle;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *forwardBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *refreshBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *stopBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *actionBarButtonItem;

@end

@implementation DMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleString;
    
    if (self.objectDic) {
        self.title = [self.objectDic objectForKey:@"maintitle"];
    }

    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 44)];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.delegate = self;

    [self.view addSubview:_webView];
    if (self.htmlStr) {
        [_webView loadHTMLString:self.htmlStr baseURL:nil];
    } else {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.httpUrl]
                                               cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                           timeoutInterval:5]];
    }
    if (!_hiddenToolBar) {
        self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        self.toolbar.barStyle = UIBarStyleDefault;

        self.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackClicked:)];
        self.backBarButtonItem.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
        self.backBarButtonItem.width = 18.0f;
        
        self.forwardBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward.png"] style:UIBarButtonItemStylePlain target:self action:@selector(goForwardClicked:)];
        //    self.forwardBarButtonItem.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
        self.forwardBarButtonItem.width = 18.0f;
        
        self.refreshBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadClicked:)];
        
        self.stopBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopClicked:)];
        
        [self updateToolbarItems];
        [self.view addSubview:self.toolbar];
    } else {
        _webView.height = CGRectGetHeight(self.view.bounds);
    }
    
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 32, 32)];
    [_backBtn setImage:[UIImage imageNamed:@"btn_star_back.png"] forState:UIControlStateNormal];
    [_backBtn setImage:[UIImage imageNamed:@"btn_star_back_click.png"] forState:UIControlStateHighlighted];
    [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    
    if (self.objectDic) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icons_share_white.png"]
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(shareAction)];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    self.toolbar.frame = CGRectMake(0, _webView.bottom, kSeperatorWidth, 44);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateToolbarItems {
    
    self.backBarButtonItem.enabled = _webView.canGoBack;
    self.forwardBarButtonItem.enabled = _webView.canGoForward;
    self.actionBarButtonItem.enabled = !_webView.isLoading;
    
    UIBarButtonItem *refreshStopBarButtonItem = _webView.isLoading ? self.stopBarButtonItem : self.refreshBarButtonItem;
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flexibleSpace.width = 40;
    NSArray *items = [NSArray arrayWithObjects:
                      flexibleSpace,
                      self.backBarButtonItem,
                      flexibleSpace,
                      self.forwardBarButtonItem,
                      flexibleSpace,
                      refreshStopBarButtonItem,
                      flexibleSpace,
                      nil];
    
    [self.toolbar setItems:items];
    
}
#pragma mark -
#pragma mark ButtonClicked
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)shareAction
{
}

- (void)goBackClicked:(UIBarButtonItem *)sender {
    [_webView goBack];
}

- (void)goForwardClicked:(UIBarButtonItem *)sender {
    [_webView goForward];
}

- (void)reloadClicked:(UIBarButtonItem *)sender {
    [_webView reload];
}

- (void)stopClicked:(UIBarButtonItem *)sender {
    [_webView stopLoading];
	[self updateToolbarItems];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"absoluteString:%@", request.URL.absoluteString);
    
//    NSString *absoluteString = request.URL.absoluteString;
//    if ([absoluteString containsString:[NSString stringWithFormat:@"%@/damaijump.a",DMAPIBaseURL] options:NSCaseInsensitiveSearch]) {
//        NSDictionary *dic = [self dictionaryFromQuery:[[NSURL URLWithString:absoluteString] query] usingEncoding:NSUTF8StringEncoding];
//        return NO;
//    }
    
       return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self updateToolbarItems];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self updateToolbarItems];
    NSString *string = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //    NSString *href = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    
    
    NSRange range = [string rangeOfString:@"-"];
    if (range.location != NSNotFound && range.location + 1 != NSNotFound ) {
        string = [string substringFromIndex:range.location + 1];
    }
    
    if (self.titleString.length > 0 ) {
        string = self.titleString;
    }
    if (self.externalNet) {
        self.title = string;
    }
    if (self.objectDic) {
        self.title = [self.objectDic objectForKey:@"maintitle"];
    }
    self.shareTitle = string;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    [self showErrorViewWithText:kNetworkErrorText];
    [self updateToolbarItems];
}


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
