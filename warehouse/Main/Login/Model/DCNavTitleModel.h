//
//  DCNavTitleModel.h
//  warehouse
//
//  Created by 大橙子 on 2019/4/10.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCNavTitleModel : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *title_bar_color;
@property (nonatomic,assign)BOOL isShowBack;
@end

NS_ASSUME_NONNULL_END
