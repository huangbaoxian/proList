//
//  HBXGoalTableViewCell.m
//  proList
//
//  Created by huangbaoxian on 2019/7/4.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXGoalTableViewCell.h"

@interface HBXGoalTableViewCell ()

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *creatTime;
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UILabel *showLabel;

@end

@implementation HBXGoalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSubView];
    }
    return self;
}

- (void)creatSubView {
    [self.contentView addSubview:self.container];
    
    [self.container addSubview:self.headView];
    [self.container addSubview:self.time];
    [self.container addSubview:self.title];
    [self.container addSubview:self.creatTime];
    [self.container addSubview:self.showLabel];
    [self.contentView addSubview:self.content];

    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(30);
        make.trailing.equalTo(self.contentView).offset(-30);
        make.top.equalTo(self.contentView).offset(10);
        make.height.mas_equalTo(60);
    }];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.container);
        make.leading.equalTo(self.container);
        make.width.height.mas_equalTo(50);
    }];
    
    self.headView.layer.masksToBounds = YES;
    self.headView.layer.cornerRadius = 25;
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.container).offset(-15);
        make.leading.equalTo(self.headView.mas_trailing).offset(15);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.container).offset(5);
        make.leading.equalTo(self.headView.mas_trailing).offset(15);
    }];
    
    [self.creatTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.container).offset(5);
        make.trailing.equalTo(self.container);
    }];
    
    [self.showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.container).offset(-15);
        make.trailing.equalTo(self.container);
    }];
    
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(30);
        make.trailing.equalTo(self.contentView).offset(-30);
        make.top.equalTo(self.container.mas_bottom);
        make.bottom.equalTo(self.contentView);
    }];
    
    UIView *sepline  = [[UIView alloc] init];
    sepline.backgroundColor = UIColorFromRGB(0xf4f4f4);
    [self.contentView addSubview:sepline];
    [sepline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];

    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)cellHeightWithItem:(HBXGoalModel *)model {
    self.headView.image = [UIImage imageNamed:model.image];
    self.title.text = model.title;
    self.time.text = model.time;
    self.creatTime.text = model.creatTime;
    self.content.text = model.content;
    self.showLabel.text = model.label;
    
}

- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] init];
    }
    return _container;
}

- (UIImageView *)headView {
    if (!_headView) {
        _headView = [[UIImageView alloc] init];
        _headView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _headView;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:14.0];
        _title.textColor = UIColorFromRGB(0x333333);
    }
    return _title;
}

- (UILabel *)showLabel {
    if (!_showLabel) {
        _showLabel = [[UILabel alloc] init];
        _showLabel.font = [UIFont systemFontOfSize:14.0];
        _showLabel.textColor = UIColorFromRGB(0x333333);
    }
    return _showLabel;
}

- (UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.font = [UIFont systemFontOfSize:14.0];
        _time.textColor = UIColorFromRGB(0x333333);
    }
    return _time;
}

- (UILabel *)creatTime {
    if (!_creatTime) {
        _creatTime = [[UILabel alloc] init];
        _creatTime.font = [UIFont systemFontOfSize:14.0];
        _creatTime.textColor = UIColorFromRGB(0x333333);
    }
    return _creatTime;
}

- (UILabel *)content {
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.font = [UIFont systemFontOfSize:14.0];
        _content.textColor = UIColorFromRGB(0x333333);
    }
    return _content;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
