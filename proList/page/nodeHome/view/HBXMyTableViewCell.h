//
//  HBXMyTableViewCell.h
//  proList
//
//  Created by huangbaoxian on 2019/7/1.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZJMySettingItem;

@interface HBXMyTableViewCell : UITableViewCell

- (void)cellHeightWithItem:(ZJMySettingItem *)item;
    
@end

NS_ASSUME_NONNULL_END
