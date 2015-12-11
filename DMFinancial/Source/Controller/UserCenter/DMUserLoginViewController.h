//
//  DMUserLoginViewController.h
//  DamaiPlayPhone
//
//  Created by 陈彦岐 on 14/12/24.
//  Copyright (c) 2014年 陈彦岐. All rights reserved.
//

#import "DMBaseViewController.h"

typedef enum : NSUInteger {
    DMOtherLoginTypeSina,
    DMOtherLoginTypeWX,
    DMOtherLoginTypeQQ,
} DMOtherLoginType;

typedef enum : NSUInteger {
    DMViewTypeLogin,
    DMViewTypeRegister,
} DMViewType;

typedef void(^LoginSuccess)(id returnData);

typedef void(^LoginFail)(id returnData);

@interface DMUserLoginViewController : DMBaseViewController
@property (nonatomic, assign) DMViewType loginType;

@property(nonatomic,strong)LoginSuccess success;

@property(nonatomic,strong)LoginFail  fail;

@end
