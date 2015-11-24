//
//  NSError+Additions.m
//  DamaiHD
//
//  Created by lixiang on 13-11-5.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "NSError+Additions.h"

@implementation NSError (Additions)

+ (NSError *)errorWithCode:(NSInteger)code message:(NSString *)message {
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message
                                                         forKey:NSLocalizedDescriptionKey];
    
    return [NSError errorWithDomain:@"cn.damai" code:code userInfo:userInfo];
}

@end
