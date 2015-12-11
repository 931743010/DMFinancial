//
//  DMPageState.h
//  DamaiPlayPhone
//
//  Created by Joseph Fu on 14/12/31.
//  Copyright (c) 2014年 陈彦岐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMPageDataInfo.h"

/**
 * 每页的状态
 */
@interface DMPageState : NSObject

+ (instancetype)stateWithName:(NSString *)name;

/// 页名
@property (nonatomic, copy, readonly) NSString *name;

/// 可滚动的页面的在y轴方向上的offset
@property (nonatomic) CGFloat offsetY;

@property (nonatomic, strong) DMPageDataInfo *pageInfo;

@property (nonatomic, assign) NSInteger indexOfSubCategory;

- (void)resetPageInfo;

@end


