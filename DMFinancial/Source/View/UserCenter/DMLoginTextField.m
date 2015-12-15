//
//  DMLoginTextField.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/15.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMLoginTextField.h"

@implementation DMLoginTextField {
    UILabel *_titleLabel;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.font = BOLDFONT(15);
    _titleLabel.textColor = kDMDefaultBlackStringColor;
    [self addSubview:_titleLabel];
    
    _textField = [[DMTextField alloc]initWithFrame:CGRectMake(40, 20, self.width - 62, AUTOSIZE(45))];
    _textField.font = FONT(14);
    _textField.textColor = kDMDefaultBlackStringColor;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.keyboardType = UIKeyboardTypeEmailAddress;
    [self addSubview:_textField];
    
    [self drawSolidLineWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
}

-(void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
    [_titleLabel sizeToFit];
    _titleLabel.height = self.height;
    
    _textField.frame = CGRectMake(_titleLabel.right, 0, self.width - _titleLabel.right, self.height);
    
}

@end
