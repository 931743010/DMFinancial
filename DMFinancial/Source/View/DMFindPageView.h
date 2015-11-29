//
//  DMFindPageView.h
//  DamaiPlayPhone
//
//  Created by Joseph Fu on 14/12/16.
//  Copyright (c) 2014年 陈彦岐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMFindPageView : UIView

@property (nonatomic) NSInteger index;
@property (nonatomic, strong) UITableView *tableView;

- (void)cancelRequest;

@end
