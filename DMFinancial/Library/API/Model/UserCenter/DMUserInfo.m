//
//  DMUserInfo.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/16.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMUserInfo.h"

@implementation DMUserInfo

- (NSDictionary *)propertyNameMapping {
    return @{
             @"name":@"name",
             @"level":@"level",
             @"leveltitle":@"leveltitle",
             @"consults":@"consults",
             @"subject":@"subject",
             @"answer":@"answer",
             @"progress":@"progress"
             };
}

- (NSDictionary *)propertyTypeFormat
{
    return nil;
}

@end

@implementation DMUserInfoDetail

- (NSDictionary *)propertyNameMapping {
    return @{
             @"headimgid":@"headimgid",
             @"name":@"name",
             @"sex":@"sex",
             @"school":@"school",
             @"Professional":@"Professional",
             @"gradtime":@"gradtime",
             @"career_direction":@"career_direction",
             @"Company":@"Company",
             @"Position":@"Position",
             @"Tags":@"Tags",
             @"Work_experience":@"Work_experience",
             @"Education_experience":@"Education_experience",
             @"Job_attitude":@"Job_attitude",
             @"Work_age":@"Work_age",
             @"Expected_salary":@"Expected_salary",
             @"Job_declaration":@"Job_declaration",
             @"Place":@"Place",
             @"mail":@"mail",
             @"wechat":@"wechat",
             @"qq":@"qq"
             };
}

- (NSDictionary *)propertyTypeFormat
{
    return nil;
}

@end

