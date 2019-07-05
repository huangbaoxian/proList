//
//  TabbarViewController.m
//  proList
//
//  Created by huangbaoxian on 2019/6/30.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "TabbarViewController.h"
#import "AppDelegate.h"
#import "ZJTabbar.h"
#import "HBXHisHomeViewController.h"
#import "NoteListViewController.h"
#import "HBXModelListViewController.h"
#import "MyViewController.h"


@interface TabbarViewController ()
@property (nonatomic, strong) ZJTabbar *tabBarView;
@property (nonatomic, strong) NSMutableArray *subviewNaviControllers;

@end

@implementation TabbarViewController

+ (instancetype)tabbarViewController {
    UIViewController *nav = [AppDelegate mainWindow].rootViewController;
    if ([nav isKindOfClass:[UINavigationController class]]) {
        NSArray *array = [(UINavigationController *)nav viewControllers];
        if ([array count] > 0) {
            TabbarViewController *vc = [array objectAtIndex:0];
            if ([vc isKindOfClass:[TabbarViewController class]]) {
                return vc;
            }
        }
    }
    
    return nil;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self _initTabBarView];
    [self _initSubviewController];
    [self changeToIndex:0];
    
}
   
- (void)tabbarViewChange:(NSNotification *)sender {
    if (sender) {
        NSDictionary *getObject = (NSDictionary *)sender.object;
        if (getObject) {
            NSInteger page = [getObject[@"page"] integerValue];
            if (page > 0) {
                [_tabBarView setChangeToIndex:page - 1];
            }
        }
    }
    
}
   
 

- (void)_initTabBarView {
    

        NSArray *itemTitles = nil ;
        itemTitles = @[ @"点滴",@"事件",@"我的"];
        NSArray *itemNormalIcons = @[@"icon-index",@"icon-learn-normal", @"icon-mySet"];
        NSArray *itemHighlightedIcons = @[@"icon-index-selected",@"icon-learn-selected",  @"icon-mySet-selected"];
        NSArray *itemSelectedBgColors = @[[UIColor clearColor], [UIColor clearColor], [UIColor clearColor]];
        //[UIColor clearColor], [UIColor clearColor],
        _tabBarView = [[ZJTabbar alloc] initWithFrame:CGRectMake(0, self.view.height - PHONE_CUSTOM_TABBAR_HEIGHT, SCREEN_WIDTH, PHONE_CUSTOM_TABBAR_HEIGHT)];
        _tabBarView.tabBarDelegate = self;
        
        [_tabBarView setTabTitleArray:itemTitles iconNormal:itemNormalIcons iconHighted:itemHighlightedIcons selectedBgColor:itemSelectedBgColors];
        
        [self.view addSubview:_tabBarView];
        
}
    
    
- (void)_initSubviewController {
    
    _subviewNaviControllers = [NSMutableArray array];

        
    HBXHisHomeViewController *classSell = [HBXHisHomeViewController new];
    RootNavViewController *classSellNav = [[RootNavViewController alloc] initWithRootViewController:classSell];
    [_subviewNaviControllers addObject:classSellNav];
    
    
    HBXModelListViewController *myCourse = [HBXModelListViewController new];
    RootNavViewController *myCourseNav = [[RootNavViewController alloc] initWithRootViewController:myCourse];
    [_subviewNaviControllers addObject:myCourseNav];
    
    
   
    
    MyViewController *me = [[MyViewController alloc] init];
    RootNavViewController *meNav = [[RootNavViewController alloc] initWithRootViewController:me];
    [_subviewNaviControllers addObject:meNav];
    
}
- (BOOL)canChangeToIndex:(NSInteger)index{
    
    return YES;
}
- (void)rsTabBar:(ZJTabbar *)tabBar unSelectedIndex:(NSInteger)index {
    if (index < _subviewNaviControllers.count) {
        UINavigationController *subviewNaviVC = [_subviewNaviControllers objectAtIndex:index];
        subviewNaviVC.view.hidden = YES;
        [subviewNaviVC viewWillDisappear:NO];
        [subviewNaviVC viewDidDisappear:NO];
    }
}
    
- (void)rsTabBar:(ZJTabbar *)tabBar didSelectedIndex:(NSInteger)index {
   
    if (index < _subviewNaviControllers.count) {
        UINavigationController *subviewNaviVC = [_subviewNaviControllers objectAtIndex:index];
        if (subviewNaviVC.view.superview == nil) {
        }
        [self.view addSubview:subviewNaviVC.view];
        [self addChildViewController:subviewNaviVC];
        [self.view bringSubviewToFront:self.tabBarView];
        subviewNaviVC.view.hidden = NO;
        [subviewNaviVC viewWillAppear:NO];
        [subviewNaviVC viewDidAppear:NO];
    }
    
}
    
    
    //- (void)showMessageRedDot {
    //    [_tabBarView showRedDotWithIndex:ETabBarSubviewMy];
    //}
    //- (void)hideMessageRedDot {
    //    [_tabBarView hideRedDotWithIndex:ETabBarSubviewMy];
    //}
    
- (void) changeToIndex:(NSInteger) index
    {
        [_tabBarView setChangeToIndex:index];
    }

    
    
    //- (BOOL)shouldAutorotate
    //{
    //    return NO;
    //}
    //
    //- (UIInterfaceOrientationMask)supportedInterfaceOrientations
    //{
    //    return UIInterfaceOrientationMaskPortrait;
    //}
    //
    //- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation
    //{
    //    return UIInterfaceOrientationPortrait;
    //}
    
    /*
     #pragma mark - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */

@end
