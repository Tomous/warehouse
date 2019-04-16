
//
//  DCHomeViewController.m
//  warehouse
//
//  Created by 大橙子 on 2019/4/9.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCHomeViewController.h"
#import "DCQRScanVC.h"
@interface DCHomeViewController ()
@property (nonatomic,strong) UIBarButtonItem *backItem;
@end

@implementation DCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

/** 初始化title，同步方法，及时返回H5结果 */
-(NSString *)configWebViewBarSync:(NSDictionary *)info{
    DCNavTitleModel *model = [DCNavTitleModel mj_objectWithKeyValues:info];
    
    self.title = model.title;
    return [DCTool dictionaryToJson:@{@"errcode":@"0",@"errmsg":@"dsbridge success",@"data":@{}}];
}

/** 初始化menu右上角，同步方法，及时返回H5结果 */
-(void)configWebViewMenuSync:(NSDictionary *)info {
    
}
/** 异步获取扫描返回车辆vin direct扫描指令号返回指令号，调起原生扫码，并等待原生返回结果 */
- (void)sweepCode:(NSDictionary *)info :(JSCallback) completionHandler
{
//    __weak typeof(self) weakself = self;
    
    DCQRScanVC *scanVc = [DCQRScanVC ScanWithUIType:ScanUITypeZhiFuBao codeType:ScanCodeTypeBar scanType:ScanOtherType doneBlock:^(NSString *resultStr) {
        
        DCLog(@"resultStr---%@",resultStr);
        
        NSDictionary *dict = @{@"errcode":@"0",@"errmsg":@"dsbridge success",@"data":@{info[@"type"]:resultStr}};
        
        NSString *str =  [DCTool dictionaryToJson:dict];
        
        completionHandler(str,YES);
    }];
    [self.navigationController pushViewController:scanVc animated:YES];
    
}

@end
