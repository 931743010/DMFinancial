//
//  JFDictionaryToStringTransformer.m
//  DMPlayCommonService
//
//  Created by Joseph Fu on 14/12/31.
//  Copyright (c) 2014年 陈彦岐. All rights reserved.
//

#import "JFDictionaryToStringTransformer.h"

NSString * const JFDictionaryToStringTransformName = @"DictionaryToString";

@implementation JFDictionaryToStringTransformer

+ (Class)transformedValueClass
{
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

- (id)transformedValue:(id)value
{
    if (nil == value) {
        return nil;
    }
    
    if (![value isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSDictionary *dictionary = (NSDictionary *)value;
    
    NSArray *keys = [dictionary allKeys];
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result;
    }];
    NSMutableString *str = [NSMutableString string];
    for (NSString *key in keys) {
        [str appendFormat:@"%@%@", key, [dictionary objectForKey:key]];
    }
    
    return [str lowercaseString];
}


@end
