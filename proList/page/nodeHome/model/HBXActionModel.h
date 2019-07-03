//
//  HBXActionModel.h
//  proList
//
//  Created by huangbaoxian on 2019/7/3.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBXActionModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *imageSel;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) NSInteger index;


@end

NS_ASSUME_NONNULL_END
