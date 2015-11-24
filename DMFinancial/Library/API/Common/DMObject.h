//
//  DMObject.h
//  DamaiHD
//
//  Created by lixiang on 13-9-26.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DMObjectMapping <NSObject>

@required
- (NSDictionary *)propertyNameMapping;
- (NSDictionary *)propertyTypeFormat;

@end

/**
 *  所有实体类的父类
 */
@interface DMObject : NSObject <DMObjectMapping>

@end
