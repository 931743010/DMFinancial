//
//  DMSearchObject.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/11.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMSearchObject.h"

@implementation DMSearchObject

@end

@implementation DMSearchHotwordObject

- (NSDictionary *)propertyNameMapping {
    return @{
             @"id":@"categoryName",
             @"name":@"hotwordList",
             };
}

- (NSDictionary *)propertyTypeFormat {
    return @{@"hotwordList": @"DMDiscoveryCategory"};
}

@end
