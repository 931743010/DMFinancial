//
//  DMDiscoveryFilterActivityOrder.h
//  DMPlayCommonService
//
//  Created by Joseph Fu on 14/12/30.
//  Copyright (c) 2014年 陈彦岐. All rights reserved.
//

#import "DMObject.h"

@interface DMDiscoveryFilterActivityOrder : DMObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *order;
@property (nonatomic, strong) NSString *visualName;

//- (NSString *)visualName;

+ (instancetype)defaultActivityOrder;

- (BOOL)isDefaultActivityOrder;

@end
