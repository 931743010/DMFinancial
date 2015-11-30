//
//  DMMessageParser.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/30.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMMessageParser.h"
#import "DMMessageItem.h"

@implementation DMMessageParser

- (id)parseData:(NSData *)data {
    
    NSDictionary *subjectsJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *array = [NSMutableArray new];
    if (subjectsJson != nil && ![subjectsJson isEqual:[NSNull null]]) {
        [array configWithJsonData:subjectsJson[@"data"][@"list"] forClass:[DMMessageItem class]];
    }
    return array;
}

@end
