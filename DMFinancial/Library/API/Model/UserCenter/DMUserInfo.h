//
//  DMUserInfo.h
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/16.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMObject.h"

@interface DMUserInfo : DMObject
/**
 *  名字
 */
@property (nonatomic, strong) NSString *name;
/**
 *  等级
 */
@property (nonatomic, strong) NSString *level;
/**
 *  等级名称
 */
@property (nonatomic, strong) NSString *leveltitle;
/**
 *  咨询数量
 */
@property (nonatomic, strong) NSString *consults;
/**
 *  主题数
 */
@property (nonatomic, strong) NSNumber *subject;
/**
 *  回答数
 */
@property (nonatomic, strong) NSNumber *answer;
/**
 *  资料完善程度
 */
@property (nonatomic, strong) NSString *progress;

@end

@interface DMUserInfoDetail : DMObject

/**
 *  资料完善程度
 */
@property (nonatomic, strong) NSString *headimgid;//	头像ID
@property (nonatomic, strong) NSString *name;//	用户姓名
@property (nonatomic, strong) NSString *sex;//	性别
@property (nonatomic, strong) NSString *school;//	毕业学校
@property (nonatomic, strong) NSString *Professional;//	专业
@property (nonatomic, strong) NSString *gradtime;//	毕业时间
@property (nonatomic, strong) NSString *career_direction;//	职业方向
@property (nonatomic, strong) NSString *Company;//	公司
@property (nonatomic, strong) NSString *Position;//	职位
@property (nonatomic, strong) NSString *Tags;//	个人标签
@property (nonatomic, strong) NSString *Work_experience;//	工作经历
@property (nonatomic, strong) NSString *Education_experience;//	教育经历
@property (nonatomic, strong) NSString *Job_attitude;//	求职心态
@property (nonatomic, strong) NSString *Work_age;//	工作年限
@property (nonatomic, strong) NSString *Expected_salary;//	期望薪资
@property (nonatomic, strong) NSString *Job_declaration;//	求职宣言
@property (nonatomic, strong) NSString *Place;//	工作地点
@property (nonatomic, strong) NSString *mail;//	邮箱
@property (nonatomic, strong) NSString *wechat;//	微信
@property (nonatomic, strong) NSString *qq;//	qq

@end