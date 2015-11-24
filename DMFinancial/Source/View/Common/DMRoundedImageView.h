//
//  DMRoundedImageView.h
//  DamaiIphone
//
//  Created by SongDong on 14-7-16.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageAdditions.h"

@interface DMRoundedImageView : UIImageView

@property(nonatomic, retain) UIImage *prototypeImage;
@property(nonatomic, assign) NSInteger borderSize;

@end
