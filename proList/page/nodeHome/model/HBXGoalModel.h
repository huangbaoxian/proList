//
//  HBXGoalModel.h
//  proList
//
//  Created by huangbaoxian on 2019/7/4.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "ZJBaseItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface HBXGoalModel : ZJBaseItem

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;

@property (nonatomic, strong) NSString *label;

@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) NSString *creatTime;
@property (nonatomic, strong) NSString *content;

@end

NS_ASSUME_NONNULL_END
