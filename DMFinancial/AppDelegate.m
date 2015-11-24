//
//  AppDelegate.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/24.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initViewControllers];
    [self initCommonServices];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)initCommonServices {
    
}

- (void)initViewControllers {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.delegate = self;
    self.tabBarController.tabBar.translucent = NO;
//    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
//                                               [UIColor colorWithHexString:@"3e3030"],NSForegroundColorAttributeName,
//                                               FONT(17), NSFontAttributeName, nil];
//    
//    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
//    [[UINavigationBar appearance] setTintColor:kDMDefaultBlackStringColor];
//    
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : kDMDefaultGrayStringColor}
//                                             forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : kDMDefaultBlackStringColor}
//                                             forState:UIControlStateSelected];
    
    FirstViewController *activityPageController = [[FirstViewController alloc] init];
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:activityPageController];
//    [nav1.navigationBar drawSolidLineWithFrame:CGRectMake(0, nav1.navigationBar.bottom - 0.5, nav1.navigationBar.width, 0.5)];
//    for (UIView *view in nav1.navigationBar.subviews) {
//        for (UIView *view2 in view.subviews) {
//            if ([view2 isKindOfClass:[UIImageView class]]) {
//                [view2 removeFromSuperview];
//                UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64 - 0.5, view.width, 0.5)];
//                lineView.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
//                [view addSubview:lineView];
//            }
//        }
//    }
    
    SecondViewController *categoryViewController = [[SecondViewController alloc] init];
//    categoryViewController.hideBackButton = YES;
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:categoryViewController];
//    //    [nav2.navigationBar drawSolidLineWithFrame:CGRectMake(0, nav1.navigationBar.bottom - 0.5, nav1.navigationBar.width, 0.5)];
//    for (UIView *view in nav2.navigationBar.subviews) {
//        for (UIView *view2 in view.subviews) {
//            if ([view2 isKindOfClass:[UIImageView class]]) {
//                [view2 removeFromSuperview];
//                UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64 - 0.5, view.width, 0.5)];
//                lineView.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
//                [view addSubview:lineView];
//            }
//        }
//    }
    
    
    NSArray *controllers = @[nav1, nav2];
    [self.tabBarController setViewControllers:controllers];
    
    
    NSArray *titles = @[@"首页", @"分类", @"消息", @"我"];
    
    int i = 0;
    for (UITabBarItem *item in self.tabBarController.tabBar.items) {
        UIImage *selectedImage = [UIImage imageNamed:@""];
        UIImage *unselectedImage = [UIImage imageNamed:@""];
//        if (i == DMIndexPageIndex) {
//            unselectedImage = [[UIImage imageNamed:@"icon_tab1_normal.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//            selectedImage = [[UIImage imageNamed:@"icon_tab1_press.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        } else if (i == DMFindPageIndex) {
//            unselectedImage = [[UIImage imageNamed:@"icon_tab2_normal.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//            selectedImage = [[UIImage imageNamed:@"icon_tab2_press.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        } else if (i == DMChatPageIndex) {
//            unselectedImage = [[UIImage imageNamed:@"icon_tab3_normal.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//            selectedImage = [[UIImage imageNamed:@"icon_tab3_press.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        } else if (i == DMUserCenterPageIndex) {
//            unselectedImage = [[UIImage imageNamed:@"icon_tab4_normal.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//            selectedImage = [[UIImage imageNamed:@"icon_tab4_press.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        } else {
//            unselectedImage = [[UIImage imageNamed:@"icon_tab1_normal.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//            selectedImage = [[UIImage imageNamed:@"icon_tab1_press.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        }
        item.image = unselectedImage;
        item.selectedImage = selectedImage;
        //        CGFloat offset = 6.0;
        //        item.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
        
        item.title = [titles objectAt:i];
        i++;
    }
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
}

@end
