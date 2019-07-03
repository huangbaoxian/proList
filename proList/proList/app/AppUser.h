//
//  AppUser.h
//  proList
//
//  Created by huangbaoxian on 2019/7/1.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppUser : NSObject
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *avatarUrl;
- (void)updateItem:(NSDictionary *)dic ;
@end

NS_ASSUME_NONNULL_END
