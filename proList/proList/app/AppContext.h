//
//  AppContext.h
//  proList
//
//  Created by huangbaoxian on 2019/7/1.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUser.h"
#import "AppConfig.h"
#import <AFNetworking/AFHTTPSessionManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppContext : NSObject

@property (nonatomic, strong) AppUser *currentUser;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, readonly) AppConfig * config;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSString *mainUrl;

- (BOOL)checkLoginInfo;
- (void)logout;
    
+ (AppContext *)getInstance;
- (void)saveInfo;
- (void)loginSuccessToken:(NSString *)token;


@end

NS_ASSUME_NONNULL_END
