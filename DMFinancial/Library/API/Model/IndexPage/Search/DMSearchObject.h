//
//  DMSearchObject.h
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/11.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMObject.h"

@interface DMSearchObject : DMObject


@end

@interface DMSearchHotwordObject : DMObject

@property (nonatomic, strong) NSString *categoryName;//类型名
@property (nonatomic, strong) NSArray *hotwordList;//热门搜索列表

@end

