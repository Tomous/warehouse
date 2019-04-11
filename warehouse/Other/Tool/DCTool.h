//
//  DCTool.h
//  warehouse
//
//  Created by 大橙子 on 2019/4/10.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCTool : NSObject

#pragma mark 字典转化字符串
+(NSString *)dictionaryToJson:(NSDictionary *)dic;

#pragma mark 字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end

NS_ASSUME_NONNULL_END
