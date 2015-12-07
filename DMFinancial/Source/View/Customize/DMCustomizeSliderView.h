//
//  DMCustomizeSliderView.h
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/7.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DMCustomizeSliderViewDelegate<NSObject>
/*
    选中的选项
 */
-(void)selectedOption:(NSString *)option index:(NSInteger)index;

@end

@interface DMCustomizeSliderView : UIView

/*
    选项数组
 */
@property (nonatomic, strong) NSArray *optionsArray;

@property (nonatomic, assign) id<DMCustomizeSliderViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame options:(NSArray *)options;

@end
