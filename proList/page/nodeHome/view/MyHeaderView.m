//
//  MyHeaderView.m
//  proList
//
//  Created by huangbaoxian on 2019/7/1.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "MyHeaderView.h"

@interface MyHeaderView ()
    
@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UILabel *nickNameLabel;

@end

@implementation MyHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self creatSubView];
    }
    return self;
}

- (void)updateHeadview {
//    UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:APPCONTEXT.currentUser.avatarUrl];
//    if (!image) {
//        image = [UIImage imageNamed:@"icon-avater-default"];
//    }
//    self.headerView.image = image;
    [ToolHelper setImageWithImageView:self.headerView url:APPCONTEXT.currentUser.avatarUrl defaultImage:[UIImage imageNamed:@"icon-avater-default"]];
    self.nickNameLabel.text = APPCONTEXT.currentUser.nickName;    
}

- (void)creatSubView {
    
    [self addSubview:self.headerView];
    [self addSubview:self.nickNameLabel];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.width.height.mas_equalTo(90);
        make.top.equalTo(self).offset(15);
        make.bottom.equalTo(self).offset(-15);
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self.headerView.mas_trailing).offset(15);
    }];
    
    self.headerView.layer.masksToBounds = YES;
    self.headerView.layer.cornerRadius = 45;

    self.headerView.image = [UIImage imageNamed:@"icon-avater-default"];
    self.nickNameLabel.text = @"随风的风";
}
    
- (UIImageView *)headerView {
    if (!_headerView) {
        _headerView = [[UIImageView alloc] init];
    }
    return _headerView;
}

- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = [UIFont systemFontOfSize:14.0];
        _nickNameLabel.textColor = UIColorFromRGB(0x333333);
    }
    return _nickNameLabel;
}
    
    
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
