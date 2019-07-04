//
//  HBXFeedViewController.m
//  proList
//
//  Created by huangbaoxian on 2019/7/4.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXFeedViewController.h"
#define KTEXTVIEWDEFAULT @"简要描述您要反馈的问题和意见"

@interface HBXFeedViewController ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *textCount;
@property (nonatomic, strong) UILabel *maxCount;
@end

@implementation HBXFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"意见反馈";
    [self buildViews];
}
- (void)buildViews{
    self.view.backgroundColor = UIColorFromRGB(0xf8f8f8);
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(15,  10, SCREEN_WIDTH - 30, 150)];
    [self.textView setFont:[UIFont systemFontOfSize:15.f]];
    [self.textView setTextColor:UIColorFromRGB(0x333333)];
    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textView];
    
    self.maxCount = [[UILabel alloc] init];
    [self.maxCount setFont:[UIFont systemFontOfSize:13.f]];
    [self.maxCount setTextColor:UIColorFromRGB(0x999999)];
    [self.maxCount setText:@"/200"];
    [self.maxCount sizeToFit];
    self.maxCount.right = SCREEN_WIDTH - 20;
    self.maxCount.bottom = self.textView.bottom - 5;
    [self.view addSubview:self.maxCount];
    self.textCount = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.textCount setFont:self.maxCount.font];
    [self.textCount setTextColor:self.maxCount.textColor];
    [self.view addSubview:self.textCount];
    self.textCount.text = @"0";
    self.textCount.textAlignment = NSTextAlignmentRight;
    self.textCount.height = self.maxCount.height;
    self.textCount.width = 100;
    self.textCount.bottom = self.maxCount.bottom;
    self.textCount.right = self.maxCount.left;
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xff6d41)] forState:UIControlStateNormal];
    [submitBtn setFrame:CGRectMake(15, self.textView.bottom + 15, SCREEN_WIDTH - 30, 44)];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 3;
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:submitBtn];
    [submitBtn addTarget:self action:@selector(submitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.textView becomeFirstResponder];
    
    self.textView.text = KTEXTVIEWDEFAULT;
    self.textView.textColor = UIColorFromRGB(0x999999);
}
- (void)submitBtnClicked:(UIButton *)btn{
    if (self.textView.text.length > 200) {
        [SVProgressHUD showInfoWithStatus:@"最多200字"];
        return;
    }
    if (self.textView.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入您的意见~"];
        return;
    }
    
    [SVProgressHUD showInfoWithStatus:@"亲，我们已收到您的反馈，感谢你的提交"];
    [self.navigationController popViewControllerAnimated:YES ];
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setValue:self.textView.text forKey:@"content"];
//    BaseRequest *request = [[BaseRequest alloc] init];
//    [request sendPostRequestWithParam:param method:@"user/advice" onComplete:^(BOOL isSucceed, id info, NSString *errorMsg) {
//        if (isSucceed) {
//            [SVProgressHUD showSuccessWithStatus:@"提交成功"];
//            [AppNavigator popViewControllerAnimated:YES];
//        }
//    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - textview delegate
-(void)textViewDidChange:(UITextView *)textView{
    NSUInteger length = textView.text.length;
    self.textCount.text = [NSString stringWithFormat:@"%ld",length];
    if (length > 200) {
        self.textCount.textColor = [UIColor redColor];
    }else{
        self.textCount.textColor = self.maxCount.textColor;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:KTEXTVIEWDEFAULT]) {
        textView.text = @"";
        self.textView.textColor = UIColorFromRGB(0x333333);
    }
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
