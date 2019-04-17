//
//  DCBaseWebViewController.m
//  warehouse
//
//  Created by 大橙子 on 2019/4/9.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCBaseWebViewController.h"

@interface DCBaseWebViewController ()
//@property (nonatomic,strong)UIBarButtonItem *backItem;
//@property (nonatomic,strong)UIProgressView *progress;
@end

@implementation DCBaseWebViewController
#pragma mark 加载进度条
//- (UIProgressView *)progress {
//    if (!_progress) {
//        _progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
//        _progress.tintColor = [UIColor blueColor];
//        _progress.backgroundColor = [UIColor lightGrayColor];
//        [self.view addSubview:_progress];
//    }
//    return _progress;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.backItem = [UIBarButtonItem creatBarButtonItemWithNorImageName:@"back" higImageName:@"back" target:self active:@selector(back)];
//    [self setUpWebView];
}
//-(void)setUpWebView {
//    self.webView = [[DWKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, ScreenHeight-navHeight-statusHeight-bottomSafeHeight)];
//    [self.view addSubview:self.webView];
//
//    [self.webView addJavascriptObject:self namespace:nil];
//    [self.webView setDebugMode:true];
//
//    self.webView.navigationDelegate=self;
//    self.webView.UIDelegate = self;
////    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
//    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
//    [self.webView loadUrl:DCWebRUL];
//
//}
//-(NSString *)configWebViewBackSync:(NSDictionary *)info {
//    if ([info[@"isShowBack"] isEqualToString:@"true"]) {
//        self.navigationItem.leftBarButtonItem = self.backItem;
//    }
//    return [DCTool dictionaryToJson:@{@"errcode":@"0",@"errmsg":@"dsbridge success",@"data":@{}}];
//}
//WkWebView
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    DCLog(@"keyPath---%@",keyPath);
//    if ([keyPath isEqualToString:@"title"]) {
//        if (object == self.webView) {
////            self.title = self.webView.title;
////            DCLog(@"2222");
////            if (![self.title isEqualToString:@"首页"] || ![self.title isEqualToString:@"基本资料"]) {
////                self.navigationItem.leftBarButtonItem = self.backItem;
////            }else {
////                self.navigationItem.leftBarButtonItem = nil;
////            }
//        }else {
//            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//        }
//    }else if ([keyPath isEqualToString:@"estimatedProgress"]) {
//        if (object == self.webView) {
// 
//            /* 根据title设置返回按钮 */
////            if (self.webView.estimatedProgress == 1.0f) {
////                if ([self.webView canGoBack]) {
////                    DCLog(@"11111");
////                    self.navigationItem.leftBarButtonItem = self.backItem;
////                }else{
////                    DCLog(@"0000");
////                    self.navigationItem.leftBarButtonItem = nil;
////                }
////            }
////
//            DCLog(@"---%f",self.webView.estimatedProgress);
//            
//        }else {
//            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//        }
//    }else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//}
/* 禁止缩放 */
//-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
//    return nil;
//}
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    // 禁止放大缩小
//    NSString *injectionJSString = @"var script = document.createElement('meta');"
//    "script.name = 'viewport';"
//    "script.content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";"
//    "document.getElementsByTagName('head')[0].appendChild(script);";
//    [webView evaluateJavaScript:injectionJSString completionHandler:nil];
//
//}
//-(void)dealloc {
//    [self.webView removeObserver:self forKeyPath:@"title"];
////    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
//}
///* 返回 */
//-(void)back{
//    if ([self.webView canGoBack]) {
//        [self.webView goBack];
//    }
//}

@end
