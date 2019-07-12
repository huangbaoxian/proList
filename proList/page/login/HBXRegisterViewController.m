//
//  HBXRegisterViewController.m
//  proList
//
//  Created by huangbaoxian on 2019/7/8.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXRegisterViewController.h"

@interface HBXRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UITextField *accountTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *niChenTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation HBXRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.registerButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *tapGuest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGuest)];
    [self.view addGestureRecognizer:tapGuest];
}

- (void)tapGuest {
    [self.view endEditing:NO];
}


- (void)backButtonClick: (UIButton *)sender {
     [[NSNotificationCenter defaultCenter] postNotificationName:@"back" object:nil];
}

- (void)registerButtonClick:(UIButton *)sender {
    
    if (self.accountTextFiled.text == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入账号"];
        return;
    }
    
    if (self.passwordTextFiled.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    if ([ToolHelper hasAccountWithAccount:self.accountTextFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"账号已注册"];
        return;
    }
    
    
    [SVProgressHUD showWithStatus:@"请求中..."];
    NSString *nichen = self.niChenTextFiled.text;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"token"] = self.accountTextFiled.text;
    if (nichen && nichen.length > 0) {
        dict[@"nickName"] = self.niChenTextFiled.text;
    }
    dict[@"phone"] = self.accountTextFiled.text;
    [[MisManager getInstance] HBXSetValue:dict key:self.accountTextFiled.text];
    

    [ToolHelper registerWithAccount:self.accountTextFiled.text passWord:self.passwordTextFiled.text];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:@"注册成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"success" object:@{@"account": self.accountTextFiled.text}];
    });
    
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
