//
//  DMHelper.m
//  DamaiHD
//
//  Created by lixiang on 13-10-12.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMHelper.h"

@implementation DMHelper

+ (float)AppTopMargin {
    if (IOS7ORNEW) {
        return 20;
    } else {
        return 0;
    }
}


+ (NSString *)getDMPicUrl:(NSInteger)pId {
    NSInteger folder = pId / 100;
    return [NSString stringWithFormat:@"http://pimg.damai.cn/perform/project/%@/%@_n.jpg", @(folder), @(pId)];
}
+ (NSString *)getDMEticketPicUrl:(NSString *)url
{
    return [NSString stringWithFormat:@"%@%@",DMAPIBaseURL,url];
}

+ (BOOL)createFolder:(NSString*)folderPath isDirectory:(BOOL)isDirectory {
	NSString *path = nil;
	if(isDirectory) {
        path = folderPath;
    } else {
        path = [folderPath stringByDeletingLastPathComponent];
    }
	
	if(folderPath && [[NSFileManager defaultManager] fileExistsAtPath:path] == NO) {
		NSError *error = nil;
		BOOL ret;
        
		ret = [[NSFileManager defaultManager] createDirectoryAtPath:path
										withIntermediateDirectories:YES
														 attributes:nil
															  error:&error];
		if(!ret && error) {
			NSLog(@"create folder failed at path '%@',error:%@,%@",folderPath,[error localizedDescription],[error localizedFailureReason]);
			return NO;
		}
	}
	
	return YES;
}

+ (NSString *) removeSpace:(NSString *) String
{
    NSString *resultString=@"";
    
    for (NSUInteger i=0; i<[String length]; i++) {
        UniChar myChar=[String characterAtIndex:i];
        if (myChar!=' ' && myChar!='\n' && myChar!='\t' && myChar!='\r') {
            resultString=[resultString stringByAppendingFormat:@"%C",myChar];
        }
    }
    return resultString;
}

+ (BOOL)saveData:(NSData *)data toFile:(NSString *)path {
    [DMHelper createFolder:path isDirectory:NO];
    return [data writeToFile:path atomically:YES];
}

+ (int)getLocalAppVersion {
    NSString * s = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSArray *array = [s componentsSeparatedByString:@"."];
    
	int VNum=0;
	int Factor=10000;
	for(NSString *c in array){
		VNum+=[c intValue]*Factor;
		Factor/=100;
	}
    return VNum;
    
}

+ (BOOL)isNumeric:(NSString *)string {
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *regex = @"^[0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)isNumericDecimal:(NSString *)string
{
    NSString *regex = @"^[0-9]+(.[0-9]{2})?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)isLogin{
    return NO;

}
//如果报名活动需要审核，报名的审核状态：0 = 未提交审核;1 = 待审核; 2 = 审核已通过; 3  = 审核未通过（不存在则不需要进行审核）
+ (NSString *)getSignUpStatusStringWithId:(NSInteger)statusId {
    switch (statusId) {
        case 0:
        case 1:
            return @"报名待审核";
            break;
        case 2:
            return @"报名成功";
            break;
        case 3:
            return @"报名未通过";
            break;

        default:
            return @"";
            break;
    }
}

//订单状态：  1 = 待付款; 2 = 用户取消; 3 = 系统取消;  4 = 已完成; 5 = 客服取消
+ (NSString *)getOrderStatusStringWithId:(NSInteger)statusId {
    switch (statusId) {
        case 0:
            return @"";
            break;
        case 1:
            return @"待付款";
            break;
        case 2:
        case 3:
        case 5:
            return @"已取消";
            break;
        case 4:
            return @"已付款";
            break;
        case 6:
            return @"订单失败";
            break;

        default:
            return @"";
            break;
    }
}

@end
