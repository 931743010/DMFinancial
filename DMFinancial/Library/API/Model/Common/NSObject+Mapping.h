//
//  NSObject+Mapping.h
//  DamaiHD
//
//  Created by lixiang on 13-10-14.
//  Copyright (c) 2013年 damai. All rights reserved.
//


@interface NSObject (Mapping)

/**
 *  通过json数据字典映射到实体类
 *
 *  @param dic 解析json成的字典
 */
- (void)configWithDictionary:(NSDictionary *)dic;

@end
