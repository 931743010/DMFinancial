//
//  JFReminderSwitchView.m
//  OpenReminderController
//
//  Created by Joseph Fu on 15/1/5.
//  Copyright (c) 2015年 Joseph Fu. All rights reserved.
//

#import "JFReminderSwitchView.h"
#import "UIView+JFAddSeperator.h"

@interface JFReminderSwitchView ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UISwitch *switchControl;
@property (copy, nonatomic) void(^toggleSwitchBlock)(BOOL switchOn);

@end

@implementation JFReminderSwitchView

+ (instancetype)reminderSwitchViewWithTitle:(NSString *)title switchOn:(BOOL)on handler:(void(^)(BOOL switchOn))toggleSwitchBlock
{
    JFReminderSwitchView *view = [[JFReminderSwitchView alloc] initWithFrame:CGRectZero];
    view.switchControl.on = on;
    view.titleLabel.text = title;
    view.toggleSwitchBlock = toggleSwitchBlock;
    return view;
}

- (void)awakeFromNib
{
    [self loadSubviews];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubviews];
    }
    return self;
}

- (void)loadSubviews
{
    NSMutableArray *constraints = [NSMutableArray array];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self addSubview:_titleLabel];
    
    _switchControl = [[UISwitch alloc] initWithFrame:CGRectZero];
    _switchControl.translatesAutoresizingMaskIntoConstraints = NO;
    [_switchControl addTarget:self
                       action:@selector(toggleSwitch:)
             forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:_switchControl];
    
    [constraints addObjectsFromArray:@[[NSLayoutConstraint constraintWithItem:_switchControl
                                                                    attribute:NSLayoutAttributeWidth
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:0
                                                                   multiplier:1.0
                                                                     constant:51],
                                       [NSLayoutConstraint constraintWithItem:_switchControl
                                                                    attribute:NSLayoutAttributeHeight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:0
                                                                   multiplier:1.0
                                                                     constant:31],
                                       [NSLayoutConstraint constraintWithItem:_switchControl
                                                                    attribute:NSLayoutAttributeRight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self
                                                                    attribute:NSLayoutAttributeRight
                                                                   multiplier:1.0
                                                                     constant:-20.0],
                                       [NSLayoutConstraint constraintWithItem:_switchControl
                                                                    attribute:NSLayoutAttributeCenterY
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self
                                                                    attribute:NSLayoutAttributeCenterY
                                                                   multiplier:1.0
                                                                     constant:0]]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_titleLabel]-8-[_switchControl]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self, _titleLabel, _switchControl)]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_titleLabel]-8-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self, _titleLabel)]];
    
    [self addConstraints:constraints];
}

- (void)toggleSwitch:(UISwitch *)switchControl
{
    if (self.toggleSwitchBlock) {
        self.toggleSwitchBlock(switchControl.isOn);
    }
}

@end
