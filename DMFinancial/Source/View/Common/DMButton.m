//
//  DMButton.m
//  CommonLibrary
//
//  Created by 陈彦岐 on 14/11/3.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "DMButton.h"
#import "UIImageAdditions.h"

@interface DMButton () {

}
/**
 *  回调的block
 */
@property (nonatomic, strong) ButtonSelectedAction buttonSelectedAction;

@end

@implementation DMButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        __weak typeof(&*self) weakSelf = self;
        [self addTarget:weakSelf action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.clipsToBounds = YES;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        __weak typeof(&*self) weakSelf = self;
        [self addTarget:weakSelf action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
}

- (void)buttonClickedcompletion:(ButtonSelectedAction)action {
    self.buttonSelectedAction = action;
}

-(void)buttonAction:(UIButton *)button {
    if (self.buttonSelectedAction) {
        self.buttonSelectedAction(button);
    }
}


-(void)setButtonBackGroundColor:(UIColor *)color selectAlpha:(CGFloat)selectAlpha {
    UIImage *normalImage = [UIImage imageWithSize:CGSizeMake(1, 1) color:color];
    UIImage *selectImage = [UIImage imageWithBaseImage:normalImage superposedImage:[UIImage imageWithSize:CGSizeMake(1, 1) color:[[UIColor blackColor] colorWithAlphaComponent:selectAlpha]]];
    
    [self setBackgroundImage:normalImage forState:UIControlStateNormal];
    [self setBackgroundImage:selectImage forState:UIControlStateHighlighted];
}

@end
