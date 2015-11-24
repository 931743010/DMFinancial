//
//  DMSplist.h
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/16.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMObject.h"

@interface DMSplist : DMObject
/**
 *  专家id
 */
@property (nonatomic, strong) NSString *spid;
/**
 *  专家名字
 */
@property (nonatomic, strong) NSString *name;
/**
 *  专家等级
 */
@property (nonatomic, strong) NSString *level;
/**
 *  等级名称
 */
@property (nonatomic, strong) NSString *leveltitle;
/**
 *  城市
 */
@property (nonatomic, strong) NSString *city;
/**
 *  身份认证
 */
@property (nonatomic, strong) NSString *cert;
/**
 *  2014年度优秀HR
 */
@property (nonatomic, strong) NSString *title;
/**
 *  国企 央企 民营
 */
@property (nonatomic, strong) NSString *goods;
/**
 *  个性签名
 */
@property (nonatomic, strong) NSString *signa;
/**
 *  专家描述
 */

@property (nonatomic, strong) NSString *desc;
/**
 *  状态 是否空闲
 */
@property (nonatomic, strong) NSString *State;

@end

@interface DMGoodsItem : DMObject

/**
 *  状态 是否空闲
 */
@property (nonatomic, strong) NSString *goods;
/**
 *  状态 是否空闲
 */
@property (nonatomic, strong) NSString *goodsId;

@end
