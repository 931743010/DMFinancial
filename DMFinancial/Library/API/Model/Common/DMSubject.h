//
//  DMSubject.h
//  DamaiHD
//
//  Created by lixiang on 13-10-14.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMObject.h"

@interface DMSubject : DMObject

/**
 *  项目名
 */
@property (nonatomic, strong) NSString *name;
/**
 *  项目id
 */
@property (nonatomic, strong) NSString *projectId;
/**
 *  图片地址
 */
@property (nonatomic, strong) NSString *picUrl;
/**
 *  项目类型，0普通项目，1随意跳，2WEB活动页，3专题
 */
@property (nonatomic, assign) DMSubjectType type;
/**
 *  链接
 */
@property (nonatomic, strong) NSString *url;
/**
 *  短评
 */
@property (nonatomic, strong) NSString *summary;

@end
