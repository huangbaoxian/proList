//
//  MisManager.m
//  proList
//
//  Created by huangbaoxian on 2019/7/2.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "MisManager.h"

@interface MisManager ()

@property (nonatomic, strong) NSMutableDictionary *infoDict;

@end

@implementation MisManager
+ (MisManager *)getInstance {
    
    static id _manager;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _manager = [[MisManager alloc] init];
    });
    return _manager;
}
    
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}
- (void)HBXSetValue:(id)value key:(NSString *)key{
    if (!value || !key) {
        return;
    }
    [self setZJObject:value key:key];
}

- (void)setZJObject:(id)object key:(NSString *)key {
    if (!key || !object) {
        return;
    }
    self.infoDict[key] = object;
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



- (id)HBXGetValueForKey:(NSString *)key {
    if (!key) {
        return nil;
    }
    return [self ZJPrivateGetValueForKey:key];
}

- (id)ZJPrivateGetValueForKey:(NSString *)key {
    id object = self.infoDict[key];
    if (object) {
        return object;
    }
    object = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return object;
}
- (NSMutableDictionary *)infoDict {
    if (!_infoDict) {
        _infoDict = [[NSMutableDictionary alloc] init];
    }
    return _infoDict;
}

@end
