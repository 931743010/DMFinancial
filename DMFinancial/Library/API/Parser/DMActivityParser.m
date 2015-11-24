//
//  DMActivityParser.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/24.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMActivityParser.h"
#import "DMActivity.h"
@implementation DMActivityParser

- (id)parseData:(NSData *)data {
    
    NSDictionary *subjectsJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *array = [NSMutableArray new];
    if (subjectsJson != nil && ![subjectsJson isEqual:[NSNull null]]) {
        [array configWithJsonData:subjectsJson[@"data"][@"list"] forClass:[DMActivity class]];
    }
    return array;
}

@end
