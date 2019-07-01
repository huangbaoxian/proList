//
//  AppNavigator.h
//  proList
//
//  Created by huangbaoxian on 2019/6/30.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppNavigator : NSObject
    @property (nonatomic, strong) UINavigationController *mainNav;
    
+ (instancetype)navigator;
+ (UIViewController *)getTopViewController;
+ (void)openFirstViewController;
+ (void)openMainViewController;
+ (void)openLoginViewController;
+ (void)openStartPicViewController;
    
+ (void)pushToLoginViewController;
+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
+ (void)popViewControllerAnimated:(BOOL)animated;
+ (void)popToRootViewControllerAnimated:(BOOL) animated;

+ (void)openWebViewController;
    
+ (void)showModalViewController:(UIViewController *)viewController animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
