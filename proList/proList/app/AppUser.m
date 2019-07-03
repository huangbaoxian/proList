//
//  AppUser.m
//  proList
//
//  Created by huangbaoxian on 2019/7/1.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "AppUser.h"

@implementation AppUser
- (void)setItemsWithDic:(NSDictionary *)dic {
    self.avatarUrl = [dic objectForKey:@"avatarUrl"];
    self.nickName = [dic objectForKey:@"nickname"];
    if ([self.nickName isEqual:[NSNull null]]) {
        self.nickName = @"";
    }
    self.phone = [dic objectForKey:@"phone"];
    
    NSDictionary *storeInfo = [self mj_keyValues];
//    [[MisManager shared] ZJSetUserInfo:storeInfo];
}
    
- (void)updateItem:(NSDictionary *)dic {
    self.avatarUrl = [dic objectForKey:@"avatarUrl"];
    self.nickName = [dic objectForKey:@"nickname"];
    self.phone = [dic objectForKey:@"phone"];
    self.token = [dic objectForKey:@"token"];
}
    
    
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.avatarUrl = [aDecoder decodeObjectForKey:@"avatarUrl"];
        self.nickName = [aDecoder decodeObjectForKey:@"nickname"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
       
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder
    {
        [coder encodeObject:self.avatarUrl forKey:@"avatarUrl"];
        [coder encodeObject:self.nickName forKey:@"nickname"];
        [coder encodeObject:self.phone forKey:@"phone"];
       
    }
@end
