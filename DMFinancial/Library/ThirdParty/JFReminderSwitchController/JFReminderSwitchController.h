//
//  JFReminderSwitchController.h
//  OpenReminderController
//
//  Created by Joseph Fu on 15/1/5.
//  Copyright (c) 2015年 Joseph Fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFReminderSwitchView.h"

@interface JFReminderSwitchController : UIViewController
@property (nonatomic, getter=isOpenDismissWhenTouchBackground) BOOL openDismissWhenTouchBackground;

+ (instancetype)reminderSwitchControllerWithTitle:(NSString *)title message:(NSString *)message;

- (void)addRemindSwitchView:(JFReminderSwitchView *)reminderSwitchView;

- (void)showFromViewController:(UIViewController *)viewController;

@end
