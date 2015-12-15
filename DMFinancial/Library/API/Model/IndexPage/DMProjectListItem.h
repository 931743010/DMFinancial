//
//  DMProjectListItem.h
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/26.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMObject.h"

@interface DMProjectList : DMObject

@property (nonatomic, strong) NSArray *projectsData;
@property (nonatomic, assign) NSInteger totalCount;

@end

@interface DMProjectListItem : DMObject

@property (nonatomic, strong) NSString *itemId;
/*
    名称
 */
@property (nonatomic, strong) NSString *name;
/*
    限制
 */
@property (nonatomic, strong) NSString *dec;

/*
    类型
 */

@property (nonatomic, assign) DMAssetsType assetsType;
/*
    年化收益率
 */
@property (nonatomic, strong) NSString *yield;


@property (nonatomic, strong) NSString *url;

@end
