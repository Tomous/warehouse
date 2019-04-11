//
//  DCBaseWebViewController.m
//  warehouse
//
//  Created by 大橙子 on 2019/4/9.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCBaseWebViewController.h"

@interface DCBaseWebViewController ()<WKNavigationDelegate>

@end

@implementation DCBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpWebView];
}
-(void)setUpWebView {
    self.webView = [[DWKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, ScreenHeight-navHeight-statusHeight-bottomSafeHeight)];
    [self.view addSubview:self.webView];
    
    self.jsApi = [[DCJsApi alloc]init];
    self.jsApi.delegate = self;
    [self.webView addJavascriptObject:self namespace:nil];
    [self.webView setDebugMode:true];
    
    self.webView.scrollView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [self.webView reload];
        [self.webView.scrollView.mj_header endRefreshing];
    }];
    //    [webView customJavascriptDialogLabelTitles:@{@"alertTitle":@"Notification",@"alertBtn":@"OK"}];
    
    self.webView.navigationDelegate=self;
    
    [self.webView loadUrl:@"http://172.20.7.252:9301/"];
    
    
    
    // call javascript method
//    [self.webView callHandler:@"addValue" arguments:@[@3,@4] completionHandler:^(NSNumber * value){
//        NSLog(@"%@",value);
//    }];
//
//    [self.webView callHandler:@"append" arguments:@[@"I",@"love",@"you"] completionHandler:^(NSString * _Nullable value) {
//        NSLog(@"call succeed, append string is: %@",value);
//    }];
//
//    // this invocation will be return 5 times
//    [self.webView callHandler:@"startTimer" completionHandler:^(NSNumber * _Nullable value) {
//        NSLog(@"Timer: %@",value);
//    }];
//
//    // namespace syn test
//    [self.webView callHandler:@"syn.addValue" arguments:@[@5,@6] completionHandler:^(NSDictionary * _Nullable value) {
//        NSLog(@"Namespace syn.addValue(5,6): %@",value);
//    }];
//
//    [self.webView callHandler:@"syn.getInfo" completionHandler:^(NSDictionary * _Nullable value) {
//        NSLog(@"Namespace syn.getInfo: %@",value);
//    }];
    
//    // namespace asyn test
//    [self.webView callHandler:@"asyn.addValue" arguments:@[@5,@6] completionHandler:^(NSDictionary * _Nullable value) {
//        NSLog(@"Namespace asyn.addValue(5,6): %@",value);
//    }];
//    
//    [self.webView callHandler:@"asyn.getInfo" completionHandler:^(NSDictionary * _Nullable value) {
//        NSLog(@"Namespace asyn.getInfo: %@",value);
//    }];
//    
//    // test if javascript method exists.
//    [self.webView hasJavascriptMethod:@"addValue" methodExistCallback:^(bool exist) {
//        NSLog(@"method 'addValue' exist : %d",exist);
//    }];
//    
//    [self.webView hasJavascriptMethod:@"XX" methodExistCallback:^(bool exist) {
//        NSLog(@"method 'XX' exist : %d",exist);
//    }];
//    
//    [self.webView hasJavascriptMethod:@"asyn.addValue" methodExistCallback:^(bool exist) {
//        NSLog(@"method 'asyn.addValue' exist : %d",exist);
//    }];
//    
//    [self.webView hasJavascriptMethod:@"asyn.XX" methodExistCallback:^(bool exist) {
//        NSLog(@"method 'asyn.XX' exist : %d",exist);
//    }];
//    
//    // set javascript close listener
//    [self.webView setJavascriptCloseWindowListener:^{
//        NSLog(@"window.close called");
//    } ];
}

@end
