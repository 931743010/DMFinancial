//
//  DMBookkeepingCollectionView.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/2.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMBookkeepingCollectionView.h"

@implementation DMBookkeepingItem

@end

@implementation DMBookkeepingCollectionView {
    UIImageView *_iconImageView;
    UILabel *_nameLabel;
}


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews {
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - 30)/2, 30, 30, 30)];
    _iconImageView.backgroundColor = [UIColor redColor];
    [self addSubview:_iconImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.height - 30, self.width - 10, 14)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = FONT(13);
    [self addSubview:_nameLabel];

}

-(void)setItem:(DMBookkeepingItem *)item {
    _item = item;
    _nameLabel.text = item.itemName;
}

@end
