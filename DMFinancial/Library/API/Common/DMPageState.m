//
//  DMPageState.m
//  DamaiPlayPhone
//
//  Created by Joseph Fu on 14/12/31.
//  Copyright (c) 2014年 陈彦岐. All rights reserved.
//

#import "DMPageState.h"

@interface DMPageState ()
@property (nonatomic, copy, readwrite) NSString *name;
@end

@implementation DMPageState


+ (instancetype)stateWithName:(NSString *)name
{
    if (! [name length]) [NSException raise:NSInvalidArgumentException format:@"The `name` cannot be blank."];
    DMPageState *state = [self new];
    state.name = name;
    return state;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<name: %@>", self.name];
}

- (DMPageDataInfo *)pageInfo
{
    if (!_pageInfo) {
        _pageInfo = [DMPageDataInfo defaultPageDataInfo];
    }
    return _pageInfo;
}

- (void)resetPageInfo
{
    self.pageInfo = [DMPageDataInfo defaultPageDataInfo];
}

@end

