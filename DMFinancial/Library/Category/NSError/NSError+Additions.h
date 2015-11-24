//
//  NSError+Additions.h
//  DamaiHD
//
//  Created by lixiang on 13-11-5.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Additions)

+ (NSError *)errorWithCode:(NSInteger)code message:(NSString *)message;

@end
