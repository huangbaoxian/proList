//
//  MisManager.h
//  proList
//
//  Created by huangbaoxian on 2019/7/2.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MisManager : NSObject

+ (MisManager *)getInstance;

- (void)HBXSetValue:(id)value key:(NSString *)key;
- (id)HBXGetValueForKey:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
