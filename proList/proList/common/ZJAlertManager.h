//
//  ZJAlertManager.h
//  aizongjie
//
//  Created by huangbaoxian on 2018/7/16.
//  Copyright © 2018年 wennzg. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AlertActionBlock)(id param);


@interface ZJAlertManager : NSObject

+ (void)showAlertVtitle:(NSString *)title
                message:(NSString *)message
           comfirmTitle:(NSString *)comfirmTitle
            cancelTitle:(NSString *)cancelTitle
                  style:(UIAlertControllerStyle)style
          comfirmAction:(AlertActionBlock)comfirmAction
           cancleAction:(AlertActionBlock)cancelAction;



+ (void)showAlertVtitle:(NSString *)title
                message:(NSString *)message
           comfirmTitle:(NSString *)comfirmTitle
            cancelTitle:(NSString *)cancelTitle
               textFile:(NSString *)placeholder
                  style:(UIAlertControllerStyle)style
                 result:(AlertActionBlock)result
          comfirmAction:(AlertActionBlock)comfirmAction
           cancleAction:(AlertActionBlock)cancelAction;

+ (void)showSystemSharedUrl:(NSString *)url;


+ (void)showSystemSharedPDF:(NSString *)pdfLocateUrl;

@end
