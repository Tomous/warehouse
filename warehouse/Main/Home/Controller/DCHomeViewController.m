
//
//  DCHomeViewController.m
//  warehouse
//
//  Created by 大橙子 on 2019/4/9.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCHomeViewController.h"
#import "DCQRScanVC.h"
#import "DCNavTitleModel.h"
@interface DCHomeViewController ()<WKNavigationDelegate>
@property (nonatomic,strong) DWKWebView *webView;
@property (nonatomic,strong) UIBarButtonItem *backItem;
@end

@implementation DCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.backItem = [UIBarButtonItem creatBarButtonItemWithNorImageName:@"back" higImageName:@"back" target:self active:@selector(back)];
    [self setUpWebView];
}
#pragma Mark --UI
-(void)setUpWebView {
    self.webView = [[DWKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, ScreenHeight-navHeight-statusHeight-bottomSafeHeight)];
    [self.view addSubview:self.webView];
    
    [self.webView addJavascriptObject:self namespace:nil];
    [self.webView setDebugMode:true];
    self.webView.navigationDelegate=self;
    [self.webView loadUrl:DCWebRUL];
    self.webView.scrollView.bounces = NO;
    
//    self.webView.scrollView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
//        [self.webView.scrollView.mj_header endRefreshing];
//        [self.webView reload];
//    }];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
}
#pragma mark - h5调取原生方法
/**
 *   初始化title，同步方法，及时返回H5结果
 */
-(NSString *)configWebViewBarSync:(NSDictionary *)info{
    DCNavTitleModel *model = [DCNavTitleModel mj_objectWithKeyValues:info];
    
    self.title = model.title;
    return [DCTool dictionaryToJson:@{@"errcode":@"0",@"errmsg":@"dsbridge success",@"data":@{}}];
}
/**
 *   返回按钮的显示与隐藏
 */
-(NSString *)configWebViewBackSync:(NSDictionary *)args {

    DCNavTitleModel *model = [DCNavTitleModel mj_objectWithKeyValues:args];
    if (model.isShowBack) {
        self.navigationItem.leftBarButtonItem = self.backItem;
    }else{
        self.navigationItem.leftBarButtonItem = nil;
    }
    return [DCTool dictionaryToJson:@{@"errcode":@"0",@"errmsg":@"dsbridge success",@"data":@{}}];
}
/**
 *   初始化menu右上角，同步方法，及时返回H5结果
 */
-(void)configWebViewMenuSync:(NSDictionary *)info {
    
}

/**
 *   异步获取扫描返回车辆vin direct扫描指令号返回指令号，调起原生扫码，并等待原生返回结果
 */
- (void)sweepCode:(NSDictionary *)info :(JSCallback) completionHandler
{

    DCQRScanVC *scanVc = [DCQRScanVC ScanWithUIType:ScanUITypeZhiFuBao codeType:ScanCodeTypeBar scanType:ScanOtherType doneBlock:^(NSString *resultStr) {
        
        DCLog(@"resultStr---%@",resultStr);
        
        NSDictionary *dict = @{@"errcode":@"0",@"errmsg":@"dsbridge success",@"data":@{info[@"type"]:resultStr}};
        
        NSString *str =  [DCTool dictionaryToJson:dict];
        
        completionHandler(str,YES);
    }];
    [self.navigationController pushViewController:scanVc animated:YES];
    
}
/**
 *   返回
 */
-(void)back{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

#pragma mark -Delegate
/**
 *   监听获取webView的title
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        if (object == self.webView) {
            self.title = self.webView.title;
        }else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
//zhushi
/**
  选择照片
  
  @param info 返回字典 count: 照片个数  sourceType:"album相册/camera照相"  crop:"15:8"宽高比
  @param completionHandler 返回base64  type:图片格式png/jpg   path:图片路劲
  */
- (void)chooseImage:(NSDictionary *)info :(JSCallback) completionHandler
{
    NSDictionary *dict = @{@"errcode":@"0",@"errmsg":@"dsbridge success",@"data":@[@{@"base64":@"",@"width":@"",@"height ":@"",@"type":@"",@"path ":@""}]};
    NSString *str =  [DCTool dictionaryToJson:dict];
    completionHandler(str,YES);
    
}

/**  加此方法是因为正式环境登录之后出现空白页bug，此方法是拦截请求地址URL，目前是不管什么连接都允许通行 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    DCLog(@"url----%@",navigationAction.request.URL);
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end
