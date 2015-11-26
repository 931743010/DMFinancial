//
//  DMManagementItemCell.h
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/25.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMManagementItem.h"

@interface DMManagementItemCell : UICollectionViewCell

@property (nonatomic, strong) DMManagementItem *item;
@property (nonatomic, assign) BOOL showDelButton;
@end
