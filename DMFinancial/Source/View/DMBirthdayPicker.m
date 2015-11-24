//
//  DMBirthdayPicker.m
//  DamaiPlayPhone
//
//  Created by Joseph Fu on 15/1/6.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMBirthdayPicker.h"

@interface DMBirthdayPicker ()

@property (strong, nonatomic) NSDate *selectedDate;

@end

@implementation DMBirthdayPicker

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    _datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.maximumDate = [NSDate date];
    [_datePicker addTarget:self
                    action:@selector(datePicked:)
          forControlEvents:UIControlEventValueChanged];
    [self.containerView addSubview:_datePicker];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_datePicker]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.containerView, _datePicker)]];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_datePicker]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.containerView, _datePicker)]];
    if (self.currentDate) {
        self.datePicker.date = self.currentDate;
    }
}




- (void)confirm:(UIButton *)button
{
    if (self.completionHandler) {
        self.completionHandler(self.selectedDate);
    }
    [super confirm:button];
}

- (void)datePicked:(UIDatePicker *)datePicker
{
    self.selectedDate = datePicker.date;
}

@end
