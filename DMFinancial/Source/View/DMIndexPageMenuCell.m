//
//  DMIndexPageMenuCell.m
//  DamaiPlayPhone
//
//  Created by 陈彦岐 on 15/8/28.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMIndexPageMenuCell.h"


@implementation DMIndexPageMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews {
    NSArray *titleArray = @[@"新手入门", @"薅羊毛", @"P2P产品库", @"排行榜"];
    for (NSUInteger i = 1; i < 5; i++) {
        DMButton *button = [self createButtonWithTitle:[titleArray objectAt:i - 1] tag:i];
        button.left = AUTOSIZE(12) + button.width * (i - 1);
        [button buttonClickedcompletion:^(id returnData) {
            if (_delegate && [_delegate respondsToSelector:@selector(menuAction:)]) {
                [_delegate menuAction:i];
            }
        }];
        [self.contentView addSubview:button];
    }
}

-(DMButton *)createButtonWithTitle:(NSString *)title tag:(NSUInteger)tag {
    DMButton *button = [[DMButton alloc] initWithFrame:CGRectMake(0, 0, (kScreenWidth - AUTOSIZE(24))/4, 100)];
    
//    [button setBackgroundImage:[UIImage imageWithColor:kDMDefaultGrayStringColor size:button.frame.size] forState:UIControlStateHighlighted];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((button.width - 46)/2, 16,46, 46)];
    switch (tag) {
        case 1:
            imageView.image = [UIImage imageNamed:@"mark.png"];
            break;
        case 2:
            imageView.image = [UIImage imageNamed:@"nearby.png"];
            break;
        case 3:
            imageView.image = [UIImage imageNamed:@"cal.png"];
            break;
        case 4:
            imageView.image = [UIImage imageNamed:@"num.png"];
            break;

        default:
            break;
    }
    imageView.userInteractionEnabled = NO;
    [button addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom, button.width, AUTOSIZE(32))];
    label.text = title;
    label.textColor = kDMDefaultBlackStringColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = FONT(14);
    [button addSubview:label];
    
    
    return button;
}
@end
