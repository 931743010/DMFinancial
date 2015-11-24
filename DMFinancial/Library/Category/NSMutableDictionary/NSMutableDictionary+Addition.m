//
//  NSMutableDictionary+Addition.m
//  CommonLibrary
//
//  Created by SongDong on 14-8-13.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "NSMutableDictionary+Addition.h"

@implementation NSMutableDictionary (Addition)

- (void)setSafetyObject:(id)anObject forKey:(NSString *)aKey
{
    if (!aKey || aKey.length <1 )
    {
        return;
    }
    if (anObject)
    {
        [self setObject:anObject forKey:aKey];
    }
    else
    {
        [self setObject:@"" forKey:aKey];
    }
}

@end
