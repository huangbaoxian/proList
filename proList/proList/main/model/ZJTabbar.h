//
//  ZJTabbar.h
//  proList
//
//  Created by huangbaoxian on 2019/6/30.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJTabbar;
@protocol ZJTabbarDelegate <NSObject>
    @required
- (void)rsTabBar:(ZJTabbar*)tabBar unSelectedIndex:(NSInteger)index;
- (void)rsTabBar:(ZJTabbar*)tabBar didSelectedIndex:(NSInteger)index;
- (BOOL)canChangeToIndex:(NSInteger)index;
    @end
@interface ZJTabbarItem : UIView
    @property (nonatomic, strong) UIImage* imageActive;
    @property (nonatomic, strong) UIImage* imageUnActive;
    
    @property (nonatomic, strong) UIImageView* bgImage;
    @property (nonatomic, strong) UILabel* titleLabel;
    @property (nonatomic, strong) UIImageView* selctedBg;
    @property (nonatomic, strong) UIColor *selectedBgColor;
    @property (nonatomic, strong) UIView *redDotView;
    @property (nonatomic, strong) UILabel   *unReadCountLabel;
- (void)showUnreadCountLabel:(NSInteger)count;
- (void)showRedDotView;
- (void)hideRedDotView;
    @end

@interface ZJTabbar : UIView
    @property (nonatomic, assign) CGFloat tabWidth;
    @property (nonatomic, weak) id<ZJTabbarDelegate> tabBarDelegate;
    @property (nonatomic, assign) NSInteger currentIndex;
    @property (nonatomic, assign) NSUInteger tabCount;
- (void)setTabTitleArray:(NSArray*)titles iconNormal:(NSArray*)icons iconHighted:(NSArray*)iconHls selectedBgColor:(NSArray*)color;
-(void)setChangeToIndex:(NSInteger)index;
- (void)showRedDotWithIndex:(NSInteger)index;
- (void)hideRedDotWithIndex:(NSInteger)index;
- (void)setCount:(NSInteger)count index:(NSInteger)index;
@end


