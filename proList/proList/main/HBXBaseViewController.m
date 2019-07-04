//
//  HBXBaseViewController.m
//  proList
//
//  Created by huangbaoxian on 2019/7/2.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXBaseViewController.h"

@interface HBXBaseViewController ()

@property (nonatomic, strong) UIImageView *emptView;
@property (nonatomic, strong) UILabel *emptLabel;


@end

@implementation HBXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavBar];
    NSInteger x = [self.navigationController.viewControllers count];
    
    [SVProgressHUD setMinimumSize:CGSizeMake(100, 100)];
    [SVProgressHUD setMaximumDismissTimeInterval:1.5];
    //    [SVProgressHUD setContainerView:self.view];
    [SVProgressHUD setBackgroundColor:UIColorFromRGBA(0x000000, 0.8)];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    if (x > 1) {
        // 多余一级的时候，再创建返回按钮
        [self setLeftBarButtonItem:[self navigationBackButtonItemWithTarget:self action:@selector(goBack)]];
    }
    
    // Do any additional setup after loading the view.
}
- (void)showEmptViewWithMessage:(NSString *)message {
    
    [self.view addSubview:self.emptView];
    [self.view addSubview:self.emptLabel];
    
    self.emptLabel.width = SCREEN_WIDTH - 40;
    self.emptLabel.height = 42;
    self.emptView.center = self.view.center;
    self.emptView.top = 200;
    self.emptLabel.centerX = self.view.centerX;
    self.emptLabel.top = self.emptView.bottom + 30;
    self.emptLabel.text = message;
    
}

- (void)hideEmptView {
    [self.emptView removeFromSuperview];
    [self.emptLabel removeFromSuperview];
}

- (void)setLeftBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    if (!barButtonItem) {
        if ([self.navigationController.viewControllers count] > 1) {
            self.navigationItem.hidesBackButton = YES;
        }
        self.navigationItem.leftBarButtonItems = nil;
        return;
    }
    
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects: barButtonItem, nil];
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIBarButtonItem *)navigationBackButtonItemWithTarget:(id)target action:(SEL)action
{
    UIImage         *normalImage =  [UIImage imageNamed: @"icon-back"];
    UIImage         *normalImage_hl = nil;//[UIImage imageForKey:@"common_btn_back_hl"];
    UIBarButtonItem *buttonItem = [UIBarButtonItem rsBarButtonItemWithTitle:nil
                                                                      image:normalImage
                                                           heightLightImage:normalImage_hl
                                                               disableImage:nil
                                                                     target:target
                                                                     action:action];
    buttonItem.width = 100;
    
    return buttonItem;
}


- (void)setupNavBar {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:AppFont(18), NSForegroundColorAttributeName:SYS_White_Color}];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage getImageWithColor:AppHTMLColor(@"4bccbc")] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (UIImageView *)emptView {
    if (!_emptView) {
        _emptView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vc_list_empt"]];
        _emptView.size = CGSizeMake(80, 80);
        _emptView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tapClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshClick:)];
//        [_emptView addGestureRecognizer:tapClick];
        
    }
    return _emptView;
}

- (UILabel *)emptLabel {
    if (!_emptLabel) {
        _emptLabel = [[UILabel alloc] init];
        _emptLabel.textAlignment = NSTextAlignmentCenter;
        _emptLabel.textColor = UIColorFromRGB(0x999999);
        _emptLabel.font = [UIFont  systemFontOfSize: 15.0];
        _emptLabel.backgroundColor = [UIColor clearColor];
        _emptLabel.userInteractionEnabled = YES;
        
    }
    return _emptLabel;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
