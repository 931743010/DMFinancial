//
//  DMChatDateTransformer.m
//  DamaiPlayPhone
//
//  Created by 付书炯 on 15/5/23.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMChatDateTransformer.h"

NSString * const DMChatDateTransformerName = @"DMChatDateTransformer";

@implementation DMChatDateTransformer

+ (Class)transformedValueClass
{
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

- (id)transformedValue:(id)value
{
    if (![value isKindOfClass:[NSDate class]]) {
        return nil;
    }
    
    NSDate *date = (NSDate *)value;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSCalendarUnit flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitWeekday | NSCalendarUnitWeekOfYear;
    NSDateComponents *components = [calendar components:flags fromDate:date];
    NSDateComponents *currentComponents = [calendar components:flags fromDate:[NSDate date]];
    
    if (currentComponents.year == components.year &&
        currentComponents.month == components.month &&
        currentComponents.day == components.day) {
        // 同年同月同日
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        NSString *result = [dateFormatter stringFromDate:date];
        return result;
        
    }
    else if (currentComponents.year == components.year ) {
        if (currentComponents.day - components.day == 1) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm"];
            NSString *result = [dateFormatter stringFromDate:date];
            result = [NSString stringWithFormat:@"昨天 %@", result];
            return result;
        }
        // 同一周
        if (currentComponents.weekOfYear == components.weekOfYear) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm"];
            NSString *result = [dateFormatter stringFromDate:date];
            return [NSString stringWithFormat:@"%@ %@", [self descriptionForWeekday:components.weekday], result];
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        NSString *result = [dateFormatter stringFromDate:date];
        return result;
    }
    else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *result = [dateFormatter stringFromDate:date];
        return result;
    }
}

- (NSString *)descriptionForWeekday:(NSInteger)weekday
{
    NSArray *descriptions = @[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
    return descriptions[weekday];
}

@end
