//
//  DMDiscoveryFilterTime.h
//  DMPlayCommonService
//
//  Created by Joseph Fu on 14/12/30.
//  Copyright (c) 2014年 陈彦岐. All rights reserved.
//

#import "DMObject.h"

@interface DMDiscoveryFilterTime : DMObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *startTime;
@property (strong, nonatomic) NSString *endTime;

+ (instancetype)defaultFilterTime;
- (BOOL)isDefaultFilterTime;

@end
