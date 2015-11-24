//
//  DMCategoryItemView.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/11.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMCategoryItemView.h"

@implementation DMCategoryItemView {
    UIImageView *_imageView;
    UILabel *_nameLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(selecteView)];
    [self addGestureRecognizer:tap];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.height - AUTOSIZE(24))/2, AUTOSIZE(24), AUTOSIZE(24))];
    _imageView.image = [UIImage imageWithResourcesPathCompontent:@"icon_chooseCategory_normal.png"];
    _imageView.userInteractionEnabled = YES;
    [self addSubview:_imageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.right + 10, 0, self.width - _imageView.right - 10, self.height)];
    _nameLabel.textColor = kDMDefaultBlackStringColor;
    _nameLabel.font = FONT(16);
    [self addSubview:_nameLabel];
    
}

-(void)setCategoryName:(NSString *)categoryName {
    _categoryName = categoryName;
    _nameLabel.text = categoryName;
}

-(void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (isSelected) {
        _imageView.image = [UIImage imageWithResourcesPathCompontent:@"icon_chooseCategory_selected.png"];
    } else {
        _imageView.image = [UIImage imageWithResourcesPathCompontent:@"icon_chooseCategory_normal.png"];
    }
}

- (void)selecteView {
    if (_delegate && [_delegate respondsToSelector:@selector(selectedActionWithCategoryName:)]) {
        [_delegate selectedActionWithCategoryName:_categoryName];
    }
}
@end
