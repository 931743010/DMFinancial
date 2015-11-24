//
//  CommonHelper.m
//  DamaiHD
//
//  Created by lixiang on 13-10-12.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "CommonHelper.h"

@implementation CommonHelper


+ (void)setValue:(id)value forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)valueForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

+ (void)setObject:(NSObject<NSCoding> *)object forKey:(NSString *)key {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSObject *)objectForKey:(NSString *)key {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSObject *object = nil;
    if (data != nil) {
        object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return object;
}

+ (NSData *)archiverObject:(NSObject *)object forKey:(NSString *)key {
	if(object == nil) {
        return nil;
    }
	
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	[archiver encodeObject:object forKey:key];
	[archiver finishEncoding];
	
	return data;
}

+ (NSObject *)unarchiverObject:(NSData *)archivedData withKey:(NSString *)key {
	if(archivedData == nil) {
        return nil;
    }
	
	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:archivedData];
	NSObject *object = [unarchiver decodeObjectForKey:key];
	[unarchiver finishDecoding];
	
	return object;
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
    [CommonHelper createFolder:path isDirectory:NO];
    return [data writeToFile:path atomically:YES];
}

+ (NSInteger)heightForLabelWithString:(NSString *)labelString withFontSize:(UIFont *)fontsize withWidth:(CGFloat)width withHeight:(CGFloat)height {
	CGSize maximumLabelSize = CGSizeMake(width, height);
	CGSize expectedLabelSize = [labelString sizeWithFont:fontsize
									   constrainedToSize:maximumLabelSize
										   lineBreakMode:0];
	
	return (int)(expectedLabelSize.height);
}

+ (NSInteger)widthForLabelWithString:(NSString *)labelString withFontSize:(UIFont *)fontsize withWidth:(CGFloat)width withHeight:(CGFloat)height {
	CGSize maximumLabelSize = CGSizeMake(width,height);
	CGSize expectedLabelSize = [labelString sizeWithFont:fontsize
									   constrainedToSize:maximumLabelSize
										   lineBreakMode:NSLineBreakByWordWrapping];
	
	return (expectedLabelSize.width);
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


@end
