//
//  Function.h
//  DamaiHD
//
//  Created by lixiang on 13-9-26.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#ifndef DamaiHD_Function_h
#define DamaiHD_Function_h

//常用函数
#define AUTOSIZE(i)                 ceil(((([UIScreen mainScreen].bounds).size.width*2) / 720) * i) //根据屏幕宽度调整尺寸(以iPhone6尺寸为基准 750)

#define DMLOG(fmt, ...)             NSLog((@"[File:%s],[Function:%s],[Line:%d]::: " fmt), __FILE__,__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define DMLOGDATA(data)             DMLOG(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding])
#define RGBA(r,g,b,a)               [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define FONT(f)                     [UIFont fontWithName:@"Helvetica-Light" size:f]
#define BOLDFONT(f)                 [UIFont boldSystemFontOfSize:f]


#define PATH_AT_APPDIR(name)        [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name]
#define PATH_AT_DOCDIR(name)        [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name]
#define PATH_AT_TMPDIR(name)        [NSTemporaryDirectory() stringByAppendingPathComponent:name]
#define PATH_AT_CACHEDIR(name)		[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name]
#define PATH_AT_LIBDIR(name)		[[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name]
#define DismissModalViewControllerAnimated(controller,animated) [controller respondsToSelector:@selector(dismissViewControllerAnimated:completion:)] ? [controller dismissViewControllerAnimated:animated completion:nil] : [controller dismissModalViewControllerAnimated:animated]
#define PresentModalViewControllerAnimated(controller1,controller2,animated)     [LSHelper presentModalViewRootController:controller1 toViewController:controller2 Animated:animated];

#define IsNilOrNull(obj) (obj == nil) || ([obj isEqual:[NSNull null]])
#define getStringWithOutNil(string) (obj != nil)?obj:@""

/**
 *  设备信息相关
 */
#define INTERFACE_IS_PAD        ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define INTERFACE_IS_PHONE      ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define kApplicationWidth       ([UIScreen mainScreen].applicationFrame).size.width //应用程序的宽度
#define kApplicationHeight      ([UIScreen mainScreen].applicationFrame).size.height //应用程序的高度
#define kScreenWidth            ([UIScreen mainScreen].bounds).size.width //屏幕的宽度
#define kScreenHeight           ([UIScreen mainScreen].bounds).size.height //屏幕的高度
#define IOS7ORNEW               ([[UIDevice currentDevice].systemVersion floatValue] >= 7)
#define VERSION                 [[UIDevice currentDevice].systemVersion floatValue]
#define APPVERSION              [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


#define ISRETINASCREEN      [UIScreen mainScreen].scale == 1.0 ? NO : YES
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_GREATER_OR_EQUAL_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define ISIPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#endif
