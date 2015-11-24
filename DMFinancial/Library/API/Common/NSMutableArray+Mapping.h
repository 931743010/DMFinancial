//
//  NSMutableArray+Mapping.h
//  DamaiHD
//
//  Created by lixiang on 13-10-15.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Mapping)

/**
 *  将json数组映射到对应的实体对象的数组
 *
 *  @param array json数组
 *  @param klass 对象的类型
 */
- (void)configWithJsonData:(NSArray *)array forClass:(Class)klass;

@end
