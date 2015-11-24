//
//  DMTextCell.m
//  DamaiIphone
//
//  Created by lixiang on 14-2-13.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import "DMTextCell.h"

@implementation DMTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 22, 200, 15)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithHexString:@"7e7e7e"];
        label.font = FONT(14);
        label.shadowOffset = CGSizeMake(1, 1);
        label.shadowColor = [UIColor whiteColor];
        [self.contentView addSubview:label];
        self.stringLabel = label;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
