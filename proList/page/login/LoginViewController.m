//
//  LoginViewController.m
//  proList
//
//  Created by huangbaoxian on 2019/7/4.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *accountFiled;
@property (weak, nonatomic) IBOutlet UITextField *passWordFiled;
@property (weak, nonatomic) IBOutlet UITextField *nichenFiled;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginClick:(UIButton *)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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

    
    BOOL isSucces = [ToolHelper loginWithAccount:self.accountFiled.text passWord:self.passWordFiled.text];
    
    if (isSucces) {
        NSDictionary *dict = [[MisManager getInstance] HBXGetValueForKey:self.accountFiled.text];
        if (!dict) {
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"phone"] = self.accountFiled.text;
            param[@"nickname"] = self.nichenFiled.text ?: @"";
            [[MisManager getInstance] HBXSetValue:param key:self.accountFiled.text];
        }
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [APPCONTEXT loginSuccessToken:self.accountFiled.text];
            [AppNavigator openMainViewController];
        });
    }else {
         [SVProgressHUD showErrorWithStatus:@"登录失败，请查看密码重试"];
    }
    
}
@end
