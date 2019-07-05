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
        
        NSDictionary *info = [[MisManager getInstance] HBXGetValueForKey:token];
        AppUser *appUser = [[AppUser alloc] init];
        if ([token isEqualToString:reviewAccount] && !info) {
            appUser.nickName = @"随风的风";
            appUser.avatarUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1562306081&di=69932264a345fea7ecf8b1854309d38d&src=http://pic148.nipic.com/file/20171207/7791170_202333876000_2.jpg";
            NSDictionary *dict = [appUser mj_keyValues];
            NSLog(@"saveInfo: %@ %@",dict, self.token);
            [[MisManager getInstance] HBXSetValue:dict key:self.token];
        }
                
        NSLog(@"info: %@ _token: %@", info ,_token);
        if (info) {          
            [appUser updateItem:info];
        }
        _currentUser = appUser;
        
        
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
    NSLog(@"saveInfo: %@ %@",dict, self.token);
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
    }
    return _manager;
}
@end
