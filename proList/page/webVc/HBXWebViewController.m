//
//  HBXWebViewController.m
//  proList
//
//  Created by huangbaoxian on 2019/7/1.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXWebViewController.h"
#import <WebKit/WebKit.h>

#define KBottomHeight 40

@interface HBXWebViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIView *toolBar;
    
@end

@implementation HBXWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, PHONE_NAVIGATIONBAR_HEIGHT, self.view.width, self.view.height - PHONE_NAVIGATIONBAR_HEIGHT - kTabbarSafeBottomMargin - KBottomHeight)];
        [self.view addSubview:_webView];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - KBottomHeight- kTabbarSafeBottomMargin, self.view.width, KBottomHeight)];
        [self.view addSubview:_toolBar];
        [self creatItems];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD showWithStatus:@"加载中..."];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:APPCONTEXT.mainUrl]];
        [self.webView loadRequest:request];
    });
    
}
    
- (void)creatItems {
    
    CGFloat btnWith = (self.view.width - 30 - 15 * 3)/4;
    CGFloat btnHeight = KBottomHeight;
    CGFloat space = 15;
    
    self.toolBar.userInteractionEnabled = YES;
    NSArray *array = @[@"前进",@"后退",@"刷新",@"主页"];
    for (int i = 0 ; i < array.count; i++) {
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        btn.tag = i + 1000;
        [self.toolBar addSubview:btn];
        
        btn.frame = CGRectMake(15 + i *(btnWith + space), 0, btnWith, btnHeight);
    }
}
    
- (void)btnClick:(UIButton *)sender {
    NSInteger tag = sender.tag - 1000;
    switch (tag) {
        case 0:
                {
                    [self.webView goBack];
                }
        break;
        case 1:
                {
                    [self.webView goForward];
                }
        break;
        case 2:
                {
                   [self.webView reload];
                }
        break;
        case 3:
                {
                    [SVProgressHUD showWithStatus:@"加载中..."];
                    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://cpbang.app-updated.com/wap/iosapp/iosxiazai/index.html"]];
                    [self.webView loadRequest:request];
                    
                }
        break;
        default:
        break;
    }
}
    
#pragma mark - WKNavigationDelegate
    // 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
    // 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
    // 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"succ");
    [SVProgressHUD dismiss];
}
    // 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"failed");
}
    // 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
