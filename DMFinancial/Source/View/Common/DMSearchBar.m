//
//  DMSearchBar.m
//  DamaiHD
//
//  Created by lixiang on 13-10-24.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMSearchBar.h"

@interface DMSearchBar ()

@property (nonatomic, strong, readwrite) UITextField *textField;
@property (nonatomic, strong, readwrite) UIButton    *clearButton;
@property (nonatomic, strong) UILabel    *rightLabel;

@end

@implementation DMSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.textField = [[UITextField alloc] init];
        _textField.frame = CGRectMake(0, 0, self.width, frame.size.height);
        _textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.backgroundColor = [UIColor clearColor];
        _textField.textColor = [UIColor blackColor];
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.returnKeyType = UIReturnKeySearch;
        [self addSubview:_textField];
        
        UIImage *searchImage = [UIImage imageWithResourcesPathCompontent:@"icon_search.png"];
        self.searchImageView =[[UIImageView alloc] initWithFrame:CGRectMake(9, 2, searchImage.size.width/2, searchImage.size.height/2)];
        self.searchImageView.image = searchImage;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectZero];
        leftView.left = 0;
        leftView.top = 0;
        leftView.width = 25;
        leftView.height = 16;
        [leftView addSubview:self.searchImageView];
        
        self.rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightLabel.left = 0;
        _rightLabel.top = 5;
        _rightLabel.height = 20;
        _rightLabel.font = FONT(16);
        _rightLabel.textColor = RGBA(192, 188, 188, 1);
        _rightLabel.backgroundColor = [UIColor clearColor];
        
        _textField.leftView = leftView;
        _textField.rightView = _rightLabel;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.rightViewMode = UITextFieldViewModeAlways;
        
        self.clearButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 25, (self.height - 25)/2, 25, 25)];
        _clearButton.backgroundColor = [UIColor clearColor];
        _clearButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [_clearButton setImage:[UIImage imageNamed:@"btn_delete.png"] forState:UIControlStateNormal];
        [_clearButton addTarget:self
                        action:@selector(closeButtonAction:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_clearButton];
        self.layer.cornerRadius = 5.0f;
        self.clipsToBounds = YES;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect{
    
}

- (void)setRightTitle:(NSString *)title {
    if (title != nil) {
        _rightLabel.width = 50;
        _rightLabel.text = title;
        _rightLabel.width = [title sizeWithFont:FONT(16) constrainedToSize:CGSizeMake(MAXFLOAT, 20)].width;
    }
}

- (void)setDelegate:(id<DMSearchBarDelegate>)delegate {
    if (_delegate != delegate) {
        _delegate = delegate;
        _textField.delegate = delegate;
    }
}

#pragma mark - Button Action
- (void)closeButtonAction:(id)sender {
    _textField.text = @"";
    [_textField resignFirstResponder];
    [self setRightTitle:@""];
    if (_delegate &&
        [(NSObject *)_delegate respondsToSelector:@selector(clearButtonAction:)]) {
        [_delegate clearButtonAction:self];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (_delegate &&
        [(NSObject *)_delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [_delegate textFieldShouldBeginEditing:self];
    }
    return YES;
}

- (void)setText:(NSString *)text {
    _textField.text = text;
}

- (NSString *)text {
    return _textField.text;
}

@end
