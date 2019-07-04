//
//  AppNavigator.m
//  proList
//
//  Created by huangbaoxian on 2019/6/30.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "AppNavigator.h"
#import "RootNavViewController.h"
#import "AppDelegate.h"
#import "TabbarViewController.h"
#import "ZJStartViewController.h"
#import "HBXStartViewController.h"

@implementation AppNavigator
+ (instancetype)navigator
    {
        static AppNavigator    *navigator = nil;
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            navigator = [[AppNavigator alloc] init];
        });
        
        return navigator;
    }
    
    
+ (void)openFirstViewController{
    if ([APPCONTEXT checkLoginInfo]) {
        [AppNavigator openMainViewController];
    }else{
        [AppNavigator openLoginViewController];
    }
}
    
+ (void)openWebViewController {
    HBXWebViewController *webVC = [[HBXWebViewController alloc] init];
    [AppDelegate mainWindow].rootViewController = webVC;
}
    
+ (void)openMainViewController
    {
        TabbarViewController *vc = [[TabbarViewController alloc] init];
        [AppNavigator openMainNavControllerWithRoot:vc];
        
    }
+ (void)openStartPicViewController{
    HBXStartViewController *startVC = [[HBXStartViewController alloc] init];
    [AppDelegate mainWindow].rootViewController = startVC;
    [AppNavigator navigator].mainNav = startVC;
}
    
    
+ (void)openMainNavControllerWithRoot:(UIViewController *)rootViewController
    {
        NSAssert([[NSThread currentThread] isEqual:[NSThread mainThread]], @"PUSH can only be started from the main thread.");
        RootNavViewController *nav = [[RootNavViewController alloc] initWithRootViewController:rootViewController];
        [AppDelegate mainWindow].rootViewController = nav;
        [AppNavigator navigator].mainNav = nav;
    }
+ (void)openLoginViewController{
    
    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    if (currentOrientation != UIInterfaceOrientationPortrait) {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
    }
    LoginViewController *login = [[LoginViewController alloc] init];
    [AppNavigator openMainNavControllerWithRoot:login];
}
    
    
    
    
+ (void)pushToLoginViewController{
    LoginViewController *login = [[LoginViewController alloc] init];
    [AppNavigator pushViewController:login animated:YES];
}
   
    
+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
    {
        [[AppNavigator navigator].rootNav pushViewController:viewController animated:animated];
        [[AppNavigator navigator].mainNav setNavigationBarHidden:NO animated:animated];
    }
+ (UIViewController *)getTopViewController {
    if ([AppNavigator navigator].rootNav.viewControllers > 0) {
        return [[AppNavigator navigator].rootNav.viewControllers lastObject];
    }
    return nil;
    
}
+ (void)popViewControllerAnimated:(BOOL)animated
    {
        [[AppNavigator navigator].rootNav popViewControllerAnimated:animated];
    }
    
+ (void)popToRootViewControllerAnimated:(BOOL) animated
    {
        [[AppNavigator navigator].rootNav popToRootViewControllerAnimated:animated];
    }
    
- (UINavigationController *)rootNav{
    UIViewController *presentCon = [[AppNavigator navigator].mainNav presentedViewController];
    if (presentCon && [presentCon isKindOfClass:[RootNavViewController class]]) {
        while (1) {
            UIViewController *presentConTmp = [presentCon presentedViewController];
            if (presentConTmp && [presentConTmp isKindOfClass:[UINavigationController class]]) {
                presentCon = presentConTmp;
            }else{
                break;
            }
        }
        return (RootNavViewController *)presentCon;
    }
    return [AppNavigator navigator].mainNav;
}
+ (void)showModalViewController:(UIViewController *)viewController animated:(BOOL)animated
    {
        NSLog(@"mainNav: %@", [AppNavigator navigator].mainNav);
        if ([AppNavigator navigator].mainNav != nil) {
            if ([[AppNavigator navigator].mainNav presentedViewController]) {
                UIViewController *presentCon = [[AppNavigator navigator].mainNav presentedViewController];
                viewController.popoverPresentationController.sourceView = presentCon.view;
                CGRectMake(SCREEN_WIDTH/4, SCREEN_HEIGHT/4,SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
                [presentCon presentViewController:viewController animated:animated completion:nil];
            } else {
                viewController.popoverPresentationController.sourceView = [AppNavigator navigator].mainNav.view;
                viewController.popoverPresentationController.sourceRect = CGRectMake(SCREEN_WIDTH/4, SCREEN_HEIGHT/4,SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
                [[AppNavigator navigator].mainNav presentViewController:viewController animated:animated completion:nil];
            }
        }
    }
    
+ (void)openSubViewControler:(NSInteger)type {
    [[TabbarViewController tabbarViewController] changeToIndex:type];
}
@end
