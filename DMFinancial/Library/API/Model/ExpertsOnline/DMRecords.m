//
//  DMRecords.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/23.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMRecords.h"

@implementation DMRecords

- (NSDictionary *)propertyNameMapping {
    return @{
             @"msgid":@"msgid",
             @"content":@"content",
             @"type":@"type"
             };
}

@end

@implementation DMRecordsListItem

- (NSDictionary *)propertyNameMapping {
    return @{
             @"id":@"recordsId",
             @"caseid":@"caseid",
             @"headimgid":@"headimgid",
             @"name":@"name",
             @"lastmsg":@"lastmsg",
             @"lastmsgtime":@"lastmsgtime",
             @"noread":@"noread"
             };
}

@end
