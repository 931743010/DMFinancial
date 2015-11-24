//
//  CLProgressHUD.h
//  CLProgressHUDDemo
//
//  Created by lixiang on 13-12-30.
//  Copyright (c) 2013年 cleexiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CLProgressHUDType) {
    CLProgressHUDTypeDarkForground,
    CLProgressHUDTypeDarkBackground
};

typedef NS_ENUM(NSUInteger, CLProgressHUDShape) {
    CLProgressHUDShapeLinear,
    CLProgressHUDShapeCircle
};

@interface CLProgressHUD : UIView {
   
}

@property (nonatomic, assign) CLProgressHUDType type;
@property (nonatomic, assign) CLProgressHUDShape shape;
@property (nonatomic, assign) CGFloat diameter;
@property (nonatomic, strong) NSString *text;

//+ (instancetype)shareInstance;
//+ (instancetype)showInView:(UIView *)view animated:(BOOL)animated;
- (id)initWithView:(UIView *)view;
- (void)showInView:(UIView *)view;
//- (void)showInView:(UIView *)view withText:(NSString *)text;
//- (void)showInView:(UIView *)view withText:(NSString *)text duration:(NSTimeInterval)duration;
- (void)showWithAnimation:(BOOL)animated;

//+ (void)dismiss;
- (void)dismiss;
//+ (NSUInteger)hideAllHUDsForView:(UIView *)view animated:(BOOL)animate;
//- (void)setLabelText:(NSString *)labelText;

@end
