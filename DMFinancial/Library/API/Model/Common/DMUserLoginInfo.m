//
//  DMUserModel.m
//  DamaiHD
//
//  Created by 陈作斌 on 13-10-29.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMUserLoginInfo.h"

@implementation DMUserLoginInfo


- (NSDictionary *)propertyNameMapping {
    return @{
             @"os":@"isSuccess",
             @"error":@"error",
             @"loginkey":@"loginKey",
             @"token":@"token",
             @"userid":@"userid",
             @"root":@"root"
             };
}

- (NSDictionary *)propertyTypeFormat {
    return nil;
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self =[super init]){
        self.isSuccess =[[aDecoder decodeObjectForKey:@"os"] doubleValue];
        self.error=[aDecoder decodeObjectForKey:@"error"];
        self.loginKey=[aDecoder decodeObjectForKey:@"loginKey"];
        self.token=[aDecoder decodeObjectForKey:@"token"];
        self.userid=[aDecoder decodeObjectForKey:@"userid"];
        self.root = [aDecoder decodeObjectForKey:@"root"];
        self.currentTime = [aDecoder decodeObjectForKey:@"currentTime"];

    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSString stringWithFormat:@"%d", _isSuccess ] forKey:@"os"];
    [aCoder encodeObject:_error forKey:@"error"];
    [aCoder encodeObject:_loginKey forKey:@"loginKey"];
    [aCoder encodeObject:_token forKey:@"token"];
    [aCoder encodeObject:_userid forKey:@"userid"];
    [aCoder encodeObject:_root forKey:@"root"];
    [aCoder encodeObject:_currentTime forKey:@"currentTime"];

}
@end
