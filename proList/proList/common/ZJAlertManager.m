//
//  ZJAlertManager.m
//  aizongjie
//
//  Created by huangbaoxian on 2018/7/16.
//  Copyright © 2018年 wennzg. All rights reserved.
//

#import "ZJAlertManager.h"

static NSString *successStatus = @"1";
static NSString *cancelStatus = @"2";



@implementation ZJAlertManager

+ (void)showAlertVtitle:(NSString *)title
                message:(NSString *)message
           comfirmTitle:(NSString *)comfirmTitle
            cancelTitle:(NSString *)cancelTitle
                  style:(UIAlertControllerStyle)style
          comfirmAction:(AlertActionBlock)comfirmAction
           cancleAction:(AlertActionBlock)cancelAction {
    
    
    if (style == UIAlertControllerStyleAlert) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
        
        if (comfirmTitle) {
            UIAlertAction *sure = [UIAlertAction actionWithTitle:comfirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (comfirmAction) {
                        comfirmAction(successStatus);
                    }
                });
            }];
            [alert addAction:sure];
        }
        if (cancelTitle) {
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if (cancelAction) {
                    cancelAction(cancelStatus);
                }
            }];
            
            [alert addAction:cancel];
        }
        [AppNavigator showModalViewController:alert animated:YES];
        
    }else {        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        if (comfirmTitle) {
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:comfirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (comfirmAction) {
                    comfirmAction(successStatus);
                }
            }];
            [actionSheet addAction:sureAction];
        }
        if (cancelTitle) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (cancelAction) {
                    cancelAction(cancelStatus);
                }
            }];
            [actionSheet addAction:otherAction];
        }
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [actionSheet addAction:cancel];
        [AppNavigator showModalViewController:actionSheet animated:YES];
    }
}

+ (void)showAlertVtitle:(NSString *)title
                message:(NSString *)message
           comfirmTitle:(NSString *)comfirmTitle
            cancelTitle:(NSString *)cancelTitle
               textFile:(NSString *)placeholder
                  style:(UIAlertControllerStyle)style
                 result:(AlertActionBlock)result
          comfirmAction:(AlertActionBlock)comfirmAction
           cancleAction:(AlertActionBlock)cancelAction {
    
    if (style == UIAlertControllerStyleAlert) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = placeholder;           
        }];
        if (comfirmTitle) {
            UIAlertAction *sure = [UIAlertAction actionWithTitle:comfirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if ([alert textFields].count > 0) {
                    NSString *res = [[alert textFields] objectAtIndex:0].text;
                    if (result) {
                        result(res);
                    }
                }                
                if (comfirmAction) {
                    comfirmAction(successStatus);
                }
            }];
            [alert addAction:sure];
        }
        if (cancelTitle) {
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if (cancelAction) {
                    cancelAction(cancelStatus);
                }
            }];
            
            [alert addAction:cancel];
        }
        [AppNavigator showModalViewController:alert animated:YES];
        
    }else {
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        if (comfirmTitle) {
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:comfirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (comfirmAction) {
                    comfirmAction(successStatus);
                }
            }];
            [actionSheet addAction:sureAction];
        }
        if (cancelTitle) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (cancelAction) {
                    cancelAction(cancelStatus);
                }
            }];
            [actionSheet addAction:otherAction];
        }
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [actionSheet addAction:cancel];
        [AppNavigator showModalViewController:actionSheet animated:YES];
    }
}




/*
 
 NSMutableArray *items = [NSMutableArray arrayWithObject:[photo underlyingImage]];
 if (photo.caption) {
 [items addObject:photo.caption];
 }
 self.activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
 
 // Show loading spinner after a couple of seconds
 double delayInSeconds = 2.0;
 dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
 dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
 if (self.activityViewController) {
 [self showProgressHUDWithMessage:nil];
 }
 });
 
 // Show
 typeof(self) __weak weakSelf = self;
 [self.activityViewController setCompletionHandler:^(NSString *activityType, BOOL completed) {
 weakSelf.activityViewController = nil;
 [weakSelf hideControlsAfterDelay];
 [weakSelf hideProgressHUD:YES];
 }];
 // iOS 8 - Set the Anchor Point for the popover
 if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8")) {
 self.activityViewController.popoverPresentationController.barButtonItem = _actionButton;
 }
 [AppNavigator showModalViewController:self.activityViewController animated:YES];*/

+ (void)showSystemSharedUrl:(NSString *)url {
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:@[url?:@""] applicationActivities:nil];
    
    [vc setCompletionWithItemsHandler:^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        
    }];
    [AppNavigator showModalViewController:vc animated:YES];
}

+ (void)showSystemSharedPDF:(NSString *)pdfLocateUrl {
    
    NSURL *url = [NSURL fileURLWithPath:pdfLocateUrl];

//    NSData *data = [NSData dataWithContentsOfURL:url];
    
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:@[url] applicationActivities:nil];
    [vc setCompletionWithItemsHandler:^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        
    }];
    
    [AppNavigator showModalViewController:vc animated:YES];
    
}

@end
