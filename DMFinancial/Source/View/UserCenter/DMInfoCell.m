//
//  DMInfoCell.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/28.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMInfoCell.h"

@implementation DMInfoCell {
    UITextField *_textField;
    UILabel *_detailLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(170, 0, 230, self.height)];
    _textField.placeholder = @"待完善";
    [_textField setValue:kDMDefaultGrayStringColor forKeyPath:@"_placeholderLabel.textColor"];
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    _textField.font = FONT(12);
    _textField.textColor = kDMDefaultGrayStringColor;
    _textField.textAlignment = NSTextAlignmentRight;
    _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.contentView addSubview:_textField];
    
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _detailLabel.textColor = kDMDefaultGrayStringColor;
    _detailLabel.textAlignment = NSTextAlignmentRight;
    _detailLabel.font = FONT(12);
    _detailLabel.text = @"待完善";
    _detailLabel.hidden = YES;
    [self.contentView addSubview:_detailLabel];
}

-(void)setDetailText:(NSString *)detailText {
    _detailText = detailText;
    _textField.text = detailText;
    _detailLabel.text = detailText;
}

-(void)setShowTextField:(BOOL)showTextField {
    _showTextField = showTextField;
    _textField.hidden = !showTextField;
    _detailLabel.hidden = showTextField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [CommonHelper setValue:textField.text?textField.text:@"" forKey:self.textLabel.text];
    if (_delegate && [_delegate respondsToSelector:@selector(textChangeActionWithcell:string:)]) {
        [_delegate textChangeActionWithcell:self string:_textField.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

-(void)layoutSubviews {
    _textField.frame = CGRectMake(AUTOSIZE(100), 0, AUTOSIZE(230), self.height);
    _detailLabel.frame = CGRectMake(AUTOSIZE(100), 0, AUTOSIZE(230), self.height);

    [super layoutSubviews];
}
@end
