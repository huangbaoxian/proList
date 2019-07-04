//
//  HBXNickSetViewController.m
//  proList
//
//  Created by huangbaoxian on 2019/7/4.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXNickSetViewController.h"

@interface HBXNickSetViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *nickTextField;
@end

@implementation HBXNickSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改昵称";
    [self buildViews];
}
- (void)buildViews{
    [self.view setBackgroundColor:UIColorFromRGB(0xf8f8f8)];
    self.nickTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 44)];
    self.nickTextField.placeholder = APPCONTEXT.currentUser.nickName;
    self.nickTextField.delegate = self;
    self.nickTextField.backgroundColor = [UIColor whiteColor];
    [self.nickTextField setFont:[UIFont systemFontOfSize:15.f]];
    [self.nickTextField setTextColor:[UIColor blackColor]];
    [self.view addSubview:self.nickTextField];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 44)];
    [leftView setBackgroundColor:[UIColor clearColor]];
    self.nickTextField.leftView = leftView;
    self.nickTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.nickTextField becomeFirstResponder];
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nickTextField.left, self.nickTextField.bottom + 10, 200, 14)];
    [infoLabel setFont:[UIFont systemFontOfSize:13.f]];
    [infoLabel setTextColor:UIColorFromRGB(0x999999)];
    [infoLabel setText:@"昵称最多20个字"];
    [infoLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:infoLabel];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xff6d41)] forState:UIControlStateNormal];
    [saveBtn setFrame:CGRectMake(self.nickTextField.left, infoLabel.bottom + 15, self.nickTextField.width, 40)];
    [saveBtn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 3;
    [saveBtn addTarget:self action:@selector(saveBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)saveBtnClicked:(UIButton *)btn{
    if (self.nickTextField.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入昵称"];
        return;
    }
    if ([self.nickTextField.text isEqualToString:APPCONTEXT.currentUser.nickName ]) {
        [SVProgressHUD showInfoWithStatus:@"与原昵称相同"];
        return;
    }
    APPCONTEXT.currentUser.nickName = self.nickTextField.text;
    [APPCONTEXT saveInfo];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - uitextfiled delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length > 20 && string.length > 0) {
        return NO;
    }
    return YES;
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
