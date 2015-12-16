//
//  DMRiskPreferenceTestView.h
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/7.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMRiskPreferenceTestItem : DMObject

@property (nonatomic, strong) NSString *selectedAnswer;//已选择的答案
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSArray *answerList;
@end


@interface DMRiskPreferenceTestView : UIView

@property (nonatomic, strong) DMRiskPreferenceTestItem *item;

@end
