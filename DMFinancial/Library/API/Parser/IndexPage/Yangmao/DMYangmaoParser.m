//
//  DMYangmaoParser.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/30.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMYangmaoParser.h"
#import "DMYangmaoItem.h"

@implementation DMYangmaoParser

- (id)parseData:(NSData *)data {
    
    NSDictionary *subjectsJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *array = [NSMutableArray new];
    if (subjectsJson != nil && ![subjectsJson isEqual:[NSNull null]]) {
        [array configWithJsonData:subjectsJson[@"data"][@"list"] forClass:[DMYangmaoItem class]];
    }
    return array;
}

@end
