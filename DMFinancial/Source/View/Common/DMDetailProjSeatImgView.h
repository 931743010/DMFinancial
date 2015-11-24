//
//  DMDetailProjSeatImgView.h
//  DamaiIphone
//
//  Created by 陈彦岐 on 14-2-19.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DMDetailProjSeatImgViewDelegate <NSObject>

- (void)closeView:(UIView *)view;

@end

@interface DMDetailProjSeatImgView : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, assign) id<DMDetailProjSeatImgViewDelegate> delegate;
@property (nonatomic, strong) NSString* seatImageUrl;

@end
