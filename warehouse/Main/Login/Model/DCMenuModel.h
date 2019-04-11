//
//  DCMenuModel.h
//  warehouse
//
//  Created by 大橙子 on 2019/4/10.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCMenuModel : NSObject
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *menuType;//0,1原生逻辑
@property (nonatomic,copy) NSString *menuback;//原生跳转、方法逻辑
@property (nonatomic,copy) NSString *callType;//h5逻辑需要把此回传给h5
@property (nonatomic,copy) NSString *callback;//router/path h5l具体逻辑处理
@end

NS_ASSUME_NONNULL_END
