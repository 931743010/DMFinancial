//
//  DMChatEnterView.h
//  DamaiPlayPhone
//
//  Created by 付书炯 on 15/5/20.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DMChatEnterView;
@protocol DMChatEnterViewDelegate <NSObject>

@optional
- (void)enterViewWillEnterText;
- (void)enterViewDidBeginEditing;
- (void)enterView:(DMChatEnterView *)enterView sendText:(NSString *)text;

@end

@interface DMChatEnterView : UIView

@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, assign) id <DMChatEnterViewDelegate> delegate;

- (void)clear;

@end
