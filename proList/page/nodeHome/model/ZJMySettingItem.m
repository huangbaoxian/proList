//
//  ZJMySettingItem.m
//  proList
//
//  Created by huangbaoxian on 2019/7/1.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "ZJMySettingItem.h"

@implementation ZJMySettingItem
+ (ZJMySettingItem *)itemWithDict:(NSDictionary *)param {
    
    ZJMySettingItem *item = [[ZJMySettingItem alloc] init];
    item.keyString = param[@"title"];
    item.valueString = param[@"secondTitle"];
    item.iconString = param[@"iconUrl"];
    item.url = param[@"url"];
    item.selectIconUrl = param[@"selectIconUrl"];
    item.type = [param[@"type"] intValue];
    return item;
}

-(void)setUrl:(NSString *)url {
    _url = url;
   
}


@end
