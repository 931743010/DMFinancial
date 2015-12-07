//
//  DMRiskPreferenceTestView.h
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/7.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMRiskPreferenceTestItem : DMObject

@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSArray *answerList;
@end

@protocol DMRiskPreferenceTestViewDelegate<NSObject>
/*
    选中的选项
    index 选中的答案
    tag 第几道题
 */
-(void)selectedAnswer:(NSInteger)index tag:(NSInteger)tag;

@end

@interface DMRiskPreferenceTestView : UIView

@property (nonatomic, strong) DMRiskPreferenceTestItem *item;
@property (nonatomic, strong) id<DMRiskPreferenceTestViewDelegate> delegate;

@end
