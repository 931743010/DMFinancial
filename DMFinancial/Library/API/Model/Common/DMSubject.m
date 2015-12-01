//
//  DMSubject.m
//  DamaiHD
//
//  Created by lixiang on 13-10-14.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMSubject.h"

@implementation DMSubject

- (NSDictionary *)propertyNameMapping {
    return @{@"Name" : @"name",
             @"ProjectID" : @"projectId",
             @"Pic" : @"picUrl",
             @"ProjType" : @"type",
             @"Url" : @"url",
             @"Summary" : @"summary"};

}

- (NSDictionary *)propertyTypeFormat {
    return nil;
}

@end
