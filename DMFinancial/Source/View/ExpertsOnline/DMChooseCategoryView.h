//
//  DMChooseCategoryView.h
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/11.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMCategoryItemView.h"

@protocol DMChooseCategoryViewDelegate <NSObject>

- (void)selectedActionWithCategoryName:(NSString *)categoryName;
@end

@interface DMChooseCategoryView : UIView <DMCategoryItemViewDelegate>
/**
 *  所需筛选的分类数组
 */
@property (nonatomic, strong) NSArray *categoryArray;

/**
 *  所选择的分类数组
 */
@property (nonatomic, strong) NSArray *selectCategoryArray;

/**
 *  显示几列 默认显示一列
 */
@property (nonatomic, assign) NSUInteger columnCount;

/**
 *  是否可以多选 默认不可以多选
 */
@property (nonatomic, assign) BOOL canMultiSelect;

/**
 *  是否显示确定按钮
 */
@property (nonatomic, assign) BOOL hasDoneButton;

/**
 *  确定按钮
 */
@property (nonatomic, strong) DMButton *doneButton;

@property (nonatomic, assign) id<DMChooseCategoryViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame columnCount:(NSUInteger)columnCount;

/**
 *  添加到window
 */
-(id)initWithWindow:(UIWindow *)window  columnCount:(NSUInteger)columnCount;

@end
