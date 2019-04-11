//
//  DCLoginViewController.m
//  warehouse
//
//  Created by 大橙子 on 2019/4/3.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCLoginViewController.h"
#import "DCQRScanVC.h"
@interface DCLoginViewController ()<WKNavigationDelegate,jsApiDelegate>
{
    DCJsApi *jsApi;
}
@end

@implementation DCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *scanbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scanbtn.frame = CGRectMake(100, 100, 100, 100);
    scanbtn.backgroundColor = [UIColor redColor];
    [scanbtn addTarget:self action:@selector(btnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanbtn];
    
//    [self setUpWebView];

}
-(void)btnDidClick {
    //条形码
    __weak typeof(self) weakself = self;
    DCQRScanVC *scanVc = [DCQRScanVC ScanWithUIType:ScanUITypeZhiFuBao codeType:ScanCodeTypeBar scanType:ScanOtherType doneBlock:^(NSString *resultStr) {
        DCLog(@"resultStr---%@",resultStr);
    }];
    [self.navigationController pushViewController:scanVc animated:YES];
}

-(void)setUpWebView {
    DWKWebView *webView = [[DWKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    [self.view addSubview:webView];
    
    DCJsApi *jsApi = [[DCJsApi alloc]init];
    jsApi.delegate = self;
    [webView addJavascriptObject:jsApi namespace:nil];
    [webView setDebugMode:true];
    
    webView.scrollView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [webView reload];
        [webView.scrollView.mj_header endRefreshing];
    }];
    //    [webView customJavascriptDialogLabelTitles:@{@"alertTitle":@"Notification",@"alertBtn":@"OK"}];
    
    webView.navigationDelegate=self;
    
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString *htmlPath = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"html"];
    NSString *htmlContent = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:htmlContent baseURL:baseURL];
    
    // call javascript method
    [webView callHandler:@"addValue" arguments:@[@3,@4] completionHandler:^(NSNumber * value){
        NSLog(@"%@",value);
    }];
    
    [webView callHandler:@"append" arguments:@[@"I",@"love",@"you"] completionHandler:^(NSString * _Nullable value) {
        NSLog(@"call succeed, append string is: %@",value);
    }];
    
    // this invocation will be return 5 times
    [webView callHandler:@"startTimer" completionHandler:^(NSNumber * _Nullable value) {
        NSLog(@"Timer: %@",value);
    }];
    
    // namespace syn test
    [webView callHandler:@"syn.addValue" arguments:@[@5,@6] completionHandler:^(NSDictionary * _Nullable value) {
        NSLog(@"Namespace syn.addValue(5,6): %@",value);
    }];
    
    [webView callHandler:@"syn.getInfo" completionHandler:^(NSDictionary * _Nullable value) {
        NSLog(@"Namespace syn.getInfo: %@",value);
    }];
    
    // namespace asyn test
    [webView callHandler:@"asyn.addValue" arguments:@[@5,@6] completionHandler:^(NSDictionary * _Nullable value) {
        NSLog(@"Namespace asyn.addValue(5,6): %@",value);
    }];
    
    [webView callHandler:@"asyn.getInfo" completionHandler:^(NSDictionary * _Nullable value) {
        NSLog(@"Namespace asyn.getInfo: %@",value);
    }];
    
    // test if javascript method exists.
    [webView hasJavascriptMethod:@"addValue" methodExistCallback:^(bool exist) {
        NSLog(@"method 'addValue' exist : %d",exist);
    }];
    
    [webView hasJavascriptMethod:@"XX" methodExistCallback:^(bool exist) {
        NSLog(@"method 'XX' exist : %d",exist);
    }];
    
    [webView hasJavascriptMethod:@"asyn.addValue" methodExistCallback:^(bool exist) {
        NSLog(@"method 'asyn.addValue' exist : %d",exist);
    }];
    
    [webView hasJavascriptMethod:@"asyn.XX" methodExistCallback:^(bool exist) {
        NSLog(@"method 'asyn.XX' exist : %d",exist);
    }];
    
    // set javascript close listener
    [webView setJavascriptCloseWindowListener:^{
        NSLog(@"window.close called");
    } ];
}
-(void)setNavTitle:(NSDictionary *)info {
    NSLog(@"---%@",info);
}
//-(void)setNavTitle:(NSString *)title {
//    self.title = title;
//}

@end
