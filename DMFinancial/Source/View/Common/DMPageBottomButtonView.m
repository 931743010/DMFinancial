//
//  DMPageBottomButtonView.m
//  DamaiIphone
//
//  Created by 陈彦岐 on 14-10-15.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "DMPageBottomButtonView.h"
#import "UIView+JFAddSeperator.h"
#import "UIView+JFLayout.h"
#import "AMBlurView.h"


@interface DMPageBottomButtonView()

/**
 *  回调的block
 */
@property (nonatomic, copy) ButtonSelectedAction buttonSelectedAction;


/**
 *  白色有透明度的背景
 */
@property (nonatomic, strong) UIView *bgView;

/**
 * 存放所有按钮
 */
@property (nonatomic, strong) NSMutableArray *buttonsPool;

/**
 *  按钮上的文字数组. 根据数组的数量创建按钮个数. 最多两个
 *  数组中元素类型 NSString
 */
@property (nonatomic, strong) NSArray *buttonTitles;

/**
 *  按钮的背景颜色.可不用
 *  数组中元素类型 UIColor
 */
@property (nonatomic, strong) NSArray *buttonBackgroundColors;

@end

@implementation DMPageBottomButtonView

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(kScreenWidth, DMPageBottomButtonViewHeight);
}

-(instancetype)initWithButtonTitles:(NSArray *)buttonTitles {
    _buttonTitles = buttonTitles;
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, DMPageBottomButtonViewHeight)];
    if (self) {
        _seperatorInsets = DMVerticalInsetsMake(0, 0);
        [self createSubViews];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (NSMutableArray *)buttonsPool
{
    if (!_buttonsPool) {
        _buttonsPool = [[NSMutableArray alloc] init];
    }
    return _buttonsPool;
}

-(void)createSubViews {
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _bgView.backgroundColor = [UIColor whiteColor];// colorWithAlphaComponent:0.9];
    _bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_bgView drawSolidLineWithFrame:CGRectMake(0, 0, self.width, 0.5)];
    [self addSubview:_bgView];
//    AMBlurView *amBlurView = [[AMBlurView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
////    amBlurView.blurTintColor = [UIColor whiteColor];
//    [self addSubview:amBlurView];
//    amBlurView.translatesAutoresizingMaskIntoConstraints = NO;

//    [self jf_addSeperatorToEdge:CGRectMinYEdge color:kSeperatorColor];
    [self createButtons];
}

- (void)createButtons {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    
    [self.buttonsPool removeAllObjects];
    
    if (_buttonTitles.count == 0) {
        return;
    }
    
    CGFloat buttonWidth = 0.0f;
    
    CGFloat buttonSpace = AUTOSIZE(8);
    CGFloat left = AUTOSIZE(16);
    
    buttonWidth = (kScreenWidth - (_buttonTitles.count - 1)*buttonSpace - left * 2)/_buttonTitles.count;
    
    for (int i = 0; i < _buttonTitles.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(left, buttonSpace, buttonWidth, self.height - buttonSpace*2)];
        [button addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:BOLDFONT(14)];
        button.layer.cornerRadius = 3;
        [self addSubview:button];
        left += buttonWidth + buttonSpace;
        [self.buttonsPool addObject:button];
        
//        [button jf_pinEdgeToSuperviewEdge:JFEdgeTop withInset:10];
//        [button jf_pinEdgeToSuperviewEdge:JFEdgeBottom withInset:10];
//        
//        if (i == 0) {
//            [button jf_pinEdge:JFEdgeLeft toEdge:edge ofView:lastView withOffset:left];
//            edge = JFEdgeRight;
//        } else {
//            if (self.showSeperator) {
//                UIView *seperator = [UIView new];
//                seperator.backgroundColor = kSeperatorColor;
//                [self addSubview:seperator];
//                
//                [seperator jf_pinEdgeToSuperviewEdge:JFEdgeTop withInset:self.seperatorInsets.top];
//                [seperator jf_pinEdgeToSuperviewEdge:JFEdgeBottom withInset:self.seperatorInsets.bottom];
//                [seperator jf_pinDimension:JFDimensionWidth withSize:0.5];
//                [seperator jf_pinEdge:JFEdgeRight toEdge:JFEdgeLeft ofView:button withOffset:-0.5];
//            }
//            [button jf_pinDimension:JFDimensionWidth toDimension:JFDimensionWidth ofView:lastView];
//            [button jf_pinEdge:JFEdgeLeft toEdge:edge ofView:lastView withOffset:buttonSpace];
//        }
//
//        lastView = button;
        
        button.tag = i;
        NSString *string = [_buttonTitles objectAt:i];
        [button setTitle:@"" forState:UIControlStateNormal];
        if (string && [string isKindOfClass:[NSString class]]) {
            [button setTitle:string forState:UIControlStateNormal];
        }
        
        if (self.configButtonBlock) {
            self.configButtonBlock(button, i);
        } else {
            //设置button背景颜色
            UIColor *color = [_buttonBackgroundColors objectAt:i];
            if (color && [color isKindOfClass:[UIColor class]]) {
            } else {
                color = [UIColor colorWithHexString:@"ff9422"];
            }
            
            button.layer.borderColor = color.CGColor;
            button.clipsToBounds = YES;
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:color forState:UIControlStateHighlighted];
            [button setTitleColor:[UIColor colorWithWhite:1 alpha:0.7] forState:UIControlStateDisabled];
            [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"747474"] size:CGSizeMake(button.width, button.height)] forState:UIControlStateDisabled];
            
            [button setBackgroundImage:[UIImage imageWithColor:color size:button.frame.size] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageWithBaseImage:[UIImage imageWithColor:color size:button.frame.size] superposedImage:[UIImage imageWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.1] size:button.frame.size]] forState:UIControlStateHighlighted];
        }
    }
    
//    [lastView jf_pinEdgeToSuperviewEdge:JFEdgeTop withInset:0];
//    [lastView jf_pinEdgeToSuperviewEdge:JFEdgeBottom withInset:0];
//    [lastView jf_pinEdgeToSuperviewEdge:JFEdgeRight withInset:left];
    
}

- (void)buttonTouched:(UIButton *)button
{
    if (self.buttonSelectedAction) {
        self.buttonSelectedAction(button);
    }
}

- (void)setButtonTitles:(NSArray *)buttonTitles {
    [self setButtonTitles:buttonTitles buttonBackgroundColors:nil];
}

-(void)setButtonTitles:(NSArray *)buttonTitles buttonBackgroundColors:(NSArray *)buttonBackgroundColors {
    _buttonTitles = buttonTitles;
    _buttonBackgroundColors = buttonBackgroundColors;
    [self createButtons];
}

- (void)buttonClickedcompletion:(ButtonSelectedAction)action {
    self.buttonSelectedAction = action;
}

-(void)buttonAction:(UIButton *)button {
    self.buttonSelectedAction(button);
}

- (void)enableAllButtons:(BOOL)enable
{
    for (int i=0; i<self.buttonsPool.count; i++) {
        [self enableButton:enable atIndex:i];
    }
}

- (void)enableButton:(BOOL)enable atIndex:(NSInteger)index
{
    if (index < 0 || index >= self.buttonsPool.count) {
        return;
    }
    UIButton *button = self.buttonsPool[index];
    button.enabled = enable;
    if (enable==NO) {
        button.layer.borderColor = kDMDefaultGrayStringColor.CGColor;
    }else{
        
    }
    
}

- (void)changeButtonTitle:(NSString *)title atIndex:(NSInteger)index {
    UIButton *button = [self buttonAtIndex:index];
    [button setTitle:title forState:button.state];
}

- (UIButton *)buttonAtIndex:(NSInteger)index {
    if (index < 0 || index >= self.buttonsPool.count) {
        return nil;
    }
    UIButton *button = self.buttonsPool[index];
    return button;
}
@end





