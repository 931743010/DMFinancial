//
//  NSMutableArray+Mapping.m
//  DamaiHD
//
//  Created by lixiang on 13-10-15.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "NSMutableArray+Mapping.h"

@implementation NSMutableArray (Mapping)

- (void)configWithJsonData:(NSArray *)array forClass:(Class)klass {
    //先找到该属性的名字
    
    if ([array isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dic in array) {
            NSObject *subObject = [[klass alloc] init];
            [subObject configWithDictionary:dic];
            [self addObject:subObject];
        }
    }
}

@end
