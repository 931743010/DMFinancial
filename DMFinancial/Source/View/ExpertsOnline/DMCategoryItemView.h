//
//  DMCategoryItemView.h
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/11.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DMCategoryItemViewDelegate <NSObject>

- (void)selectedActionWithCategoryName:(NSString *)categoryName;
@end

@interface DMCategoryItemView : UIView

/**
 *  是否被选中
 */
@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign) id<DMCategoryItemViewDelegate> delegate;

@property (nonatomic, strong) NSString *categoryName;
@end
