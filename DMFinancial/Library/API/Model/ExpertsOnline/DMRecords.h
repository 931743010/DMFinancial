//
//  DMRecords.h
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/23.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMObject.h"

@interface DMRecords : DMObject

@property (nonatomic, strong) NSString *msgid;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *userImg;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *userName;

@end

@interface DMRecordsListItem : DMObject

@property (nonatomic, strong) NSNumber *recordsId;
@property (nonatomic, strong) NSString *caseid;
@property (nonatomic, strong) NSString *headimgid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *lastmsg;
@property (nonatomic, strong) NSString *lastmsgtime;
@property (nonatomic, strong) NSString *noread;

@end
