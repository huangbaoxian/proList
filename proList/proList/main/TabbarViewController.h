//
//  TabbarViewController.h
//  proList
//
//  Created by huangbaoxian on 2019/6/30.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TabbarViewController : UIViewController
+ (instancetype)tabbarViewController;
- (void)showMessageRedDot;
- (void)hideMessageRedDot;
- (void) changeToIndex:(NSInteger) index;
@end

NS_ASSUME_NONNULL_END
