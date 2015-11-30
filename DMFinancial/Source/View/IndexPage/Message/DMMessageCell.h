//
//  DMMessageCell.h
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/30.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMTableViewCell.h"
#import "DMMessageItem.h"


@interface DMMessageCell : DMTableViewCell

@property (nonatomic, strong) DMMessageItem *item;
@end
