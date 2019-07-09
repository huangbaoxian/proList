//
//  HBXResultRequest.m
//  proList
//
//  Created by huangbaoxian on 2019/7/4.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXResultRequest.h"

@implementation HBXResultRequest

+ (void)getInfoOnComplete:(ZJHttpRequestComplete)complete {
    
    HBXBaseRequest *request = [[HBXBaseRequest alloc] init];
//
    [request sendHttpPostRequestWithParam:@{} method:@"getAppConfig.php?appid=xbios20190705wddd" onComplete:complete];
    
//    [request sendHttpGetRequestWithParam:@{} method:@"getAppConfig.php?appid=iostestupdate" onComplete:complete];
}

@end
