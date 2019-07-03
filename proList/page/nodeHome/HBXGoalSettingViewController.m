//
//  HBXGoalSettingViewController.m
//  proList
//
//  Created by huangbaoxian on 2019/7/3.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXGoalSettingViewController.h"
#import "HBXActionModel.h"

@interface HBXGoalSettingViewController ()

@property (nonatomic, strong) HBXActionModel *param;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) UIButton *creatNewButton;
@property (nonatomic, strong) UIBarButtonItem *rightBtnItem;
@property (nonatomic, strong) NSString *labelStr;
@property (nonatomic, strong) UITextField *textFiled;

@end

@implementation HBXGoalSettingViewController

- (instancetype)initWithModel:(HBXActionModel *)model {
    if (self = [super init]) {
        _param = model;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"创建目标";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatSubView];
    self.navigationItem.rightBarButtonItem = self.rightBtnItem;
    self.labelStr = @"今天";
    // Do any additional setup after loading the view.
}

- (void)creat {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    

    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    dict[@"creatTime"] = currentTimeString;
    dict[@"title"] = self.param.name;
    dict[@"image"] = self.param.imageSel;
    dict[@"label"] = self.labelStr;
    dict[@"time"] = self.param.time;
    if (self.textFiled.text.length > 0) {
        dict[@"content"] = self.textFiled.text;
    }
    
    [ToolHelper saveModel:dict];
    [self.navigationController popToRootViewControllerAnimated:YES];    
}


- (void)creatSubView {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 80)];
    [self.view addSubview:headView];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:self.param.imageSel];
    [headView addSubview:imageView];
    
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont systemFontOfSize:14.0];
    title.textColor = UIColorFromRGB(0x333333);
    [headView addSubview:title];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView);
        make.leading.equalTo(headView).offset(30);
        make.width.height.mas_equalTo(50);
    }];
    
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView);
        make.leading.equalTo(imageView.mas_trailing).offset(10);
    }];
    
    UIView *sepLine = [[UIView alloc] init];
    sepLine.backgroundColor = UIColorFromRGB(0xf4f4f4);
    [headView addSubview:sepLine];
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(headView);
        make.height.mas_equalTo(1);
    }];
    
    title.text = self.param.name;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 25;
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, headView.bottom + 15, SCREEN_WIDTH, 54)];
    [self.view addSubview:containerView];
    
    
    sepLine = [[UIView alloc] init];
    sepLine.backgroundColor = UIColorFromRGB(0xf4f4f4);
    [containerView addSubview:sepLine];
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(containerView);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"今天" forState:UIControlStateNormal];
    [button1 setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [button1 setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateSelected];
    [button1 setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xff6d41)] forState:UIControlStateSelected];
    [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
     button1.tag = 10000;
    [button1 setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xf4f4f4)] forState:UIControlStateNormal];
    [containerView addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"一周" forState:UIControlStateNormal];
    [button2 setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [button2 setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateSelected];
    [button2 setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xff6d41)] forState:UIControlStateSelected];
    [button2 setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xf4f4f4)] forState:UIControlStateNormal];
    button2.tag = 10001;
    [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"一月" forState:UIControlStateNormal];
    [button3 setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [button3 setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateSelected];
    [button3 setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xff6d41)] forState:UIControlStateSelected];
    [button3 setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xf4f4f4)] forState:UIControlStateNormal];
    button3.tag = 10002;
    [button3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:button3];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button4 setTitle:@"每天" forState:UIControlStateNormal];
    [button4 setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [button4 setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateSelected];
    [button4 setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xff6d41)] forState:UIControlStateSelected];
    [button4 setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xf4f4f4)] forState:UIControlStateNormal];
    button4.tag = 10003;
    [button4 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:button4];
    
    CGFloat space = 10;
    CGFloat buttonWidth = (self.view.width - 60 - 30)/4;
    
    button1.titleLabel.font = [UIFont systemFontOfSize:15.0];
    button2.titleLabel.font = [UIFont systemFontOfSize:15.0];

    button3.titleLabel.font = [UIFont systemFontOfSize:15.0];
    button4.titleLabel.font = [UIFont systemFontOfSize:15.0];
    button1.frame = CGRectMake(30, 10, buttonWidth, 34);
    button2.frame = CGRectMake(30 + (buttonWidth + space) * 1, 10, buttonWidth, 34);
    button3.frame = CGRectMake(30 + (buttonWidth + space) * 2, 10, buttonWidth, 34);
    button4.frame = CGRectMake(30 + (buttonWidth + space) * 3, 10, buttonWidth, 34);
    button1.layer.masksToBounds = YES;
    button1.layer.cornerRadius = 17;
    button2.layer.masksToBounds = YES;
    button2.layer.cornerRadius = 17;
    button3.layer.masksToBounds = YES;
    button3.layer.cornerRadius = 17;
    button4.layer.masksToBounds = YES;
    button4.layer.cornerRadius = 17;
    
    
    [self.buttonArray addObject:button1];
    [self.buttonArray addObject:button2];
    [self.buttonArray addObject:button3];
    [self.buttonArray addObject:button4];
    
    
    
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, containerView.bottom + 10, SCREEN_WIDTH, 70)];
    [self.view addSubview:inputView];
    
    UILabel *desc = [[UILabel alloc] init];
    desc.text = @"留言";
    desc.font = [UIFont systemFontOfSize:14.0];
    desc.textColor = UIColorFromRGB(0x333333);
    [inputView addSubview:desc];
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(inputView).offset(30);
        make.top.equalTo(inputView);
        make.trailing.equalTo(inputView).offset(-30);
    }];
    
    UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(30, 25, self.view.width - 60, 45)];
    textFiled.placeholder = @"自己想说点什么";
    textFiled.font = [UIFont systemFontOfSize:15.0];
    textFiled.textColor = UIColorFromRGB(0x333333);
    textFiled.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 10)];
    textFiled.leftViewMode = UITextFieldViewModeAlways;
    textFiled.layer.borderWidth = 1;
    textFiled.layer.borderColor = UIColorFromRGB(0xf4f4f4).CGColor;
    textFiled.layer.masksToBounds = YES;
    textFiled.layer.cornerRadius = 8;
    [inputView addSubview:textFiled];
    self.textFiled = textFiled;
    

}
- (void)buttonClick:(UIButton *)sender  {
    for (UIButton *btn in self.buttonArray) {
        if ([btn isEqual:sender]) {
            btn.selected = YES;
            self.labelStr = btn.titleLabel.text;
        }else {
            btn.selected = NO;
        }
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

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
}

- (UIBarButtonItem *)rightBtnItem {
    if (!_rightBtnItem) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"保存" forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 50, 30);
        [btn addTarget:self action:@selector(creat) forControlEvents:UIControlEventTouchUpInside];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    return _rightBtnItem;
}


@end
