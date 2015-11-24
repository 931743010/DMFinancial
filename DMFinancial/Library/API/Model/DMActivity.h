//
//  DMActivity.h
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/24.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMObject.h"

@interface DMActivity : DMObject

@property (nonatomic, strong) NSString *activityId;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *actimg;
@property (nonatomic, strong) NSString *actlogo;
@property (nonatomic, strong) NSString *acttime;
@property (nonatomic, strong) NSString *actplace;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *acttitle;

@end
