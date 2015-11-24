//
//  DMRecordsParser.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/23.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMRecordsParser.h"
#import "DMRecords.h"

@implementation DMRecordsParser

- (id)parseData:(id)data {
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array configWithJsonData:result[@"data"][@"list"] forClass:[DMRecords class]];
    return array;
}

@end

@implementation DMRecordsListParser

- (id)parseData:(id)data {
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array configWithJsonData:result[@"data"][@"list"] forClass:[DMRecordsListItem class]];
    return array;
}

@end
