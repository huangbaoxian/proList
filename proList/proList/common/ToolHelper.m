//
//  ToolHelper.m
//  proList
//
//  Created by huangbaoxian on 2019/7/2.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "ToolHelper.h"


#define KDATELIST @"dateList"

#define KMODELLIST @"KMODELLIST"
@implementation ToolHelper

+ (void)saveNote:(NSDictionary *)dict {
    
    NSArray *list = [[MisManager getInstance] HBXGetValueForKey:KDATELIST];
    NSMutableArray *creatList = [NSMutableArray arrayWithArray:list];
    [creatList addObject:dict];
    [[MisManager getInstance] HBXSetValue:creatList key:KDATELIST];
}

+ (NSArray *)getNoteList {
    NSArray *list = [[MisManager getInstance] HBXGetValueForKey:KDATELIST];
    return list;
}


+ (void)saveModel:(NSDictionary *)dict {
    NSArray *list = [[MisManager getInstance] HBXGetValueForKey:KMODELLIST];
    NSMutableArray *creatList = [NSMutableArray arrayWithArray:list];
    [creatList addObject:dict];
    [[MisManager getInstance] HBXSetValue:creatList key:KMODELLIST];
    
}
+ (NSArray *)getModelList {
    NSArray *list = [[MisManager getInstance] HBXGetValueForKey:KMODELLIST];
    return list;
}

+ (UILabel *)getNormalLabel {
    UILabel *  _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:14.0];
    _contentLabel.textColor = UIColorFromRGB(0x333333);
    return _contentLabel;
}

+ (BOOL)loginWithAccount:(NSString *)account passWord:(NSString *)password {
    NSString *tokenKey = [NSString stringWithFormat:@"key%@", account];
    NSDictionary *dict = [[MisManager getInstance] HBXGetValueForKey:tokenKey];
    if (dict) {
        NSString *getPassWord = dict[@"passWord"];
        if([password isEqualToString:getPassWord]) {
            return YES;
        }
        return NO;
    }else {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"passWord"] = password;
        param[@"account"] = account;
        [[MisManager getInstance] HBXSetValue:param key:tokenKey];
        return YES;
    }
    
}

+ (void)setImageWithImageView:(UIImageView *)imageView url:(NSString *)url {
    if ([url containsString:@"localhost"]) {
        UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:url];
        imageView.image = image;
    }else {
        [imageView sd_setImageWithURL:[NSURL URLWithString:url ?: @""]];
    }
}

+ (void)setImageWithImageView:(UIImageView *)imageView url:(NSString *)url  defaultImage:(UIImage *)defaultImage {
    if ([url containsString:@"localhost"]) {
        UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:url];
        if (!image) {
            image = defaultImage;
        }
        imageView.image = image;
    }else {
        [imageView sd_setImageWithURL:[NSURL URLWithString:url ?: @""] placeholderImage:defaultImage];
    }
}

@end
