//
//  ToolHelper.m
//  proList
//
//  Created by huangbaoxian on 2019/7/2.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "ToolHelper.h"


#define KDATELIST @"dateList"
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
@end
