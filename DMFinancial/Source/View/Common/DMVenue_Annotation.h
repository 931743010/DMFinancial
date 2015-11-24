//
//  DMVenue_Annotation.h
//  DamaiIphone
//
//  Created by lixiang on 14-1-15.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DMVenue_Annotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString * subtitle;
@property (nonatomic, assign) NSInteger venueId;
@property (nonatomic, assign) NSInteger catId;
@property (nonatomic, assign) NSInteger sum;


@end
