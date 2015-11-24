//
//  DMRoundLabel.h
//  DamaiIphone
//
//  Created by lixiang on 14-2-18.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMRoundLabel : UIView {

}

@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *contentColor;
@property (nonatomic, assign) CGFloat estimateWidth;
@property (nonatomic, strong) NSString *content;

@end
