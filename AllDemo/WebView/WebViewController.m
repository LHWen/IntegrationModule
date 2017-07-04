//
//  WebViewController.m
//  AllDemo
//
//  Created by yuhui on 17/2/6.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;  // 搜索条
@property (nonatomic, strong) UIButton *searchButton;  // 搜索按钮
@property (nonatomic, strong) UIWebView *webView;      // 加载的网页视图

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"加载网页";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    [self setupViewLayout];
    
}

- (void)setupViewLayout {
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.placeholder = @"http://www.baidu.com";
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-85);
        make.height.mas_equalTo(30);
    }];
    
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchButton.backgroundColor = [UIColor clearColor];
    [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [_searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _searchButton.layer.cornerRadius = 2.5;
    _searchButton.layer.borderColor = [UIColor grayColor].CGColor;
    _searchButton.layer.borderWidth = 1.0f;
    [_searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_searchButton];
    [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_searchBar.mas_right).offset(10);
        make.top.mas_equalTo(2);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(26);
    }];
    
    _webView = [[UIWebView alloc] init];
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(30);
    }];
}

// searchBar点击键盘搜索 代理
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
     NSLog(@"searchBarCancelButtonClicked");
    [self p_searchBarResignFirstResponder];
    
    [self p_loadWebViewURL];
}

// 搜索按钮点击事件
- (void)searchAction:(id)sender {
    
    NSLog(@"搜索点击");
    [self p_searchBarResignFirstResponder];
    
    [self p_loadWebViewURL];
}

// 加载网址
- (void)p_loadWebViewURL {
    
    NSString *urlText = _searchBar.text;
    
    NSURL *url = [NSURL URLWithString:urlText];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

// 放弃第一响应者
- (void)p_searchBarResignFirstResponder {
    
    [_searchBar resignFirstResponder];
}

@end
