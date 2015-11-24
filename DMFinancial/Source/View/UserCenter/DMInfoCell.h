//
//  DMInfoCell.h
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/28.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMTableViewCell.h"

@protocol DMInfoCellDelegate <NSObject>

-(void)textChangeActionWithcell:(DMTableViewCell *)cell string:(NSString *)string;
@end

@interface DMInfoCell : DMTableViewCell <UITextFieldDelegate>

@property (nonatomic, assign) BOOL showTextField;
@property (nonatomic, strong) NSString *detailText;
@property (nonatomic, assign) id<DMInfoCellDelegate> delegate;
@end
