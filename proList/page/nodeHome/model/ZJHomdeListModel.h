//
//  ZJHomdeListModel.h
//  proList
//
//  Created by huangbaoxian on 2019/7/1.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJHomdeListModel : NSObject
    
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) HBXEditType type;
@property (nonatomic, assign) CGFloat imageHeight;
@property (nonatomic, assign) CGFloat imageWidth;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSArray *list;


@end

NS_ASSUME_NONNULL_END
