//
//  LoginViewController.m
//  proList
//
//  Created by huangbaoxian on 2019/7/4.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "LoginViewController.h"
#import "HBXRegisterViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)registerClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *accountFiled;
@property (weak, nonatomic) IBOutlet UITextField *passWordFiled;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)loginClick:(UIButton *)sender;
@property (nonatomic, strong) HBXRegisterViewController *registerVC;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerSuccess:) name:@"success" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(back) name:@"back" object:nil];
    
    UITapGestureRecognizer *tapGuest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGuest)];
    [self.view addGestureRecognizer:tapGuest];
    
}

- (void)tapGuest {
    [self.view endEditing:NO];
}

- (void)back {
    [self.registerVC.view removeFromSuperview];
    [self.registerVC removeFromParentViewController];
    
}




- (void)registerSuccess:(NSNotification *)sender {
    if (sender.object) {
        NSDictionary *dict = sender.object;
        NSString * account = dict[@"account"];
        
        if (account) {            
            NSDictionary *dict = [[MisManager getInstance] HBXGetValueForKey:self.accountFiled.text];
            if (!dict) {
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                param[@"phone"] = self.accountFiled.text;
                if ([self.accountFiled.text isEqualToString:reviewAccount]) {
                    param[@"avatarUrl"] = @"https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1562306081&di=69932264a345fea7ecf8b1854309d38d&src=http://pic148.nipic.com/file/20171207/7791170_202333876000_2.jpg";
                }
                param[@"nickname"] = @"随风的风";
                [[MisManager getInstance] HBXSetValue:param key:self.accountFiled.text];
            }
            
            [APPCONTEXT loginSuccessToken:account];
            [AppNavigator openMainViewController];
        }
    }
    
}


- (IBAction)loginClick:(UIButton *)sender {
    
    if (self.titleLabel.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入账号"];
        return;
    }
    
    if (self.passWordFiled.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    if (![ToolHelper hasAccountWithAccount:self.accountFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"账号未注册，请注册"];
        return;
    }

    
    BOOL isSucces = [ToolHelper loginWithAccount:self.accountFiled.text passWord:self.passWordFiled.text];
    [SVProgressHUD showWithStatus:@"请求中..."];
    
    if (isSucces) {
        NSDictionary *dict = [[MisManager getInstance] HBXGetValueForKey:self.accountFiled.text];
        if (!dict) {
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"phone"] = self.accountFiled.text;
            if ([self.accountFiled.text isEqualToString:reviewAccount]) {
                param[@"avatarUrl"] = @"https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1562306081&di=69932264a345fea7ecf8b1854309d38d&src=http://pic148.nipic.com/file/20171207/7791170_202333876000_2.jpg";
            }
            param[@"nickname"] = @"随风的风";
            [[MisManager getInstance] HBXSetValue:param key:self.accountFiled.text];
        }
                
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [APPCONTEXT loginSuccessToken:self.accountFiled.text];
            [AppNavigator openMainViewController];
        });
    }else {
         [SVProgressHUD showErrorWithStatus:@"登录失败，请查看密码重试"];
    }
    
}
- (IBAction)registerClick:(id)sender {
    self.registerVC = [[HBXRegisterViewController alloc] init];
    [self addChildViewController:self.registerVC];
    [self.view addSubview:self.registerVC.view];
}
@end
