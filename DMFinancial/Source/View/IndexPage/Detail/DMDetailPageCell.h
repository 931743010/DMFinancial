//
//  DMDetailPageCell.h
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/9.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMTableViewCell.h"

@interface DMDetailPageCell : DMTableViewCell

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, assign) BOOL showAccessoryView;
@end
