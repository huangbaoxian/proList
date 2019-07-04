//
//  HBXNoteDetailCell.m
//  proList
//
//  Created by huangbaoxian on 2019/7/2.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXNoteDetailCell.h"
#import "ZJHomdeListModel.h"

@interface HBXNoteDetailCell ()

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *contentImage;

@end

@implementation HBXNoteDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSubView];
    }
    return self;
}

- (void)cellHeightWithItem:(ZJHomdeListModel *)model {
    self.contentLabel.hidden = YES;
    self.contentImage.hidden = YES;
    switch (model.type) {
        case HBXEditTypeTitle:
            self.contentLabel.hidden = NO;
           
            break;
        case HBXEditTypeContent:
            self.contentLabel.hidden = NO;
            self.contentLabel.text = model.content;
            break;
        case HBXEditTypeImage: {
                self.contentImage.hidden = NO;
                [ToolHelper setImageWithImageView:self.contentImage url:model.content];
            }
            break;            
        default:
            break;
    }
}

- (void)creatSubView {
    [self.contentView addSubview:self.container];
    [self.container addSubview:self.contentLabel];
    [self.container addSubview:self.contentImage];
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(15);
        make.trailing.equalTo(self.contentView).offset(-15);
        make.top.bottom.equalTo(self.contentView);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self.container);
    }];
    
    [self.contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.top.equalTo(self.container);
    }];
    self.contentImage.layer.masksToBounds = YES;
    self.contentImage.layer.cornerRadius = 8;
}

- (UIImageView *)contentImage {
    if (!_contentImage) {
        _contentImage = [[UIImageView alloc] init];
        _contentImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _contentImage;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:14.0];
        _contentLabel.textColor = UIColorFromRGB(0x333333);
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] init];
    }
    return _container;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
