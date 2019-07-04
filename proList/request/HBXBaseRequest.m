//
//  HBXBaseRequest.m
//  proList
//
//  Created by huangbaoxian on 2019/7/4.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXBaseRequest.h"
NSString * const kBaseRequestConstDataNeedCache = @"kBaseRequestConstDataNeedCache"; //固定数据需要缓存

static  dispatch_queue_t downloadQueue;
@implementation HBXBaseRequest
- (instancetype)init {
    if (self = [super init]) {
        if (!downloadQueue) {
            downloadQueue = dispatch_queue_create("zongjie.download.test", DISPATCH_QUEUE_CONCURRENT);
        }
    }
    return self;
}



- (void)sendHttpPostRequestWithParam:(NSDictionary *)param
                              method:(NSString *)method
                          onComplete:(ZJHttpRequestComplete)requestComplete{
    if ((method == nil) || (method.length == 0)) {
        if (requestComplete != nil) {
            // 异常处理
            dispatch_async(dispatch_get_main_queue(), ^{
                requestComplete(0, nil, @"未提供方法",1002);
                return;
            });
        }
        return;
    }
    dispatch_async(downloadQueue, ^{
        [self sendHttpRequestWithParam:param
                                   url:APPCONTEXT.config.mApiUrl
                                method:method
                             postOrGet:@"POST"
                            onComplete:requestComplete];
        
    });
    
}

- (void)sendHttpGetRequestWithParam:(NSDictionary *)param
                             method:(NSString *)method
                         onComplete:(ZJHttpRequestComplete)requestComplete {
    if ((method == nil) || (method.length == 0)) {
        if (requestComplete != nil) {
            // 异常处理
            dispatch_async(dispatch_get_main_queue(), ^{
                if (requestComplete) {
                    requestComplete(0, nil, @"未提供方法", 1001);
                }
            });
            
        }
        return;
    }
    
    dispatch_async(downloadQueue, ^{
        [self sendHttpRequestWithParam:param
                                   url:APPCONTEXT.config.mApiUrl
                                method:method
                             postOrGet:@"GET"
                            onComplete:requestComplete];
    });
}

- (void)sendHttpRequestWithParam:(NSDictionary *)param
                             url:(NSString *)apiUrl
                          method:(NSString *)method
                       postOrGet:(NSString *)postOrGet
                      onComplete:(ZJHttpRequestComplete)requestComplete
{
    NSString *urlPath = [NSString stringWithFormat:@"%@%@", apiUrl, method];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
  
   
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    AFHTTPSessionManager *manager = APPCONTEXT.manager;
        __block typeof(self) weakSelf = self;
    if([postOrGet isEqualToString:@"GET"]){
        [manager GET:urlPath parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"url=%@,responseObject=%@",urlPath,responseObject);
                [weakSelf handleHttpResponseDic:responseObject onComplete:requestComplete methods:method];
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"url=%@,failed",urlPath);
                [SVProgressHUD dismiss];
                if (error.code == -1009) {
                    if (requestComplete) {
                        requestComplete(NO,nil,@"请检查网络", 1001);
                        return;
                    }
                }else {
                    if (requestComplete) {
                        requestComplete(NO,nil,@"未知异常", 1002);
                    }
                }
            });
            
        }];
    }else if ([postOrGet isEqualToString:@"POST"]){
        [manager POST:urlPath parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"success url=%@,responseObject=%@",urlPath,responseObject);
                [weakSelf handleHttpResponseDic:responseObject onComplete:requestComplete methods:method];
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"failed task : %@ %@",task, error.description);
                [SVProgressHUD dismiss];
                if (error.code == -1009) {
                    if (requestComplete) {
                        requestComplete(NO,nil,@"请检查网络", 1001);
                        return;
                    }
                }else {
                    if (requestComplete) {
                        requestComplete(NO,nil,@"未知异常", 1002);
                    }
                }
            });
        }];
    }
}
     
     
 
 - (void)handleHttpResponseDic:(id)responseObject onComplete:(ZJHttpRequestComplete)requestComplete methods:(NSString *)methods{
     NSDictionary *responseDic = responseObject;
     if([responseObject isKindOfClass:[NSDictionary class]]){
         NSInteger code = [[responseDic objectForKey:@"code"] integerValue];
         NSString *message = [responseDic objectForKey:@"message"];
         if (code == 9999 && message && message.length == 0) {
             message = @"未知异常";
         }
         
         if (code == 0) {
             if (requestComplete) {
                 requestComplete(YES,responseDic,nil,0);
             }
             return;
         }else if (code == 1){//登录过期
            
             
         }else{
             if (requestComplete) {
                 requestComplete(NO,nil,message,code);
             }
         }
     }
 }


@end
