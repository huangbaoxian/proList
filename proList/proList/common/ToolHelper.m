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

@end
