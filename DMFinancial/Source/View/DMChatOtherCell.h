//
//  DMChatOtherCell.h
//  DamaiPlayPhone
//
//  Created by 付书炯 on 15/5/21.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMRecords.h"


/**
 * 显示为其他人发布的信息
 */
@interface DMChatOtherCell : UITableViewCell

- (CGFloat)height;

- (void)blindModel:(DMRecords *)item loadImage:(BOOL)load previousDate:(NSDate *)previousDate;

@end
