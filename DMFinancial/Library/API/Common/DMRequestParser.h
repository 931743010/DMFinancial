//
//  DMRequestParser.h
//  DamaiHD
//
//  Created by lixiang on 13-9-26.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMObject+JsonParser.h"
/**
 *  所有数据解析的父类
 */
@interface DMRequestParser : NSObject

/**
 *  解析请求后得到的数据json/xml
 *
 *  @param data 需要解析的数据
 *
 *  @return 解析后的model
 */
- (id)parseData:(id)data;

@end
