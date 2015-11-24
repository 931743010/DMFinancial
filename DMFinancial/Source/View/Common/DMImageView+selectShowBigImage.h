//
//  DMImageView+selectShowBigImage.h
//  CommonLibrary
//
//  Created by 陈彦岐 on 15/5/5.
//  Copyright (c) 2015年 damai. All rights reserved.
//

#import "DMImageView.h"

@interface DMImageView (selectShowBigImage)

/**
 *  点击图片显示大图
 *
 *  @param url   大图url
 *  @param image 占位图
 */
-(void)setBigImageUrl:(NSString *)url placeholderImage:(UIImage *)image;




@end
