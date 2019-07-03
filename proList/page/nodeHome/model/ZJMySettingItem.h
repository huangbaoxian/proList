//
//  ZJMySettingItem.h
//  proList
//
//  Created by huangbaoxian on 2019/7/1.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^ItemSelectedBlock)(id param);


NS_ASSUME_NONNULL_BEGIN

@interface ZJMySettingItem : NSObject
    
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) BOOL isHideArrow;
@property (nonatomic, strong) NSString *iconString;
@property (nonatomic, strong) NSString *selectIconUrl;
@property (nonatomic, strong) NSString *keyString;
@property (nonatomic, strong) NSString *valueString;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) int type;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL  isLast;
@property (nonatomic, strong) NSAttributedString *attribute;

@property (nonatomic, copy)  ItemSelectedBlock selectedBlock;

+ (ZJMySettingItem *)itemWithDict:(NSDictionary *)param;

@end

NS_ASSUME_NONNULL_END
