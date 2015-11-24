//
//  DMActivityCell.h
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/24.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMTableViewCell.h"
#import "DMActivity.h"

@protocol DMActivityCellDelegate <NSObject>

-(void)selecedCellWithItem:(DMActivity *)activity;

@end
@interface DMActivityCell : DMTableViewCell

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, assign) id<DMActivityCellDelegate> delegate;

@end
