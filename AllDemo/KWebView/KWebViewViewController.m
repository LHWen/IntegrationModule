//
//  KWebViewViewController.m
//  AllDemo
//
//  Created by yuhui on 17/3/31.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "KWebViewViewController.h"
#import <WebKit/WebKit.h>

@interface KWebViewViewController ()<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *kWebView;

@end

@implementation KWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _kWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    _kWebView.navigationDelegate = self;
    _kWebView.UIDelegate = self;
    [_kWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];    // 注意 https
    [self.view addSubview:_kWebView];
}

#pragma mark -- WKNavigationDelegate

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载...");
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"内容开始返回...");
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"网页加载成功，在此做其他操作");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"WKWebView" message:@"网页加载成功，在此做其他操作" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"页面加载失败...");
}

//------------------------------- 页面跳转的代理有三种 -----------------------
//// 接收到服务器跳转请求之后调用
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
//    
//}
//
//// 在收到响应后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
//    
//}
//
//// 在发送请求之前，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    
//}

#pragma mark -- WKUIDelegate

//// 创建一个新的WebView
//- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
//    
//    WKWebView *newsWKWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, self.view.bounds.size.height-300)];
//    newsWKWebView.navigationDelegate = self;
//    newsWKWebView.UIDelegate = self;
//    [newsWKWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jianshu.com"]]];    // 注意 https
//    
//    return newsWKWebView;
//}
//
///** 显示一个JS的Alert（与JS交互）
// *  web界面中有弹出警告框时调用
// *  @param webView           实现该代理的webview
// *  @param message           警告框中的内容
// *  @param frame             主窗口
// *  @param completionHandler 警告框消失调用
// */
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
//    
//}
//
///** 显示一个确认框（JS的）
// *  @abstract显示一个JavaScript确认面板。
// *  @param webView web视图调用委托方法。
// *  @param消息显示的消息。
// *  @param帧的信息帧的JavaScript发起这个调用。
// *  @param completionHandler确认后完成处理程序调用面板已经被开除。
// *  是的如果用户选择OK,如果用户选择取消。
// *  @discussion用户安全,您的应用程序应该调用注意这样一个事实一个特定的网站控制面板中的内容。
// * 一个简单的forumla对于识别frame.request.URL.host控制的网站。该小组应该有两个按钮,如可以取消。
// * 如果你不实现这个方法,web视图会像如果用户选择取消按钮。
// */
//- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
//    
//}
//
///** 弹出一个输入框（与JS交互的）
// *  @abstract JavaScript显示一个文本输入面板。
// *  @param webView web视图调用委托方法。
// *  @param消息显示的消息。
// *  @param defaultText初始文本显示在文本输入字段。
// *  @param帧的信息帧的JavaScript发起这个调用。
// *  @param completionHandler后完成处理器调用文本输入面板已被撤职。如果用户选择了通过输入文本好吧,否则零。
// *  @discussion用户安全,您的应用程序应该调用注意这样一个事实一个特定的网站控制面板中的内容。
// *  一个简单的forumla对于识别frame.request.URL.host控制的网站。该小组应该有两个按钮,可以取消,和一个字段等输入文本。
// *  如果你不实现这个方法,web视图会像如果用户选择取消按钮。
// */
//- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
//    
//}
//
//// WebVeiw关闭（9.0中的新方法）
//- (void)webViewDidClose:(WKWebView *)webView {
//    
//}
//


#pragma mark -- WKScriptMessageHandler

//// 从web界面中接收到一个脚本时调用
//- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
// 
//    NSLog(@"%@",message.body);
//}
//


@end
