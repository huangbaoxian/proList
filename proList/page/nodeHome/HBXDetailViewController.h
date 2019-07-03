//
//  HBXDetailViewController.h
//  proList
//
//  Created by huangbaoxian on 2019/7/2.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXBaseViewController.h"
@class ZJHomdeListModel;
NS_ASSUME_NONNULL_BEGIN

@interface HBXDetailViewController : HBXBaseViewController

- (instancetype)initWithParam:(NSDictionary *)param;
- (void)addModel:(ZJHomdeListModel *)model;

@end

NS_ASSUME_NONNULL_END
