//
//  DMUserParser.m
//  DamaiHD
//
//  Created by 陈作斌 on 13-10-29.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMUserLoginParser.h"
#import "DMUserLoginInfo.h"

@implementation DMUserLoginParser

- (id)parseData:(NSData *)data {
    
    NSDictionary *subjectsJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

    NSDictionary *tmpDic;

    if (subjectsJson != nil && ![subjectsJson isEqual:[NSNull null]]) {
        tmpDic = [subjectsJson objectForKey:@"data"];
    }

    DMUserLoginInfo *info = [[DMUserLoginInfo alloc]init];
    [info configWithDictionary:tmpDic];
    info.currentTime = [NSDate date];
    return info;
}

@end
