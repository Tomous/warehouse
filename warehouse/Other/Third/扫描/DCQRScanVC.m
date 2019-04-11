//
//  DCQRScanVC.m
//  TomousTool
//
//  Created by 大橙子 on 2018/6/26.
//  Copyright © 2018年 中都格罗唯视. All rights reserved.
//

#import "DCQRScanVC.h"
#import "StyleDIY.h"
@interface DCQRScanVC ()
@property (nonatomic,assign) ScanUIType type;
@property(nonatomic, copy) void (^scanSuccessBlock)(NSString *resultStr);
@end

@implementation DCQRScanVC

+(instancetype)ScanWithUIType:(ScanUIType)type codeType:(ScanCodeType)scanCodeType scanType:(ScanType)scanType doneBlock:(void (^)(NSString *))scanSuccessBlock{
    DCQRScanVC *qrScanVC = [[DCQRScanVC alloc]init];
    switch (type) {
        case ScanUITypeQQ:
        {
            qrScanVC.style = [StyleDIY qqStyle];
        }
            break;
        case ScanUITypeWX:
        {
            qrScanVC.style = [StyleDIY weixinStyle];
        }
            break;
        case ScanUITypeZhiFuBao:
        {
            qrScanVC.style = [StyleDIY ZhiFuBaoStyle];
        }
            break;
            
        default:
            break;
    }
    qrScanVC.scanCodeType = scanCodeType;
    qrScanVC.scanType = scanType;
    qrScanVC.isOpenInterestRect = YES;
    qrScanVC.scanSuccessBlock = scanSuccessBlock;
    
    return qrScanVC;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
//    self.title = @"出库";
}

- (void)showNextVCWithScanResult:(LBXScanResult*)strResult
{
    if (self.scanType == ScanOtherType) {
        if (self.scanSuccessBlock) {
            self.scanSuccessBlock(strResult.strScanned);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        
        if (strResult.strScanned.length>0) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            AudioServicesPlaySystemSound(1007);
//            [self vinTest:strResult.strScanned.length6];
        }else{
            [SVProgressHUD showErrorWithStatus:@"扫描失败"];
            [SVProgressHUD dismissWithDelay:2 completion:^{
                [self initQcode];
            }];
        }
    }
}
- (void)initQcode
{
    [super viewDidAppear:YES];

}
//- (void)vinTest:(NSString *)result
//{
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    dic[@"vin"] = result;
//
////    __weak typeof(self) weakself = self;
////    [DCServiceTool postWithUrl:outboundByVin_URL params:dic success:^(id responseObject) {
////
////        if ([responseObject[@"code"] integerValue] == 0) {
////            !weakself.resultBlock?:weakself.resultBlock(result);//请求上个页面刷新
////            weakself.check ++;
////            weakself.num.attributedText = [YLAttributedStr changeSubStringWithTotalString:[NSString stringWithFormat:@"已扫描 %d/%d",weakself.check,self.total] subStringColor:[UIColor redColor] subString:[NSString stringWithFormat:@"%d",weakself.check] andFont:FONT(25)];
////            if (weakself.check == self.total){
////                [SVProgressHUD showSuccessWithStatus:@"已全部出库完成！"];
////                [[NSNotificationCenter defaultCenter]postNotificationName:@"OutboundByVinSuccess" object:nil];
////                [SVProgressHUD dismissWithDelay:1 completion:^{
////                    [self.navigationController popViewControllerAnimated:YES];
////                }];
////            }else{
////                [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"msg"]]];
////                [SVProgressHUD dismissWithDelay:2 completion:^{
////                    [self initQcode];
////                }];
////            }
////        }else{
////            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
////            [SVProgressHUD dismissWithDelay:1 completion:^{
////                [self initQcode];
////            }];
////        }
////    } failure:^(NSError *error) {
////        [SVProgressHUD showErrorWithStatus:@"数据异常"];
////        [SVProgressHUD dismissWithDelay:1 completion:^{
////            [self initQcode];
////        }];
////    }];
//
//}

@end
