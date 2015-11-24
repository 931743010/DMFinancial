//
//  DMBirthdayPicker.h
//  DamaiPlayPhone
//
//  Created by Joseph Fu on 15/1/6.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMPicker.h"

@interface DMBirthdayPicker : DMPicker

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDate *currentDate;

@property (nonatomic, copy) void(^completionHandler)(NSDate *date);

@end
