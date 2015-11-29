//
//  DMFindPageView.m
//  DamaiPlayPhone
//
//  Created by Joseph Fu on 14/12/16.
//  Copyright (c) 2014年 陈彦岐. All rights reserved.
//

#import "DMFindPageView.h"
#import "UIView+JFLayout.h"
#import <libkern/OSAtomic.h>

@interface DMFindPageView (){
    OSSpinLock _loadingCompleteLock;
    CGPoint _prePoint;
    CGPoint _currentPoint;
    BOOL _slidedOut;
    BOOL _slidedIn;
}
@end

@implementation DMFindPageView

- (void)dealloc
{
//    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    
        _loadingCompleteLock = OS_SPINLOCK_INIT;
        
        NSMutableArray *constraints = [NSMutableArray array];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame
                                                              style:UITableViewStylePlain];
        self.tableView = tableView;
        [self addSubview:self.tableView];
    }
    
    return self;
}


- (void)cancelRequest {
    [_tableView.pullToRefreshView stopAnimating];
    [_tableView.infiniteScrollingView stopAnimating];
}

@end
