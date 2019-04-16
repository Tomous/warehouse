//
//  DCLoginViewController.m
//  warehouse
//
//  Created by 大橙子 on 2019/4/3.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCLoginViewController.h"
#import "DCQRScanVC.h"
@interface DCLoginViewController ()
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
}
-(void)btnDidClick {
    //条形码
    __weak typeof(self) weakself = self;
    DCQRScanVC *scanVc = [DCQRScanVC ScanWithUIType:ScanUITypeZhiFuBao codeType:ScanCodeTypeBar scanType:ScanOtherType doneBlock:^(NSString *resultStr) {
        DCLog(@"resultStr---%@",resultStr);
    }];
    [self.navigationController pushViewController:scanVc animated:YES];
}

@end
