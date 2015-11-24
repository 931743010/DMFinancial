//
//  UILabel+Additions.h
//  DamaiHD
//
//  Created by lixiang on 13-11-5.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Additions)

- (void)adjustFontWithMaxSize:(CGSize)maxSize;
- (void)adjustFontAttributeWithMaxSize:(CGSize)maxSize;


- (void)withAttributesForString:(NSString *)string font:(UIFont *)font color:(UIColor *)color;

@end
