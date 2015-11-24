//
//  DMExpertsOnlineCell.h
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/16.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMTableViewCell.h"
#import "DMSplist.h"

@protocol DMExpertsOnlineCellDelegate <NSObject>

-(void)recordsWithSpid:(NSString *)spid;

@end
@interface DMExpertsOnlineCell : DMTableViewCell

@property (nonatomic, strong) DMSplist *myAttentionItem;
@property (nonatomic, assign) id<DMExpertsOnlineCellDelegate> delegate;

@end
