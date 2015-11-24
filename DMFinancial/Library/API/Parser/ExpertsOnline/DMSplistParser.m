//
//  DMSplistParser.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/16.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMSplistParser.h"
#import "DMSplist.h"

@implementation DMSplistParser
- (id)parseData:(id)data {
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array configWithJsonData:result[@"data"][@"list"] forClass:[DMSplist class]];
    return array;
}

@end

@implementation DMGoodsListParser
- (id)parseData:(id)data {
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array configWithJsonData:result[@"data"][@"list"] forClass:[DMGoodsItem class]];
    return array;
}

@end

