//
//  HBXMyTableViewCell.m
//  proList
//
//  Created by huangbaoxian on 2019/7/1.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXMyTableViewCell.h"
#import "ZJMySettingItem.h"

@interface HBXMyTableViewCell ()

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *desc;
@property (nonatomic, strong) UIImageView *arrowView;


@end

@implementation HBXMyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSubView];
    }
    return self;
}

- (void)creatSubView {
    [self.contentView addSubview:self.container];
    [self.container addSubview:self.headView];
    [self.container addSubview:self.title];
    [self.container addSubview:self.desc];
    [self.container addSubview:self.arrowView];
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(30);
        make.trailing.equalTo(self.contentView).offset(-30);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.container);
        make.leading.equalTo(self.container);
        make.width.height.mas_equalTo(30);
    }];
    
 
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.container);
        make.leading.equalTo(self.headView.mas_trailing).offset(15);
    }];
    
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.container);
        make.trailing.equalTo(self.container);
    }];
    
    [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.container);
        make.trailing.equalTo(self.arrowView.mas_leading).offset(15);
    }];
    
    
    UIView *sepLine = [[UIView alloc] init];
    sepLine.backgroundColor = UIColorFromRGB(0xf4f4f4);
    [self.contentView addSubview:sepLine];
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
    
- (void)cellHeightWithItem:(ZJMySettingItem *)item {
    [self.headView sd_setImageWithURL:[NSURL URLWithString:item.iconString] ];
    self.title.text = item.keyString;
    
}

- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] init];
    }
    return _container;
}
- (UIImageView *)arrowView {
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-arrow-right"]];
        _arrowView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowView;
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

- (UILabel *)desc {
    if (!_desc) {
        _desc = [[UILabel alloc] init];
        _desc.font = [UIFont systemFontOfSize:14.0];
        _desc.textColor = UIColorFromRGB(0x333333);
    }
    return _desc;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
