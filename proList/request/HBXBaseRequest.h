//
//  HBXBaseRequest.h
//  proList
//
//  Created by huangbaoxian on 2019/7/4.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kRSBaseRequestServerReturnError (-3)
#define kRSBaseRequestConnectError      (-2)
#define kRSBaseRequestSuccess           (-1)
extern NSString * const kBaseRequestConstDataNeedCache; //某些请求结果比较固定，param设置改值表示开启缓存
typedef enum {
    requestCacheAndServer = 0,
    requestCacheOnly,
    requestServerOnly
} baseRequestCachePolicy;

NS_ASSUME_NONNULL_BEGIN
typedef void (^ ZJHttpRequestComplete)(BOOL isSucceed, id info, NSString *errorMsg, int errorCode);

@interface HBXBaseRequest : NSObject
- (void)sendHttpPostRequestWithParam:(NSDictionary *)param
                              method:(NSString *)method
                          onComplete:(ZJHttpRequestComplete)requestComplete;
- (void)sendHttpGetRequestWithParam:(NSDictionary *)param
                             method:(NSString *)method
                         onComplete:(ZJHttpRequestComplete)requestComplete;
@end

NS_ASSUME_NONNULL_END
