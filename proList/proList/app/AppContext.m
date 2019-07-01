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
     
    }
    return self;
}
    
- (BOOL)checkLoginInfo{
    return YES;
    if (self.currentUser && self.currentUser.token.length > 0) {
        return YES;
    }    
    return NO;
}
    
@end
