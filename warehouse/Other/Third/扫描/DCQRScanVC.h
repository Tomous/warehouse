//
//  DCQRScanVC.h
//  TomousTool
//
//  Created by 大橙子 on 2018/6/26.
//  Copyright © 2018年 中都格罗唯视. All rights reserved.
//

#import "LBXScanViewController.h"

typedef enum : NSUInteger {
    ScanUITypeWX,//微信（1条线+内框）
    ScanUITypeQQ,//QQ （1条线+外框）
    ScanUITypeZhiFuBao,//支付宝（网格）
} ScanUIType;

@interface DCQRScanVC : LBXScanViewController

/**
 初始化方法
 
 @param type 扫码UI类型：WX/QQ/Alipay
 @param scanCodeType 默认二维码（自带只能识别一种码、不能同时识别）
 @param scanSuccessBlock 扫码返回的结果，包括选择图片
 */
+(instancetype)ScanWithUIType:(ScanUIType)type codeType:(ScanCodeType)scanCodeType scanType:(ScanType)scanType doneBlock:(void (^)(NSString *resultStr))scanSuccessBlock;

@property (nonatomic, copy)void(^resultBlock)(NSString *result);

@end
