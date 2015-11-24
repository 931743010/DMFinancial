//
//  DMSearchBar.h
//  DamaiHD
//
//  Created by lixiang on 13-10-24.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DMSearchBar;
@protocol DMSearchBarDelegate <UITextFieldDelegate>;

@optional
- (BOOL)textFieldShouldBeginEditing:(DMSearchBar *)searchBar;
- (void)clearButtonAction:(DMSearchBar *)searchBar;

@end;

@interface DMSearchBar : UIView <UITextFieldDelegate>

@property (nonatomic, weak) id<DMSearchBarDelegate> delegate;
@property (nonatomic, strong, readonly) UITextField *textField;
@property (nonatomic, strong, readonly) UIButton *clearButton;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIImageView *searchImageView;

- (void)setRightTitle:(NSString *)title;

@end
