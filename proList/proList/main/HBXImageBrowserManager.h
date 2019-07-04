//
//  HBXImageBrowserManager.h
//  proList
//
//  Created by huangbaoxian on 2019/7/4.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBXImageBrowserManager : NSObject

+ (void)showBrowserViewControllerWithUrl:(NSString *)url index:(NSInteger)index ;
- (void)handleImageArray:(NSArray *)imageArray;
- (void)handleImageArray:(NSArray *)imageArray index:(int)index ;
@end

NS_ASSUME_NONNULL_END
