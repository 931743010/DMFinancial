//
//  JFSwipeUnderneathIndicateView.h
//  DamaiPlayPhone
//
//  Created by Joseph Fu on 15/2/4.
//  Copyright (c) 2015年 Joseph Fu. All rights reserved.
//

#import "JFSwipeIndicateView.h"

@interface JFSwipeUnderneathIndicateView : JFSwipeIndicateView

@property (strong, nonatomic, readonly) UIImageView *imageView;
@property (assign, nonatomic) CGFloat paddingX;
@property (assign, nonatomic) CGFloat paddingY;
@property (assign, nonatomic) CGFloat cornerRadius;

@end
