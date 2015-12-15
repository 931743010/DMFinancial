//
//  DMPageDataInfo.h
//  DamaiHD
//
//  Created by lixiang on 13-10-18.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMObject.h"

@interface DMPageDataInfo : DMObject

/**
 *  查询结果总数量
 */
@property (nonatomic, assign) NSInteger totalCount;
/**
 *  下次查询的页数
 */
@property (nonatomic, assign) NSInteger pageNo;

/**
 *  每页查询的数目
 */
@property (nonatomic, assign) NSInteger size;

/**
 *  返回默认的分页实例
 *
 *  @return 返回默认的分页实例
 */
+ (id)defaultPageDataInfo;

@end
