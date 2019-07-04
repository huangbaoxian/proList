//
//  AppContext.m
//  proList
//
//  Created by huangbaoxian on 2019/7/1.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "AppContext.h"

@implementation AppContext

static AppContext *_appContext = nil;

+ (AppContext *)getInstance {
    @synchronized (self) {
        if (!_appContext) {
            _appContext = [[self alloc] init];
        }
        return _appContext;
    }
}
- (instancetype)init{
    if (self = [super init]) {
         _config = [[AppConfig alloc] init];
        
        NSString *token  = [[MisManager getInstance] HBXGetValueForKey:@"token"];
        if (token && token.length > 0) {
            _token = token;
        }
        
    }
    return self;
}

- (void)loginSuccessToken:(NSString *)token {
    [[MisManager getInstance] HBXSetValue:token key:@"token"];
    self.token = token;
    
    NSDictionary *dict = [[MisManager getInstance] HBXGetValueForKey:self.token];
    AppUser *appuser=  [[AppUser alloc] init];
    if (dict) {
        [appuser updateItem:dict];
    }
    _currentUser = appuser;
}

- (void)saveInfo {
    NSDictionary *dict = [self.currentUser mj_keyValues];
    [[MisManager getInstance] HBXSetValue:dict key:self.token];
}

- (void)logout {
    self.currentUser = [[AppUser alloc] init];
    [[MisManager getInstance] HBXSetValue:@"" key:@"token"];
    [AppNavigator openLoginViewController];
}

- (BOOL)checkLoginInfo{
    if (self.token && self.token.length > 0) {
        return YES;
    }
    return NO;
}
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] init];
        _manager.requestSerializer.timeoutInterval = 10;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
//        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
//        response.removesKeysWithNullValues = YES;
//        _manager.responseSerializer = response;
    }
    return _manager;
}
@end
