//
//  DMLoginViewController.h
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/9.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMBaseViewController.h"

typedef void(^LoginSuccess)(id returnData);

typedef void(^LoginFail)(id returnData);

@interface DMLoginViewController : DMBaseViewController

@property(nonatomic,strong)LoginSuccess success;

@property(nonatomic,strong)LoginFail  fail;


@end
