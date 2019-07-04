//
//  AppConfig.h
//  aizongjie
//
//  Created by yang wang on 2018/4/8.
//  Copyright © 2018年 wennzg. All rights reserved.
//

#import <Foundation/Foundation.h>



#define KOnlineConfigAPI    @"http://appid.201888888888.com/"
#define KTestingConfigAPI   @"http://appid.201888888888.com/"
//#define KTestingConfigAPI   @"192.168.31.246:8088/"


#ifdef AIZONGJIETJ
#define KOnlineConfigH5    @"http://appid.201888888888.com/"
#define KTestingConfigH5    @"http://appid.201888888888.com/"
#define KOnlineNormalH5Url @"http://appid.201888888888.com/"
#define KTestNormalH5Url @"http://appid.201888888888.com/"
#else
#define KOnlineConfigH5    @"http://appid.201888888888.com/"
#define KTestingConfigH5    @"http://appid.201888888888.com/"
#define KOnlineNormalH5Url @"http://appid.201888888888.com/"
#define KTestNormalH5Url @"http://appid.201888888888.com/"
#endif




@interface AppConfig : NSObject
@property (nonatomic, copy) NSString *mApiUrl;
@property (nonatomic, copy) NSString *mH5Url;
@property (nonatomic, copy) NSString *normalH5Url;


#ifdef DEBUG
@property (nonatomic, assign) BOOL isOnlineConfigAPI;

/**
 * @return YES: online, NO: Testing
 */
- (BOOL)switchConfigAPI;
#endif


@end
