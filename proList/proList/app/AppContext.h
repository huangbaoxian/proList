//
//  AppContext.h
//  proList
//
//  Created by huangbaoxian on 2019/7/1.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppContext : NSObject

@property (nonatomic, strong) AppUser *currentUser;

- (BOOL)checkLoginInfo;
- (void)logout;
    
+ (AppContext *)getInstance;
@end

NS_ASSUME_NONNULL_END