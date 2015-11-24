//
//  DMDatePicker.h
//  DamaiIphone
//
//  Created by lidehua on 14-7-2.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMDatePicker : UIDatePicker

-(void)setDateString:(NSString *)dateString;
-(NSString *)dateString;

-(NSString *)stringToDateString:(NSString *)string;

-(NSString *)dateStringToString:(NSString *)string;

@end
