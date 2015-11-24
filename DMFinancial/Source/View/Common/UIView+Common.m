//
//  UIView+Common.m
//  DamaiHD
//
//  Created by lixiang on 13-11-25.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "UIView+Common.h"

@implementation UIView (Common)

- (void)showWaringViewWithText:(NSString *)text {
    UIView *warningView = [self viewWithTag:101];
    if (warningView == nil) {
        UIView *warningView = [[UIView alloc] initWithFrame:self.bounds];
        warningView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        warningView.tag =101;
        
        UIImage *sloganImage = [UIImage imageNamed:@"wode_morenzhuban"];
        CGSize size = sloganImage.size;
        UIImageView *sloganImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-size.width)/2, CGRectGetHeight(self.bounds)/2-size.height, size.width, size.height)];
        sloganImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        sloganImageView.image = sloganImage;
        [warningView addSubview:sloganImageView];
        
        UILabel *warnLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,  CGRectGetHeight(self.bounds)/2+5, self.frame.size.width, 12)];
        warnLabel.backgroundColor = [UIColor clearColor];
        warnLabel.text = text;
        warnLabel.textAlignment = NSTextAlignmentCenter;
        warnLabel.font = FONT(12);
        warnLabel.textColor = RGBA(110, 110, 110, 1);
        [warningView addSubview:warnLabel];
        
        [self addSubview:warningView];
    }
}

- (void)showWaringViewWithText:(NSString *)text detail:(NSString *)detail {
    UIView *warningView = [self viewWithTag:101];
    if (warningView == nil) {
        UIView *warningView = [[UIView alloc] initWithFrame:self.bounds];
        warningView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        warningView.tag =101;
        
        UIImage *sloganImage = [UIImage imageNamed:@"icon_holder_57x57"];
        CGSize size = sloganImage.size;
        UIImageView *sloganImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-size.width)/2, CGRectGetHeight(self.bounds)/2-size.height, size.width, size.height)];
        sloganImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        sloganImageView.image = sloganImage;
        [warningView addSubview:sloganImageView];
        
        UILabel *warnLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,  CGRectGetHeight(self.bounds)/2+5, self.frame.size.width, 12)];
        warnLabel.backgroundColor = [UIColor clearColor];
        warnLabel.text = text;
        warnLabel.textAlignment = NSTextAlignmentCenter;
        warnLabel.font = FONT(12);
        warnLabel.textColor = RGBA(110, 110, 110, 1);
        [warningView addSubview:warnLabel];
        
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,  CGRectGetHeight(self.bounds)/2+19, self.frame.size.width, 12)];
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.text = detail;
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.font = FONT(12);
        detailLabel.textColor = RGBA(110, 110, 110, 1);
        [warningView addSubview:detailLabel];
        
        [self addSubview:warningView];
    }
}

- (void)showWaringViewWithText:(NSString *)text iconImageNamed:(NSString *)iconImageName
{
    UIView *warningView = [self viewWithTag:101];
    if (warningView == nil) {
        UIView *warningView = [[UIView alloc] initWithFrame:self.bounds];
        warningView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        warningView.tag =101;
        
        UIImage *sloganImage = [UIImage imageNamed:iconImageName];
        CGSize size = sloganImage.size;
        UIImageView *sloganImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-size.width)/2, CGRectGetHeight(self.bounds)/2-size.height, size.width, size.height)];
        sloganImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        sloganImageView.image = sloganImage;
        [warningView addSubview:sloganImageView];
        
        UILabel *warnLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,  CGRectGetHeight(self.bounds)/2+18, self.frame.size.width, 16)];
        warnLabel.backgroundColor = [UIColor clearColor];
        warnLabel.text = text;
        warnLabel.textAlignment = NSTextAlignmentCenter;
        warnLabel.font = FONT(16);
        warnLabel.textColor = RGBA(110, 110, 110, 1);
        [warningView addSubview:warnLabel];
        
        [self addSubview:warningView];
    }
}

- (void)hideWaringView {
    UIView *waringView = [self viewWithTag:101];
    [waringView removeFromSuperview];
}

@end
