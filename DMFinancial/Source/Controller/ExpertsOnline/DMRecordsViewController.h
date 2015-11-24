//
//  DMRecordsViewController.h
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/23.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMBaseViewController.h"
#import "DMSplist.h"

@interface DMRecordsViewController : DMBaseViewController

@property (nonatomic, strong) NSString *spid;
@property (nonatomic, strong) DMSplist *item;

@end
