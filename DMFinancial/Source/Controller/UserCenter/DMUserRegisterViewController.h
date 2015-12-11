//
//  DMUserRegisterViewController.h
//  DamaiPlayPhone
//
//  Created by 陈彦岐 on 15/4/16.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMBaseViewController.h"
typedef void(^LoginSuccess)(id returnData);

typedef void(^LoginFail)(id returnData);

@interface DMUserRegisterViewController : DMBaseViewController

@property (nonatomic, assign) BOOL fromLogin;
@property(nonatomic,strong)LoginSuccess success;

@property(nonatomic,strong)LoginFail  fail;

@end
