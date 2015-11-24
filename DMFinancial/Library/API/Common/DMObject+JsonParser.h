//
//  DMObject+JsonParser.h
//  DamaiHD
//
//  Created by lixiang on 13-9-26.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMObject.h"

@interface DMObject (JsonParser)

/**
 *  通过解析json数据返回对应的数据对象
 *
 *  @param configs 类的属性和json键值的对应关系
 *  @param data    从服务器请求得到的json数据
 *
 *  @return 解析后的数据对象
 */
+ (id)objectWithConfigs:(NSDictionary *)configs jsonData:(NSDictionary *)data;

@end
