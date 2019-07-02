//
//  HBXNoteDetailCell.h
//  proList
//
//  Created by huangbaoxian on 2019/7/2.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZJHomdeListModel;

@interface HBXNoteDetailCell : UITableViewCell

- (void)cellHeightWithItem:(ZJHomdeListModel *)model;

@end

NS_ASSUME_NONNULL_END
