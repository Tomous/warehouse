//
//  DCBaseWebViewController.m
//  warehouse
//
//  Created by 大橙子 on 2019/4/9.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCBaseWebViewController.h"

@interface DCBaseWebViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic,strong)UIBarButtonItem *backItem;
@end

@implementation DCBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.backItem = [UIBarButtonItem creatBarButtonItemWithNorImageName:@"back" higImageName:@"back" target:self active:@selector(back)];
    [self setUpWebView];
}
-(void)setUpWebView {
    self.webView = [[DWKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, ScreenHeight-navHeight-statusHeight-bottomSafeHeight)];
    [self.view addSubview:self.webView];

    [self.webView addJavascriptObject:self namespace:nil];
    [self.webView setDebugMode:true];
    
    self.webView.scrollView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [self.webView reload];
        [self.webView.scrollView.mj_header endRefreshing];
    }];
   
    self.webView.navigationDelegate=self;
    self.webView.UIDelegate = self;
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView loadUrl:DCWebRUL];

}
//WkWebView
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        if (object == self.webView) {
            self.title = self.webView.title;
            /* 根据title设置返回按钮 */
            if (![self.title isEqualToString:@"首页"] || ![self.title isEqualToString:@"基本资料"]) {
                self.navigationItem.leftBarButtonItem = self.backItem;
            }else {
                self.navigationItem.leftBarButtonItem = nil;
            }
        }else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"title"];
}
/* 返回 */
-(void)back{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}
@end
