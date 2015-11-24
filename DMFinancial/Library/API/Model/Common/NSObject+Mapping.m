//
//  NSObject+Mapping.m
//  DamaiHD
//
//  Created by lixiang on 13-10-14.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "NSObject+Mapping.h"
#import "MappingRuntimeHelper.h"

@implementation NSObject (Mapping)

- (void)configWithDictionary:(NSDictionary *)dic {
    if (dic == nil || [dic isEqual:[NSNull null]] || ![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSDictionary *nameMappingDic = nil;
    NSDictionary *typeMappingDic = nil;
    if ([self respondsToSelector:@selector(propertyNameMapping)]) {
        nameMappingDic = [self propertyNameMapping];
    }
    if ([self respondsToSelector:@selector(propertyTypeFormat)]) {
        typeMappingDic = [self propertyTypeFormat];
    }
    
    for (NSString *key in dic.allKeys) {
        if ([nameMappingDic objectForKey:key]) {
            id value = [dic objectForKey:key];
            if (value == nil || value == [NSNull null]) {
                continue;
            }
            
            if ([value isKindOfClass:[NSDictionary class]]) {
                NSDictionary *tempDic = value;
                //先找到该属性的名字
                NSString *propertyName = [nameMappingDic objectForKey:key];
                if ([typeMappingDic objectForKey:propertyName]) {
                    //再根据类型配置字典找到该属性对应的类型
                    Class class = NSClassFromString([typeMappingDic objectForKey:propertyName]);
                    value = [[class alloc] init];
                    [value configWithDictionary:tempDic];
                }
            } else if ([value isKindOfClass:[NSArray class]]) {
                //先找到该属性的名字
                NSString *propertyName = [nameMappingDic objectForKey:key];
                NSMutableArray *objects = [[NSMutableArray alloc] initWithCapacity:[value count]];
                
                for (NSDictionary *dic in value) {
                    Class class = NSClassFromString([typeMappingDic objectForKey:propertyName]);
                    NSObject *subObject = [[class alloc] init];
                    
                    if (!subObject)
                    {
                        //当数组中不是类对象，是基本数据，例如数字时， 优惠劵返回支持的支付方式类型数组payTypeIds中就是
                        [objects addObjectsFromArray:value];
                        break;
                    }
                    
                    [subObject configWithDictionary:dic];
                    [objects addObject:subObject];
                }
                
                value = objects;
            } else {
                value = [self dealWithObjectWithKey:key
                                              value:value
                                     nameMappingDic:nameMappingDic
                                     typeMappingDic:typeMappingDic];
            }
            
            [self setValue:value forKey:[nameMappingDic objectForKey:key]];
        }
    }
}


- (id)dealWithObjectWithKey:(id)key value:(id)value nameMappingDic:(NSDictionary*)nameMappingDic typeMappingDic:(NSDictionary *)typeMappingDic {
    id retunValue=nil;
    
    Class  propertyClass =[MappingRuntimeHelper propertyClassForPropertyName:[nameMappingDic valueForKey:key] ofClass:[self class]];
    if (propertyClass==[NSDate class])
    {   NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
        
        [formatter setDateFormat:[typeMappingDic valueForKey:[nameMappingDic valueForKey:key]]];
        retunValue =[formatter dateFromString:value];
    }
    else
        retunValue = value;
    return retunValue;
}

-(NSDictionary *)propertyNameMapping {
    return nil;
}
-(NSDictionary *)propertyTypeFormat {
    return nil;
}

@end
