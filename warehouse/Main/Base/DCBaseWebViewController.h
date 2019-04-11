//
//  DCBaseWebViewController.h
//  warehouse
//
//  Created by 大橙子 on 2019/4/9.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCNavTitleModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DCBaseWebViewController : UIViewController<jsApiDelegate>
@property (nonatomic,strong) DWKWebView *webView;
@property (nonatomic,strong) DCJsApi *jsApi;
@property (nonatomic,copy) NSString *requestURL;
@end

NS_ASSUME_NONNULL_END
