//
//  AppConfig.m
//  aizongjie
//
//  Created by yang wang on 2018/4/8.
//  Copyright © 2018年 wennzg. All rights reserved.
//

#import "AppConfig.h"
#import <PINCache/PINCache.h>


@implementation AppConfig
- (instancetype)init{
    if(self = [super init]){
        /*
#ifdef DEBUG
        if ([[MisManager getInstance] HBXGetValueForKey:kSavedOnlineConfigApI]) {
            self.mApiUrl = [[PINCache sharedCache] objectForKey:kSavedOnlineConfigApI];
        } else {
            self.isOnlineConfigAPI = NO;
            self.mApiUrl = KTestingConfigAPI;
        }
        if ([[PINCache sharedCache] objectForKey:kSavedOnlineConfigH5]) {
            self.mH5Url = [[PINCache sharedCache] objectForKey:kSavedOnlineConfigH5];
            self.normalH5Url = KOnlineNormalH5Url;
        } else {
            self.isOnlineConfigAPI = NO;
            self.mH5Url = KTestingConfigH5;
            self.normalH5Url = KTestNormalH5Url;
        }
#else
         */
        
        self.mApiUrl = KOnlineConfigAPI;
        self.mH5Url = KOnlineConfigH5;
        self.normalH5Url = KOnlineNormalH5Url;
//#endif
    }
    return self;
}

#ifdef DEBUG
- (BOOL)switchConfigAPI {
    _isOnlineConfigAPI = !_isOnlineConfigAPI;
    
    if (_isOnlineConfigAPI) {
        self.mApiUrl = KOnlineConfigAPI;
        self.mH5Url = KOnlineConfigH5;
        self.normalH5Url = KOnlineNormalH5Url;
    } else {
        self.mApiUrl = KTestingConfigAPI;
        self.mH5Url = KTestingConfigH5;
        self.normalH5Url = KTestNormalH5Url;
    }
//    [[PINCache sharedCache] setObject:self.mApiUrl forKey:kSavedOnlineConfigApI];
//    [[PINCache sharedCache] setObject:self.mH5Url forKey:kSavedOnlineConfigH5];
    return _isOnlineConfigAPI;
}
- (BOOL)isOnlineConfigAPI{
    if ([self.mApiUrl isEqualToString:KOnlineConfigAPI]) {
        _isOnlineConfigAPI = YES;
    }else{
        _isOnlineConfigAPI = NO;
    }
    return _isOnlineConfigAPI;
}
#endif

@end
