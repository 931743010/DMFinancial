//
//  DMVenue_Annotation.m
//  DamaiIphone
//
//  Created by lixiang on 14-1-15.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "DMVenue_Annotation.h"

@implementation DMVenue_Annotation

@synthesize coordinate;
@synthesize title;
@synthesize venueId;
@synthesize catId;
@synthesize sum;
- (id)initWithLocation:(CLLocationCoordinate2D)coord
{
    self=[super init];
    if(self){
        coordinate =coord;
    }
    return self;
}


@end
