//
//  NSDate+convenience.h
//
//  Created by in 't Veen Tjeerd on 4/23/12.
//  Copyright (c) 2012 Vurig Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Convenience)

-(NSDate *)offsetMonth:(int)numMonths;
-(NSDate *)offsetDay:(int)numDays;
-(NSDate *)offsetHours:(int)hours;
-(int)numDaysInMonth;
-(int)firstWeekDayInMonth;
-(int)year;
-(int)month;
-(int)day;
-(int)weekday;
-(NSString *)weekdayString;

+(NSDate *)dateStartOfDay:(NSDate *)date;
+(NSDate *)dateStartOfWeek;
+(NSDate *)dateEndOfWeek;
+(NSDate*)convertServerDateTimeFormat_Seconds:(NSString *)ServerTimeString;
+ (BOOL)compare:(NSDate *)compareDate isEarlierByDay:(NSDate *)baseDate;

/**
 *  NSString转换成NSDate
 *
 *  @param dateString 时间的字符串
 *  @param format 时间格式 例如 : yyyy-MM-dd HH:mm:ss
 *
 *  @return NSDate
 */
+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format;

@end
