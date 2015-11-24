//
//  DMUserModel.h
//  DamaiHD
//
//  Created by 陈作斌 on 13-10-29.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMObject.h"

@interface DMUserLoginInfo : DMObject<NSCoding>

//请求是否成功
@property(nonatomic,assign)BOOL  isSuccess;
//错误信息
@property(nonatomic,strong)NSString *error;
//登录后的key
@property(nonatomic,strong)NSString *loginKey;
//用户权限
@property(nonatomic,strong)NSString *root;

@property(nonatomic,strong)NSString *userid;

@property(nonatomic,strong)NSString *token;
/**
 *  登录成功时的时间戳,用来判断M值的过期时间
 */
@property(nonatomic,strong)NSDate *currentTime;

@end
