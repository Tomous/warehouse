//
//  DCJsApi.h
//  warehouse
//
//  Created by 大橙子 on 2019/4/3.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class DCJsApi;
@protocol jsApiDelegate <NSObject>
-(void)setNavTitle:(NSDictionary *)info;
@end
@interface DCJsApi : NSObject
@property (nonatomic,weak) id<jsApiDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
