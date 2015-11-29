//
//  DMDiscoveryDateDetail.h
//  DMPlayCommonService
//
//  Created by Joseph Fu on 14/12/31.
//  Copyright (c) 2014年 陈彦岐. All rights reserved.
//

#import "DMObject.h"

@interface DMDiscoveryDateDetail : DMObject

@property (strong, nonatomic) NSString *dateString;
@property (nonatomic, getter=isFull) BOOL full;

/// 总量
@property (nonatomic) NSInteger totalCount;

/// 剩余量
@property (nonatomic) NSInteger remainderCount;

@property (nonatomic, strong) NSArray *items;

@end
