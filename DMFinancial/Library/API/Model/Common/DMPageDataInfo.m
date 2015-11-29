//
//  DMPageDataInfo.m
//  DamaiHD
//
//  Created by lixiang on 13-10-18.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMPageDataInfo.h"

@implementation DMPageDataInfo

+ (id)defaultPageDataInfo {
    DMPageDataInfo *pageDataInfo = [[DMPageDataInfo alloc] init];
    pageDataInfo.totalCount = 0;
    pageDataInfo.pageNo = 0;
    pageDataInfo.size = kPageSize;

    return pageDataInfo;
}

@end
