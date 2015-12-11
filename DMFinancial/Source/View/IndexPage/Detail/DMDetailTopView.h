//
//  DMDetailTopView.h
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/9.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMProjectListItem.h"

@protocol DMDetailTopViewDelegate <NSObject>

/*
    点击收藏按钮
 */
-(void)collectionProjectWithId:(NSString *)projectId type:(DMAssetsType)type;


@end
@interface DMDetailTopView : UIView

@property (nonatomic, strong) DMProjectListItem *item;
@property (nonatomic, assign) id<DMDetailTopViewDelegate> delegate;
@end
