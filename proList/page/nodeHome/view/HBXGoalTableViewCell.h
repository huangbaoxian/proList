//
//  HBXGoalTableViewCell.h
//  proList
//
//  Created by huangbaoxian on 2019/7/4.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBXGoalModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface HBXGoalTableViewCell : UITableViewCell

- (void)cellHeightWithItem:(HBXGoalModel *)model;

@end

NS_ASSUME_NONNULL_END
