//
//  DMMessageItem.h
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/30.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMObject.h"

@interface DMMessageItem : DMObject

@property (nonatomic, strong) NSString  *title;
@property (nonatomic, strong) NSString  *contents;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) BOOL isNewMessage;

@end
