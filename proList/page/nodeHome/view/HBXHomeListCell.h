//
//  HBXHomeListCell.h
//  proList
//
//  Created by huangbaoxian on 2019/7/1.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZJHomdeListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HBXHomeListCell : UITableViewCell
    - (void)cellHeightWithItem:(ZJHomdeListModel *)model;
@end

NS_ASSUME_NONNULL_END
