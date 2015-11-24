//
//  DMChooseCategoryView.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/11.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMChooseCategoryView.h"

@implementation DMChooseCategoryView {
    UIView *_bgView;
    UIView *_categorysView;
    UIScrollView *_scrollView;
    DMButton *_doneButton;
}

-(instancetype)initWithFrame:(CGRect)frame columnCount:(NSUInteger)columnCount{
    self = [super initWithFrame:frame];
    if (self) {
        _columnCount = columnCount;
        [self createSubViews];
    }
    return self;
}

-(instancetype)initWithWindow:(UIWindow *)window  columnCount:(NSUInteger)columnCount{
    return [self initWithFrame:window.bounds columnCount:columnCount];
}

-(void)createSubViews {
    _bgView = [[UIView alloc] initWithFrame:self.bounds];
    _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self addSubview:_bgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(hideView)];
    [_bgView addGestureRecognizer:tap];
    
    _categorysView = [[UIView alloc] init];
    _categorysView.width = kScreenWidth - AUTOSIZE(90);
    _categorysView.height = 100;
    _categorysView.backgroundColor = [UIColor whiteColor];
    _categorysView.top = 120;
    _categorysView.left = AUTOSIZE(45);
    _categorysView.layer.cornerRadius = 10;
    _categorysView.clipsToBounds = YES;
    [self addSubview:_categorysView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, AUTOSIZE(25), _categorysView.width, 110)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.userInteractionEnabled = YES;
    
    _doneButton = [[DMButton alloc] initWithFrame:CGRectMake(AUTOSIZE(22), 0, _categorysView.width - AUTOSIZE(44), AUTOSIZE(44))];
    _doneButton.layer.cornerRadius = AUTOSIZE(22);
    _doneButton.clipsToBounds = YES;
    [_doneButton setBackgroundImage:[UIImage imageWithColor:kDMDefaultBlackStringColor size:CGSizeMake(10, 10)] forState:UIControlStateNormal];
    [_doneButton setBackgroundImage:[UIImage imageWithColor:[[UIColor colorWithHexString:@"666666"] colorWithAlphaComponent:0.5] size:CGSizeMake(10, 10)] forState:UIControlStateNormal];

    [_doneButton setTitle:@"确定" forState:UIControlStateNormal];
    [_doneButton.titleLabel setFont:FONT(21)];
    [_doneButton buttonClickedcompletion:^(id returnData) {
        
    }];
    _doneButton.hidden = YES;
    [_categorysView addSubview:_doneButton];
}

-(void)setCategoryArray:(NSArray *)categoryArray {
    _categoryArray = categoryArray;
    [_categorysView removeSubviews];
    [_categorysView addSubview:_scrollView];
    [_categorysView addSubview:_doneButton];
    CGFloat itemWith = 0;
    CGFloat left = AUTOSIZE(32);
    CGFloat top = 0;
    if (_columnCount == 1) {
        itemWith = _categorysView.width - AUTOSIZE(40);
    } else if (_columnCount == 2) {
        itemWith = AUTOSIZE(100);
    }
    for (NSUInteger i = 0; i < categoryArray.count; i++) {
        DMCategoryItemView *view = [[DMCategoryItemView alloc] initWithFrame:CGRectMake(left, top, itemWith, AUTOSIZE(50))];
        view.categoryName = [categoryArray objectAt:i];
        view.delegate = self;
        [_scrollView addSubview:view];
        
        left += itemWith + 5;
        if (left + itemWith > _categorysView.width) {
            top += AUTOSIZE(50);
            left = AUTOSIZE(32);
        }
    }
    if (categoryArray.count > 0) {
        _scrollView.height = MIN(top + AUTOSIZE(50), kScreenHeight - 240) - AUTOSIZE(50);
        _scrollView.contentSize = CGSizeMake(_scrollView.width, top);
        if (_hasDoneButton) {
            _categorysView.height = _scrollView.height + AUTOSIZE(50) + AUTOSIZE(64);
            _doneButton.hidden = NO;
            _doneButton.bottom = _categorysView.height - AUTOSIZE(20);
        } else {
            _doneButton.hidden = YES;
            _categorysView.height = _scrollView.height + AUTOSIZE(50);
        }
    }

}

-(void)setColumnCount:(NSUInteger)columnCount {
    _columnCount = columnCount;
}

-(void)setSelectCategoryArray:(NSArray *)selectCategoryArray {
    _selectCategoryArray = selectCategoryArray;
    for (DMCategoryItemView *view in _scrollView.subviews) {
        if (view && [view isKindOfClass:[DMCategoryItemView class]]) {
            if ([view.categoryName isBelongToArray:selectCategoryArray]) {
                view.isSelected = YES;
            } else {
                view.isSelected = NO;
            }
        }
    }
}

-(UIView *)createCategoryItemView:(NSString *)categoryName {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    return view;
}

- (void)hideView {
    [self removeFromSuperview];
}

- (void)selectedActionWithCategoryName:(NSString *)categoryName {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];

    if (_columnCount == 1) {
        /**
         *  先设置所有的按钮为未选中
         */
        for (DMCategoryItemView *view in _scrollView.subviews) {
            if (view && [view isKindOfClass:[DMCategoryItemView class]]) {
                view.isSelected = NO;
            }
        }
    } else {
        [array addObjectsFromArray:_selectCategoryArray];
    }
    BOOL hasSelected = NO;
    for (NSString *string in array) {
        if ([string isEqualToString:categoryName]) {
            [array removeObject:string];
            hasSelected = YES;
            break;
        }
    }
    if (array && !hasSelected) {
        [array addObject:categoryName];
    }
    
    
    self.selectCategoryArray = array;
    if (_columnCount == 1) {
        if (_delegate && [_delegate respondsToSelector:@selector(selectedActionWithCategoryName:)]) {
            [_delegate selectedActionWithCategoryName:categoryName];
        }
    }
}

@end
