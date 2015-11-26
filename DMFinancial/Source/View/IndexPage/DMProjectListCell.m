//
//  DMProjectListCell.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/26.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMProjectListCell.h"

@implementation DMProjectListCell {

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews {

}

-(void)setItem:(DMProjectListItem *)item {
    _item = item;
}

@end
