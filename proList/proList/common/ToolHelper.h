//
//  ToolHelper.h
//  proList
//
//  Created by huangbaoxian on 2019/7/2.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToolHelper : NSObject

+ (void)saveNote:(NSDictionary *)dict;
+ (NSArray *)getNoteList;

+ (void)saveModel:(NSDictionary *)dict;
+ (NSArray *)getModelList;

+ (UILabel *)getNormalLabel;

+ (BOOL)loginWithAccount:(NSString *)account passWord:(NSString *)password;

+ (void)setImageWithImageView:(UIImageView *)imageView url:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
