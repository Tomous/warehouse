//
//
//  
//
//  Created by lbxia on 15/10/21.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "LBXScanViewController.h"
#import "LBXAlertAction.h"

@interface LBXScanViewController ()

#pragma mark - 提示文字

@property (nonatomic, strong) UILabel *topTitle;/**< 提示文字 */

#pragma mark - 底部几个功能：开启闪光灯、相册、我的二维码
@property (nonatomic, strong) UIView *bottomItemsView;/**< 底部显示的功能项 */

@property (nonatomic, strong) UIButton *btnPhoto;/**< 相册按钮 */

@property (nonatomic, strong) UIButton *btnFlash;/**< 闪光灯按钮 */

@property (nonatomic, strong) UIButton *btnMyQR;/**< 我的二维码按钮 */

@end

@implementation LBXScanViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = [UIColor blackColor];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self drawScanView];
    
    //不延时，可能会导致界面黑屏并卡住一会
    [self performSelector:@selector(startScan) withObject:nil afterDelay:0.2];
    
    [self.view addSubview:self.topTitle];
    [self.view addSubview:self.bottomItemsView];
    [self.view addSubview:self.numView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [_scanObj stopScan];
    
    [_qRScanView stopScanAnimation];
}

//绘制扫描区域
- (void)drawScanView
{
    if (!_qRScanView)
    {
        CGRect rect = self.view.frame;
        rect.origin = CGPointMake(0, 0);
        
        self.qRScanView = [[LBXScanView alloc]initWithFrame:rect style:_style];
        
        [self.view addSubview:_qRScanView];
    }
    [_qRScanView startDeviceReadyingWithText:@"相机启动中"];
}

- (void)reStartDevice
{
    [_scanObj startScan];
    
}

//启动设备
- (void)startScan
{
    if ( ![LBXScanPermissions cameraPemission] )
    {
        [_qRScanView stopDeviceReadying];
        
        [self showError:@"   请到设置隐私中开启本程序相机权限   "];
        return;
    }
    
    UIView *videoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    videoView.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:videoView atIndex:0];
    __weak __typeof(self) weakSelf = self;
    
    if (!_scanObj )
    {
        CGRect cropRect = CGRectZero;
        
        if (_isOpenInterestRect) {
            
            //设置只识别框内区域
            cropRect = [LBXScanView getScanRectWithPreView:self.view style:_style];
        }
        
        NSArray *strCodes = @[AVMetadataObjectTypeQRCode,
                              AVMetadataObjectTypeUPCECode,
                              AVMetadataObjectTypeCode39Code,
                              AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeEAN13Code,
                              AVMetadataObjectTypeEAN8Code,
                              AVMetadataObjectTypeCode93Code,
                              AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypePDF417Code,
                              AVMetadataObjectTypeAztecCode];
//        self.title = @"二维码";
//        if(self.scanCodeType == ScanCodeTypeBar){
//            strCodes = @[AVMetadataObjectTypeEAN13Code,
//              AVMetadataObjectTypeEAN8Code,
//              AVMetadataObjectTypeCode128Code];
//            self.title = @"条形码";
//        }
        
        //AVMetadataObjectTypeITF14Code 扫码效果不行,另外只能输入一个码制，虽然接口是可以输入多个码制
        self.scanObj = [[LBXScanNative alloc]initWithPreView:videoView ObjectType:strCodes cropRect:cropRect success:^(NSArray<LBXScanResult *> *array) {

            [weakSelf scanResultWithArray:array];
        }];
        [_scanObj setNeedCaptureImage:_isNeedScanImage];
    }
    [_scanObj startScan];
    
    [_qRScanView stopDeviceReadying];
    
    [_qRScanView startScanAnimation];
    
    self.view.backgroundColor = [UIColor clearColor];
}

#pragma mark - 扫码结果（实现类继承该方法，作出对应处理）

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    if (!array ||  array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //经测试，可以同时识别2个二维码，不能同时识别二维码和条形码
//    for (LBXScanResult *result in array) {
//        
//        NSLog(@"scanResult:%@",result.strScanned);
//    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString*strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //震动提醒
//     [LBXScanWrapper systemVibrate];
    //声音提醒
    //[LBXScanWrapper systemSound];
    
    [self showNextVCWithScanResult:scanResult];
    
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    if (!strResult) {
        
        strResult = @"识别失败";
    }
    
    __weak __typeof(self) weakSelf = self;
    [LBXAlertAction showAlertWithTitle:@"扫码内容" msg:strResult buttonsStatement:@[@"知道了"] chooseBlock:^(NSInteger buttonIdx) {
        
        [weakSelf reStartDevice];
    }];
}

- (void)showNextVCWithScanResult:(LBXScanResult*)strResult
{
    
//    ScanResultViewController *vc = [ScanResultViewController new];
//    vc.imgScan = strResult.imgScanned;
//    
//    vc.strScan = strResult.strScanned;
//    
//    vc.strCodeType = strResult.strBarCodeType;
//    
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --打开相册并识别图片

/*!
 *  打开本地照片，选择图片识别
 */
- (void)openLocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.delegate = self;
   
    //部分机型有问题
//    picker.allowsEditing = YES;
    
    
    [self presentViewController:picker animated:YES completion:nil];
}



//当选择一张图片后进入这里

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];    
    
    __block UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (!image){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0)
    {
        __weak __typeof(self) weakSelf = self;
        [LBXScanNative recognizeImage:image success:^(NSArray<LBXScanResult *> *array) {
            [weakSelf scanResultWithArray:array];
        }];
    }
    else
    {
        [self showError:@"native低于ios8.0系统不支持识别图片条码"];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancel");
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//子类继承必须实现的提示
- (void)showError:(NSString*)str
{
     [LBXAlertAction showAlertWithTitle:@"提示" msg:str buttonsStatement:@[@"知道了"] chooseBlock:nil];
}

#pragma mark - *** aciones 点击方法 ***

#pragma mark -> 相册 点击(native低于ios8.0不支持识别图片)
- (void)openPhoto
{
    if ([LBXScanPermissions cameraPemission])
        [self openLocalPhoto];
    else
    {
        [self showError:@"      请到设置->隐私中开启本程序相册权限     "];
    }
}

#pragma mark -> 闪光灯 点击

- (void)openOrCloseFlash:(UIButton *)btn
{
    
    [_scanObj changeTorch];
    
    btn.selected = !btn.selected;

    if (btn.selected)
    {
        [_btnFlash setImage:[UIImage imageNamed:@"scan_flash_select_1"] forState:UIControlStateNormal];
    }else {

        [_btnFlash setImage:[UIImage imageNamed:@"scan_flash_normal_1"] forState:UIControlStateNormal];
    }

}


#pragma mark - *** getter *** -

/**< 提示文字视图 */
- (UILabel *)topTitle{
    if (!_topTitle) {
        _topTitle = [[UILabel alloc]init];
        _topTitle.bounds = CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width - 20, 60);
        _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 50);
        
        //3.5inch iphone
        if ([UIScreen mainScreen].bounds.size.height <= 568 )
        {
            _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 38);
            _topTitle.font = [UIFont systemFontOfSize:14];
        }
        
        
        _topTitle.textAlignment = NSTextAlignmentCenter;
        _topTitle.numberOfLines = 0;
        _topTitle.text = @"将取景框对准码即可自动扫描";
        _topTitle.textColor = [UIColor whiteColor];
    }
    return _topTitle;
}
- (UIView *)numView
{
    if(!_numView){
        _numView = [[UIView alloc]init];
        _numView.frame = CGRectMake(0, ScreenHeight - 250*HEIGHTSCALE6, ScreenWidth, 90*HEIGHTSCALE6);
        
        _num = [[UILabel alloc]init];
        _num.font = FONT(25);
        _num.textColor = [UIColor whiteColor];
        _num.textAlignment = NSTextAlignmentCenter;
//        _num.text = [NSString stringWithFormat:@"已扫描 %d/%d",self.check,self.total];
        if (_scanType == ScanVINType) {
//            _num.attributedText = [YLAttributedStr changeSubStringWithTotalString:[NSString stringWithFormat:@"已出库 %d/%d",self.check,self.total] subStringColor:[UIColor redColor] subString:[NSString stringWithFormat:@"%d",self.check] andFont:FONT(25)];
        }else{
            _num.text = @"将取景框对准条码,即可自动扫描";
            _num.font = FONT(18);
        }
        _num.frame = CGRectMake(0, 0, _numView.width, _numView.height);
        [_numView addSubview:_num];
    }
    return _numView;
}
/**< 底部按钮视图 */
- (UIView *)bottomItemsView{
    if (!_bottomItemsView) {
        _bottomItemsView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-164,
                                                        CGRectGetWidth(self.view.frame), 100)];
        _bottomItemsView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        CGSize size = CGSizeMake(65, 87);//按钮图片大小
        
        //选择相册按钮
        self.btnPhoto = [[UIButton alloc]init];
        _btnPhoto.bounds = CGRectMake(0, 0, size.width, size.height);
        _btnPhoto.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame)/4, CGRectGetHeight(_bottomItemsView.frame)/2);
        [_btnPhoto setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_photo_nor"] forState:UIControlStateNormal];
        [_btnPhoto setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_photo_down"] forState:UIControlStateHighlighted];
        [_btnPhoto addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
        
        //闪光灯按钮
        
        self.btnFlash = [[UIButton alloc]init];
        _btnFlash.bounds = CGRectMake(0, 0, size.width, size.height);
        _btnFlash.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame) /2, CGRectGetHeight(_bottomItemsView.frame)/2);
//        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
        [_btnFlash setImage:[UIImage imageNamed:@"scan_flash_normal_1"] forState:UIControlStateNormal];
        [_btnFlash setImage:[UIImage imageNamed:@"scan_flash_select_1"] forState:UIControlStateSelected];
        [_btnFlash addTarget:self action:@selector(openOrCloseFlash:) forControlEvents:UIControlEventTouchUpInside];
        
        //我的QR按钮
        self.btnMyQR = [[UIButton alloc]init];
        _btnMyQR.bounds = _btnFlash.bounds;
        _btnMyQR.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame) * 3/4, CGRectGetHeight(_bottomItemsView.frame)/2);
        [_btnMyQR setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_myqrcode_nor"] forState:UIControlStateNormal];
        [_btnMyQR setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_myqrcode_down"] forState:UIControlStateHighlighted];
        [_btnMyQR addTarget:self action:@selector(myQRCode) forControlEvents:UIControlEventTouchUpInside];
        
        [_bottomItemsView addSubview:_btnFlash];
//        [_bottomItemsView addSubview:_btnPhoto];
        //    [_bottomItemsView addSubview:_btnMyQR];
        
        
    }
    return _bottomItemsView;
}
@end
