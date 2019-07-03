//
//  MySettingViewController.m
//  proList
//
//  Created by huangbaoxian on 2019/7/4.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "MySettingViewController.h"
#import "ZJAvatarSettingViewController.h"
#import "HBXNickSetViewController.h"

@interface MySettingViewController ()

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nickLabel;

@end

@implementation MySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatSubView];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:APPCONTEXT.currentUser.avatarUrl];
    self.headImageView.image = image;
    
    self.nickLabel.text = APPCONTEXT.currentUser.nickName;
    
}

- (void)creatSubView {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, self.view.width - 30, 50)];
    UILabel *titleLabel = [ToolHelper getNormalLabel];
    titleLabel.text = @"头像";
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.view addSubview:headView];
    
    [headView addSubview:titleLabel];
    [headView addSubview:imageView];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView);
        make.leading.equalTo(headView);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView);
        make.trailing.equalTo(headView);
        make.width.height.mas_equalTo(45);
    }];
    imageView.image = [UIImage imageNamed:@"icon-avater-default"];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 22.5;
    UIView *sepLine = [[UIView alloc] init];
    sepLine.backgroundColor = UIColorFromRGB(0xf4f4f4);
    [headView addSubview:sepLine];
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(headView);
        make.height.mas_equalTo(1);
    }];
    self.headImageView = imageView;
    
    UITapGestureRecognizer *tapGuest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClick)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tapGuest];
  
    
    
    UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(15, headView.bottom, self.view.width - 30, 50)];
    [self.view addSubview:nameView];
    
    
    titleLabel = [ToolHelper getNormalLabel];
    UILabel *descLabel = [ToolHelper getNormalLabel];
    [nameView addSubview:titleLabel];
    [nameView addSubview:descLabel];
    titleLabel.text = @"昵称";
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameView);
        make.leading.equalTo(nameView);
    }];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameView);
        make.trailing.equalTo(nameView);
    }];
    descLabel.textAlignment = NSTextAlignmentRight;
    self.nickLabel = descLabel;
    descLabel.text = APPCONTEXT.currentUser.nickName;
    sepLine = [[UIView alloc] init];
    sepLine.backgroundColor = UIColorFromRGB(0xf4f4f4);
    [nameView addSubview:sepLine];
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(nameView);
        make.height.mas_equalTo(1);
    }];
    
    
    tapGuest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nickClick)];
    nameView.userInteractionEnabled = YES;
    [nameView addGestureRecognizer:tapGuest];
    
}

- (void)headClick {
    ZJAvatarSettingViewController *vc = [[ZJAvatarSettingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)nickClick {
    HBXNickSetViewController *vc = [[HBXNickSetViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
