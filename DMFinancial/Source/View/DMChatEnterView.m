//
//  DMChatEnterView.m
//  DamaiPlayPhone
//
//  Created by 付书炯 on 15/5/20.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMChatEnterView.h"
#import "UIView+JFLayout.h"
#import "UIView+JFAddSeperator.h"

@interface DMChatEnterView () <UITextViewDelegate> {
    CGFloat _preHeight;
    CGFloat _minHeight;
    CGFloat _maxHeight;
    NSInteger _preWordCount;
}



@end

@implementation DMChatEnterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    

    _textView = [[UITextView alloc] init];
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.font = [UIFont systemFontOfSize:15];
//    _textView.textColor = [UIColor colorWithHexString:@"c7c7c7"];
    _textView.delegate = self;
    _textView.layer.cornerRadius = 5;
    _textView.layer.borderWidth = 0.5;
    _textView.layer.borderColor = [UIColor colorWithHexString:@"dadada"].CGColor;
    _textView.backgroundColor = [UIColor colorWithHexString:@"fafafa"];
    [self addSubview:_textView];
    
    _placeholderLabel = [UILabel new];
    _placeholderLabel.text = @"填写评论";
    _placeholderLabel.font = [UIFont systemFontOfSize:15];
    _placeholderLabel.textColor = [UIColor colorWithHexString:@"c7c7c7"];
    [self addSubview:_placeholderLabel];
    
    _sendButton = UIButton.new;
    [_sendButton setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    _sendButton.titleLabel.font = BOLDFONT(17);
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sendButton];
    
    [_sendButton jf_pinEdgeToSuperviewEdge:JFEdgeBottom withInset:12];
    [_sendButton jf_pinEdgeToSuperviewEdge:JFEdgeRight withInset:8];
    [_sendButton jf_pinDimensionsWithSize:CGSizeMake(45, 34)];

    [_textView jf_pinEdgesToSuperviewWithInsets:UIEdgeInsetsMake(8.5, 10, 8, 8) exclude:JFEdgeRight];
    [_textView jf_pinEdge:JFEdgeRight toEdge:JFEdgeLeft ofView:_sendButton withOffset:-8];
    
    [self jf_addSeperatorToEdge:CGRectMinYEdge color:[UIColor colorWithHexString:@"dddddd"]];
    
    UIEdgeInsets insets = _textView.textContainerInset;
    insets.left = 7;
    insets.right = 7;
    insets.top = 12;
    insets.bottom = 12;
    _textView.textContainerInset = insets;
    
    _minHeight = insets.top + insets.bottom + self.textView.font.lineHeight;
    _maxHeight = insets.top + insets.bottom + self.textView.font.lineHeight * 3;
    _minHeight = ceil(_minHeight);
    _maxHeight = ceil(_maxHeight);
    
    [_placeholderLabel jf_alignAxis:JFAxisVertical toSameAxisOfView:_textView];
    [_placeholderLabel jf_pinEdge:JFEdgeLeft toEdge:JFEdgeLeft ofView:_textView withOffset:insets.left];

}

- (CGSize)intrinsicContentSize
{
    CGSize size = self.textView.contentSize;
    CGFloat height = size.height;

    
    if (height <= _minHeight) {
        height = _minHeight;
    }
    else if (height >= _maxHeight) {
        height = _maxHeight;
    }
    
    return CGSizeMake(UIViewNoIntrinsicMetric, height + 16);
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
//    if ([self.delegate respondsToSelector:@selector(enterViewCouldEnterText)]) {
//        return [self.delegate enterViewCouldEnterText];
//    }
    
    if ([self.delegate respondsToSelector:@selector(enterViewWillEnterText)]) {
        [self.delegate enterViewWillEnterText];
    }
    self.placeholderLabel.hidden = YES;
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(enterViewDidBeginEditing)]) {
        [self.delegate enterViewDidBeginEditing];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGSize size = textView.contentSize;
    CGFloat height = size.height;

    // 字符数量
    NSInteger wordCount = textView.text.length;

    // 是否是输入文字
    if (wordCount > _preWordCount) {
        
        _preWordCount = wordCount;
        
        // 已经换行
        if (height > _preHeight) {
            
            [self invalidateIntrinsicContentSize];
            _preHeight = height;
        }
        else {
            
        }
    } else {
        // 删除文字
        // 已经换行
        if (height < _preHeight) {
            if (height <= _maxHeight) {
                [self invalidateIntrinsicContentSize];
            }
        }
        
        _preHeight = height;
        _preWordCount = wordCount;
    }

    CGPoint offset = CGPointMake(0, MAX(height, _preHeight) - CGRectGetHeight(textView.frame));
    [textView setContentOffset:offset animated:NO];
}

- (void)buttonTouched:(id)sender
{
    NSString *text = self.textView.text;
    
    // 全为空格
    if ([[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"不能发送空白消息" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    
    // 发送text
    if ([self.delegate respondsToSelector:@selector(enterView:sendText:)]) {
        [self.delegate enterView:self sendText:text];
    }
    
    self.textView.text = @"";
    self.textView.contentSize = CGSizeZero;
    [self invalidateIntrinsicContentSize];
}

- (void)clear
{
    self.textView.text = @"";
    self.textView.contentSize = CGSizeZero;
    [self invalidateIntrinsicContentSize];
}

@end
