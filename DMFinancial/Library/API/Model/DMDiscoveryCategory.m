//
//  DMDiscoveryCategory.m
//  DMPlayCommonService
//
//  Created by Joseph Fu on 14/12/29.
//  Copyright (c) 2014年 陈彦岐. All rights reserved.
//

#import "DMDiscoveryCategory.h"

@implementation DMDiscoveryCategory

- (NSDictionary *)propertyNameMapping {
    return @{
             @"id":@"categoryId",
             @"name":@"categoryName",
             @"submodel": @"subArray"
             };
}

- (NSDictionary *)propertyTypeFormat {
    return @{@"subArray": @"DMDiscoveryCategory"};
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.categoryId = [aDecoder decodeObjectForKey:@"categoryId"];
        self.categoryName = [aDecoder decodeObjectForKey:@"categoryName"];
        self.subArray = [aDecoder decodeObjectForKey:@"subArray"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.categoryId forKey:@"categoryId"];
    [aCoder encodeObject:self.categoryName forKey:@"categoryName"];
    [aCoder encodeObject:self.subArray forKey:@"subArray"];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"id: %@, name: %@, subArray: %@", self.categoryId, self.categoryName, self.subArray];
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    DMDiscoveryCategory *category = [[DMDiscoveryCategory allocWithZone:zone] init];
    category.categoryId = [self.categoryId copy];
    category.categoryName = [self.categoryName copy];
    category.subArray = [self.subArray copy];
    return category;
}

@end
