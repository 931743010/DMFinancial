//
//  JFReminderSwitchView.h
//  OpenReminderController
//
//  Created by Joseph Fu on 15/1/5.
//  Copyright (c) 2015年 Joseph Fu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JFReminderSwitchView : UIView

+ (instancetype)reminderSwitchViewWithTitle:(NSString *)title switchOn:(BOOL)on handler:(void(^)(BOOL switchOn))toggleSwitchBlock;

@end
