//
//  DMObject+JsonParser.m
//  DamaiHD
//
//  Created by lixiang on 13-9-26.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMObject+JsonParser.h"

@implementation DMObject (JsonParser)

+ (id)objectWithConfigs:(NSDictionary *)configs jsonData:(NSDictionary *)data {
    id object = [[[self class] alloc] init];
    for (NSString *properyName in configs.keyEnumerator) {
        NSString *jsonKey = [configs objectForKey:properyName];
        id jsonValue = [data objectForKey:jsonKey];

        //通过属性名找到该类对应的属性
        NSString *setterName=[NSString stringWithFormat:@"set%@%@:",
                             [[properyName substringToIndex:1] uppercaseString],[properyName substringFromIndex:1]];
        //获取该属性的setter方法
        SEL setter = NSSelectorFromString(setterName);
        //objc_msgSend(self, setter, NULL);
        if ([object respondsToSelector:setter]) {
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [object performSelector:setter withObject:jsonValue];
        }
    }
    
    return object;
}

@end
