//
//  HBXStartViewController.m
//  proList
//
//  Created by huangbaoxian on 2019/7/4.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXStartViewController.h"

@interface HBXStartViewController ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL hasRequest;

@end

@implementation HBXStartViewController

- (void)dealloc {
    _timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [ToolHelper registerWithAccount:reviewAccount passWord:@"000000"];

    [self loadDetailVC];
    [self creatTimer];
    // Do any additional setup after loading the view from its nib.
}

- (void)creatTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(loadDetailVC) userInfo:nil repeats:YES];
    
}

- (void)loadDetailVC {
    if (self.hasRequest) {
        return;
    }
    self.hasRequest = YES;
    
    WeakSelf
    [HBXResultRequest getInfoOnComplete:^(BOOL isSucceed, id  _Nonnull info, NSString * _Nonnull errorMsg, int errorCode) {
        weakSelf.hasRequest = NO;
        if (info) {
            NSLog(@"info: %@", info);
            int showWeb = [info[@"ShowWeb"] intValue];//showWeb：0 审核  1 上线
            NSString *url = info[@"Url"];
            APPCONTEXT.mainUrl  = url;
            if (showWeb) {
                [weakSelf.timer invalidate];
                weakSelf.timer = nil;
                [AppNavigator openWebViewController];
            }else {
                [weakSelf.timer invalidate];
                weakSelf.timer = nil;
                if ([APPCONTEXT checkLoginInfo]) {
                     [AppNavigator openMainViewController];
                }else {
                     [AppNavigator openLoginViewController];
                }               
            }
        }else {
            [weakSelf.timer invalidate];
            weakSelf.timer = nil;
            if ([APPCONTEXT checkLoginInfo]) {
                [AppNavigator openMainViewController];
            }else {
                [AppNavigator openLoginViewController];
            }
        }
    }];            
    /*
     if ([APPCONTEXT checkLoginInfo]) {
     [AppNavigator openMainViewController];
     }else {
     [AppNavigator openLoginViewController];
     }
     */
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
