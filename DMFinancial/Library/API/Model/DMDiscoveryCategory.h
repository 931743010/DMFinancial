//
//  DMDiscoveryCategory.h
//  DMPlayCommonService
//
//  Created by Joseph Fu on 14/12/29.
//  Copyright (c) 2014年 陈彦岐. All rights reserved.
//

#import "DMObject.h"

/**
 * 发现的分类
 */
@interface DMDiscoveryCategory : DMObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString  *categoryId;
@property (nonatomic, strong) NSString  *categoryName;
@property (nonatomic, strong) NSArray *subArray;

@property (nonatomic, assign) BOOL isLeaf;

@end
