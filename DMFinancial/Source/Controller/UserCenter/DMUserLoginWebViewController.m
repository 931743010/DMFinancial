//
//  DMUserLoginWebViewController.m
//  DamaiIphone
//
//  Created by 陈彦岐 on 14/11/13.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "DMUserLoginWebViewController.h"

@interface DMUserLoginWebViewController () <UIWebViewDelegate> {
    UIWebView                   *_webView;
}

@end
@implementation DMUserLoginWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联合登录";
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.delegate = self;
    NSString *url = @"https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=206444&redirect_uri=http://m.damai.cn/userloginbyqq.aspx?";
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                       timeoutInterval:5]];
    [self.view addSubview:_webView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"absoluteString:%@", request.URL.absoluteString);
    
    NSMutableString *absoluteString = (NSMutableString *)request.URL.absoluteString;
    if ([absoluteString containsString:@"http://m.damai.cn/userloginbyqq.aspx?code="
                               options:NSCaseInsensitiveSearch]) {
        NSString *code = [absoluteString stringByReplacingOccurrencesOfString:@"http://m.damai.cn/userloginbyqq.aspx?code=" withString:@""];
        NSString *url = [NSString stringWithFormat:@"https://graph.qq.com/oauth2.0/token?grant_type=authorization_code&client_id=206444&client_secret=1ceaddb327b8bfbf4383eef18f0c7d22&code=%@&redirect_uri=http://m.damai.cn/userloginbyqq.aspx?",code];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                               cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                           timeoutInterval:5]];
//        return NO;
    } else if ([absoluteString containsString:@"https://graph.qq.com/oauth2.0/token?"
                                      options:NSCaseInsensitiveSearch]) {

    }
    return YES;
}

//- (void)webViewDidStartLoad:(UIWebView *)webView {
//    [self updateToolbarItems];
//}
//
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *jsToGetHTMLSource = @"document.body.innerText";
    NSString *HTMLSource = [webView stringByEvaluatingJavaScriptFromString:jsToGetHTMLSource];

    //    NSString *href = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    
    if ([HTMLSource containsString:@"access_token="
                               options:NSCaseInsensitiveSearch]) {
        NSRange range1 = [HTMLSource rangeOfString:@"="];
        NSRange range2 = [HTMLSource rangeOfString:@"&"];
        
        if (range1.location != NSNotFound && range1.location + 1 != NSNotFound && range2.location != NSNotFound && range1.location + 1 != NSNotFound ) {
            NSRange range;
            range.location = range1.location + 1;
            range.length = range2.location - range1.location - 1;
            HTMLSource = [HTMLSource substringWithRange:range];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DMUserLoginWebViewController" object:HTMLSource];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
//    self.shareTitle = string;
}

@end
