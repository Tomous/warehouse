//
//  DCNavigationViewController.m
//  warehouse
//
//  Created by 大橙子 on 2019/4/9.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCNavigationViewController.h"

@interface DCNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation DCNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加测滑手势。。只支持ios 7.0以上版本
    if (iOS7)
    {
        self.interactivePopGestureRecognizer.enabled = YES;      // 手势有效设置为YES  无效为NO
        self.interactivePopGestureRecognizer.delegate = self;    // 手势的代理设置为self
        
        /*
         iOS7以上系统，self.navigationController.navigationBar.translucent默认为YES，self.view.frame.origin.y从0开始（屏幕最上部）。
         */
        self.navigationBar.translucent = NO;
    }
    self.navigationBar.barTintColor = NavBgColor;
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:20]}];//修改导航栏的字体颜色和字体大小
    //    self.navigationBar.barStyle = UIBarStyleBlack;
    //    self.navigationBar.translucent = NO;
    
    //    [self.navigationBar setBackgroundImage:IMAGENAME(@"navigationbarBackgroundWhite") forBarMetrics:UIBarMetricsDefault];
    /**  去掉导航栏下面的黑线 */
    [self.navigationBar setShadowImage:[UIImage new]];
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 30, 44);
        UIImage * bImage = [[UIImage imageNamed: @"details-back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [backBtn setImage:bImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * lb = [[UIBarButtonItem alloc] initWithCustomView: backBtn];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        viewController.navigationItem.leftBarButtonItems = @[negativeSpacer,lb];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
-(void)back
{
    [self popViewControllerAnimated:YES];
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}

@end
