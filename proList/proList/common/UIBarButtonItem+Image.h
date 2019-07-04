//
//  UIBarButtonItem+Image.h
//  RenrenSixin
//
//  Created by 钟 声 on 11-12-28.
//  Copyright (c) 2011年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIBarButtonItem (CustomImage)
// 私信1.0用
+ (UIBarButtonItem *)rsBarButtonItemWithTitle:(NSString *)title
                                       target:(id)target
                                       action:(SEL)selector;
// 可扩展
+ (UIBarButtonItem *)rsBarButtonItemWithTitle:(NSString *)title 
                                        image:(UIImage *)image
                             heightLightImage:(UIImage *)hlImage
                                 disableImage:(UIImage *)disImage
                                       target:(id)target
                                       action:(SEL)selector;

+ (UIBarButtonItem *)rsBarButtonItemWithBellButton:(UIButton *)bellButton
                                        image:(UIImage *)image
                             heightLightImage:(UIImage *)hlImage
                                 disableImage:(UIImage *)disImage
                                       target:(id)target
                                       action:(SEL)selector;

+ (UIButton*)rsCustomBarButtonWithTitle:(NSString*)title
                                  image:(UIImage *)image
                       heightLightImage:(UIImage *)hlImage
                           disableImage:(UIImage *)disImage
                                 target:(id)target
                                 action:(SEL)selector;
+ (UIBarButtonItem *)rsNormalBarButtonItemWithTitle:(NSString *)title
                                              image:(UIImage *)image
                                   heightLightImage:(UIImage *)hlImage
                                       disableImage:(UIImage *)disImage
                                             target:(id)target
                                             action:(SEL)selector;
- (void)setButtonAttribute:(NSDictionary*)dic;

+ (UIBarButtonItem *)rsBarButtonTitleBlewImage:(UIImage *)image
                                         title:(NSString *)title
                                        target:(id)target
                                        action:(SEL)selector;


+ (UIBarButtonItem *)rsBarButtonTitle:(NSString *)title
                                color:(UIColor *)textColor
                               target:(id)target
                               action:(SEL)selector;

/**
 *显示红点
 */
+ (UIBarButtonItem *)rsBarButtonItemWithTitle:(NSString *)title
                                        image:(UIImage *)image
                                     showRedD:(BOOL)isShowRedDat
                             heightLightImage:(UIImage *)hlImage
                                 disableImage:(UIImage *)disImage
                                       target:(id)target
                                       action:(SEL)selector;

/*
 * 是否显示红点
 */
+ (UIBarButtonItem *)rsBarButtonTitle:(NSString *)title
                                color:(UIColor *)textColor
                             showRedD:(BOOL)isShowRedDat
                               target:(id)target
                               action:(SEL)selector;

/*
 * 是否显示红点
 */
+ (UIBarButtonItem *)rsBarButtonItemWithTitle:(NSString *)title
                                    showRedD:(BOOL)isShowRedDat
                                       target:(id)target
                                       action:(SEL)selector;

/*
 * 是否显示红点
 */
+ (UIBarButtonItem *)rsBarButtonTitleBlewImage:(UIImage *)image
                                  isShowRedDot:(BOOL)isShowRedDot
                                         title:(NSString *)title
                                        target:(id)target
                                        action:(SEL)selector;

@end
