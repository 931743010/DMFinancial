//
//  DMDatePicker.m
//  DamaiIphone
//
//  Created by lidehua on 14-7-2.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "DMDatePicker.h"

@implementation DMDatePicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.datePickerMode = UIDatePickerModeDate;
		self.locale = [NSLocale currentLocale];
    }
    return self;
}

-(void)setDateString:(NSString *)dateString
{
	NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
	[formatter setLocale:[NSLocale currentLocale]];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	NSDate * date = [formatter dateFromString:dateString];
	//self.date = date;
	if(date)
	{
		[self setDate:date animated:NO];
	}
}

-(NSString *)dateString
{
	NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
	[formatter setLocale:[NSLocale currentLocale]];
	[formatter setDateFormat:@"yyyy年MM月dd日"];
	return [formatter stringFromDate:self.date];
}
-(NSString *)stringToDateString:(NSString *)string
{
	NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
	[formatter setLocale:[NSLocale currentLocale]];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	NSDate * date = [formatter dateFromString:string];
	[formatter setDateFormat:@"yyyy年MM月dd日"];
	return [formatter stringFromDate:date];
}

-(NSString *)dateStringToString:(NSString *)string
{
	NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
	[formatter setLocale:[NSLocale currentLocale]];
	[formatter setDateFormat:@"yyyy年MM月dd日"];
	NSDate * date = [formatter dateFromString:string];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	return [formatter stringFromDate:date];
}
@end
