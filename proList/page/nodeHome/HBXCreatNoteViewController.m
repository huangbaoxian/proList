//
//  HBXCreatNoteViewController.m
//  proList
//
//  Created by huangbaoxian on 2019/7/1.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXCreatNoteViewController.h"
#import "GFCalendar.h"
#import "HBXEditNoteViewController.h"


@interface HBXCreatNoteViewController ()
    
@property (nonatomic, strong) UIView *contentView;    
    
@property (nonatomic, copy) NSString *date;
    
@property (nonatomic, strong) UIButton *creatNewButton;

@end

@implementation HBXCreatNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavBar];
    [self setUpView];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    self.date = [formatter stringFromDate:datenow];        
    // Do any additional setup after loading the view.
}
    
- (void)btnClick {
    HBXEditNoteViewController *vc = [[HBXEditNoteViewController alloc] initWithDate:self.date];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)setupNavBar {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:AppFont(18), NSForegroundColorAttributeName:SYS_White_Color}];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage getImageWithColor:AppHTMLColor(@"4bccbc")] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
    
- (void)setUpView {
    [self setupCalendarView];
}
    // 初始化calendarView
- (void)setupCalendarView {
    GFCalendarView *calendarView = [[GFCalendarView alloc] initWithFrameOrigin:CGPointMake(15, 30) width:kScreen_WIDTH-2*15];
    WeakSelf
    calendarView.didSelectDayHandler = ^(NSInteger year, NSInteger month, NSInteger day) {
        self.date = [NSString stringWithFormat:@"%zd-%02zd-%02zd", year, month, day];
        NSLog(@"self.date: %@",self.date);
        [weakSelf btnClick];
    };
    [self.view addSubview:calendarView];
    [self.view addSubview:self.creatNewButton];
    self.creatNewButton.frame = CGRectMake(15, calendarView.bottom + 100,self.view.width - 30, 34);
    self.creatNewButton.layer.masksToBounds = YES;
    self.creatNewButton.layer.cornerRadius = 8;
    
    //    self.calendarView_Height_Constraint.constant = CGRectGetHeight(calendarView.frame);
}
    
- (UIButton *)creatNewButton {
    if (!_creatNewButton) {
        _creatNewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_creatNewButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        [_creatNewButton setTitle:@"开 始 记 录！" forState:UIControlStateNormal];
        _creatNewButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_creatNewButton setBackgroundColor:UIColorFromRGB(0x4bccbc)];
        [_creatNewButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _creatNewButton;
}
    
    

@end
