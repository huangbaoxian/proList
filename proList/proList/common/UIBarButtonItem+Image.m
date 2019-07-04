//
//  UIBarButtonItem+Image.m
//  RenrenSixin
//
//  Created by 钟 声 on 11-12-28.
//  Copyright (c) 2011年 renren. All rights reserved.
//

#import "UIBarButtonItem+Image.h"
//#import "PKResManager.h"

@implementation UIBarButtonItem (CustomImage)

- (void)setButtonAttribute:(NSDictionary*)dic
{
    if ([self.customView isKindOfClass:[UIButton class]]) {
        UIButton* button = (UIButton*)self.customView;
        UIFont* font = [dic objectForKey:@"font"];
        if (font != nil && [font isKindOfClass:[UIFont class]]) {
            [button.titleLabel setFont:font];
        }
        NSNumber* shadowOffset = [dic objectForKey:@"shadowOffset"];
        if (shadowOffset != nil && [shadowOffset isKindOfClass:[NSNumber class]]) {
            [button.titleLabel setShadowOffset:shadowOffset.CGSizeValue];
        }
        NSNumber* buttonWidth = [dic objectForKey:@"width"];
        if (buttonWidth != nil && [buttonWidth isKindOfClass:[NSNumber class]]) {
            CGRect rc = button.frame;
            rc.size.width = buttonWidth.floatValue;
            button.frame = rc;
        }
        UIColor* titleColorNormal = [dic objectForKey:@"titleColorNormal"];
        if (titleColorNormal != nil && [titleColorNormal isKindOfClass:[UIColor class]]) {
            [button setTitleColor:titleColorNormal forState:UIControlStateNormal];
        }
        UIColor* shadowColorNormal = [dic objectForKey:@"shadowColorNormal"];
        if (shadowColorNormal != nil && [shadowColorNormal isKindOfClass:[UIColor class]]) {
            [button setTitleShadowColor:shadowColorNormal forState:UIControlStateNormal];
        }
        UIColor* titleColorHighlighted = [dic objectForKey:@"titleColorHighlighted"];
        if (titleColorHighlighted != nil && [titleColorHighlighted isKindOfClass:[UIColor class]]) {
            [button setTitleColor:titleColorHighlighted forState:UIControlStateHighlighted];
        }
        UIColor* shadowColorHightlighted = [dic objectForKey:@"shadowColorHightlighted"];
        if (shadowColorHightlighted != nil && [shadowColorHightlighted isKindOfClass:[UIColor class]]) {
            [button setTitleShadowColor:shadowColorHightlighted forState:UIControlStateHighlighted];
        }
    }
}

+ (UIBarButtonItem *)rsNormalBarButtonItemWithTitle:(NSString *)title
                                        image:(UIImage *)image
                             heightLightImage:(UIImage *)hlImage
                                 disableImage:(UIImage *)disImage
                                       target:(id)target
                                       action:(SEL)selector
{
    UIButton* customButton = [self rsCustomBarButtonWithTitle:title
                                                        image:image
                                             heightLightImage:hlImage
                                                 disableImage:disImage
                                                       target:target
                                                       action:selector];
    CGSize sizeOfTitle = CGSizeZero;
    if (title!=nil && [title isKindOfClass:[NSString class]] && ![title isEqualToString:@""]) {
        NSDictionary* tdic = [NSDictionary dictionaryWithObjectsAndKeys:customButton.titleLabel.font, NSFontAttributeName, nil];
        CGRect rect = [title boundingRectWithSize:CGSizeMake(100.0f, 22.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil];
        sizeOfTitle = rect.size;
    }
    
    CGFloat width = 100.0f;
    CGFloat height = 44.0f;
    CGFloat x = 0.0f;
    CGFloat y = 0.0f;
    if (customButton.currentBackgroundImage != nil) {
        width = customButton.currentBackgroundImage.size.width;
        height = customButton.currentBackgroundImage.size.height;
    }
    if (sizeOfTitle.width <= 0.0f) {
        [customButton setFrame:CGRectMake(x,
                                          y,
                                          width,
                                          height)];
    }else {
        [customButton setFrame:CGRectMake(x,
                                          y,
                                          sizeOfTitle.width+22.0f,
                                          height)];
    }
    
    [customButton setTitleColor:RGBACOLOR(0x0, 0x0,0, 1) forState:UIControlStateNormal];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    barBtnItem.width = customButton.width;
    return barBtnItem;
}


+ (UIBarButtonItem *)rsBarButtonItemWithTitle:(NSString *)title 
                                        image:(UIImage *)image
                             heightLightImage:(UIImage *)hlImage
                                 disableImage:(UIImage *)disImage
                                       target:(id)target
                                       action:(SEL)selector
{
    UIButton* customButton = [self rsCustomBarButtonWithTitle:title
                                                        image:image
                                             heightLightImage:hlImage
                                                 disableImage:disImage
                                                       target:target
                                                       action:selector];
    CGSize sizeOfTitle = CGSizeZero;
    if (title!=nil && [title isKindOfClass:[NSString class]] && ![title isEqualToString:@""]) {
        NSDictionary* tdic = [NSDictionary dictionaryWithObjectsAndKeys:customButton.titleLabel.font, NSFontAttributeName, nil];
        CGRect rect = [title boundingRectWithSize:CGSizeMake(100.0f, 22.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil];
        sizeOfTitle = rect.size;
    }
    
    CGFloat width = 100.0f;
    CGFloat height = 44.0f;
    CGFloat x = 0.0f;
    CGFloat y = 0.0f;
    if (customButton.currentBackgroundImage != nil) {
        width = customButton.currentBackgroundImage.size.width;
        height = customButton.currentBackgroundImage.size.height;
    }
    if (sizeOfTitle.width <= 0.0f) {
        [customButton setFrame:CGRectMake(x,
                                          y,
                                          width,
                                          height)];        
    }else {
        [customButton setFrame:CGRectMake(x,
                                          y,
                                          sizeOfTitle.width+30.0f,
                                          height)];
    }

    [customButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [customButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 100 - customButton.currentImage.size.width)];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    barBtnItem.width = customButton.width;
    return barBtnItem;
}



+ (UIBarButtonItem *)rsBarButtonItemWithTitle:(NSString *)title
                                        image:(UIImage *)image
                                     showRedD:(BOOL)isShowRedDat
                             heightLightImage:(UIImage *)hlImage
                                 disableImage:(UIImage *)disImage
                                       target:(id)target
                                       action:(SEL)selector
{
    UIButton* customButton = [self rsCustomBarButtonWithTitle:title
                                                        image:image
                                             heightLightImage:hlImage
                                                 disableImage:disImage
                                                       target:target
                                                       action:selector];
    CGSize sizeOfTitle = CGSizeZero;
    CGFloat titleWidth = 0;
    if (title!=nil && [title isKindOfClass:[NSString class]] && ![title isEqualToString:@""]) {
        NSDictionary* tdic = [NSDictionary dictionaryWithObjectsAndKeys:customButton.titleLabel.font, NSFontAttributeName, nil];
        CGRect rect = [title boundingRectWithSize:CGSizeMake(100.0f, 22.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil];
        titleWidth = rect.size.width;
        sizeOfTitle = rect.size;
    }
    
    CGFloat width = 100.0f;
    CGFloat height = 44.0f;
    CGFloat x = 0.0f;
    CGFloat y = 0.0f;
    if (customButton.currentBackgroundImage != nil) {
        width = customButton.currentBackgroundImage.size.width;
        height = customButton.currentBackgroundImage.size.height;
    }
    if (sizeOfTitle.width <= 0.0f) {
        [customButton setFrame:CGRectMake(x,
                                          y,
                                          width,
                                          height)];
    }else {
        [customButton setFrame:CGRectMake(x,
                                          y,
                                          sizeOfTitle.width+30.0f,
                                          height)];
    }
    
    if (isShowRedDat) {
        UIView *redDotView = [[UIView alloc] init];
        [customButton addSubview:redDotView];
        redDotView.backgroundColor = UIColorFromRGB(0xff6d41);
        [redDotView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(customButton);
            make.trailing.equalTo(customButton).offset(-titleWidth - 10);
            make.width.height.mas_equalTo(6);
        }];
        redDotView.layer.masksToBounds = YES;
        redDotView.layer.cornerRadius = 3;
    }
    
    [customButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [customButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 100 - customButton.currentImage.size.width)];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    barBtnItem.width = customButton.width;
    return barBtnItem;
}



+ (UIBarButtonItem *)rsBarButtonItemWithBellButton:(UIButton *)bellButton
                                             image:(UIImage *)image
                                  heightLightImage:(UIImage *)hlImage
                                      disableImage:(UIImage *)disImage
                                            target:(id)target
                                            action:(SEL)selector
{
    UIButton* customButton = [self rsCustomBarButtonWithTitle:nil
                                                        image:image
                                             heightLightImage:hlImage
                                                 disableImage:disImage
                                                       target:target
                                                       action:selector];
    CGSize sizeOfBellButton = CGSizeZero;
    if (bellButton!=nil  /*&& !bellButton.isHidden*/ ) {
        sizeOfBellButton = [bellButton size];;
    }

    CGFloat width = 100.0f;
    CGFloat height = 44.0f;
    CGFloat x = 0.0f;
    CGFloat y = 0.0f;
    if (customButton.currentBackgroundImage != nil) {
        width = customButton.currentBackgroundImage.size.width;
        height = customButton.currentBackgroundImage.size.height;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,y,sizeOfBellButton.width + width +3,  height)];
    if (sizeOfBellButton.width <= 0.0f ) {
        [customButton setFrame:CGRectMake(x,
                                          y,
                                          width,
                                          height)];
        [view addSubview:customButton];
    }else {

        CGRect inputFrame = CGRectMake(0,0,sizeOfBellButton.width,sizeOfBellButton.height);
        bellButton.frame = CGRectIntegral(inputFrame);

        
        [customButton setFrame:CGRectMake(sizeOfBellButton.width+3,
                                          y,
                                          width,
                                          height)];
        [view addSubview:bellButton];
        [view addSubview:customButton];
    }

    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    //    barBtnItem.width = [customButton currentBackgroundImage].size.width;
    return barBtnItem;
}

+ (UIBarButtonItem *)rsBarButtonTitleBlewImage:(UIImage *)image
                                         title:(NSString *)title
                                        target:(id)target
                                        action:(SEL)selector
{
    
    // 创建自定义按钮
    UIButton *btn_click = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImageView *imageView = nil;
    if (image) {
        imageView = [[UIImageView alloc] initWithImage:image];
    }
   
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12.0];
    label.text = title;
    label.textColor = UIColorFromRGB(0x333333);
    btn_click.frame = CGRectMake(0, 0, 100, 50);
    [btn_click addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    if (image) {
        [btn_click addSubview:imageView];
        imageView.frame = CGRectMake(100 - imageView.width, 5, imageView.width, imageView.height);
    }
    [label sizeToFit];
    [btn_click addSubview:label];
    
    label.frame = CGRectMake(100 - label.width + 10, 0, label.width, label.height);
    if (image) {
         label.centerX = imageView.centerX;
         label.bottom = 40;
    }else {
         label.bottom = 30;
    }
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn_click];
    return barItem;
}

+ (UIBarButtonItem *)rsBarButtonTitleBlewImage:(UIImage *)image
                                  isShowRedDot:(BOOL)isShowRedDot
                                         title:(NSString *)title
                                        target:(id)target
                                        action:(SEL)selector
{
    
    // 创建自定义按钮
    UIButton *btn_click = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImageView *imageView = nil;
    if (image) {
        imageView = [[UIImageView alloc] initWithImage:image];
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14.0];
    label.text = title;
    label.textColor = UIColorFromRGB(0x333333);
    btn_click.frame = CGRectMake(0, 0, 100, 50);
    [btn_click addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    if (image) {
        [btn_click addSubview:imageView];
        imageView.frame = CGRectMake(100 - imageView.width, 5, imageView.width, imageView.height);
    }
    [label sizeToFit];
    [btn_click addSubview:label];
    
    label.frame = CGRectMake(100 - label.width + 8, 0, label.width, label.height);
    if (image) {
        label.centerX = imageView.centerX;
        label.bottom = 40;
    }else {
        label.bottom = 30;
    }
    
    if (isShowRedDot) {
        UIImageView *redDotView = [[UIImageView alloc] init];
        [btn_click addSubview:redDotView];
//        redDotView.backgroundColor = UIColorFromRGB(0xff6d41);
        redDotView.frame = CGRectMake(label.left - 13, (label.height - 11)/2, 11,11);
        redDotView.centerY = label.centerY;
//        redDotView.layer.masksToBounds = YES;
//        redDotView.layer.cornerRadius = 4;
        
        redDotView.animationImages = @[[UIImage imageNamed:@"zj_message_ocon_1"], [UIImage imageNamed:@"zj_message_ocon_2"]];
        redDotView.animationDuration = 1.0;
        redDotView.animationRepeatCount = 0;
        [redDotView startAnimating];
    }
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn_click];
    return barItem;
}



+ (UIBarButtonItem *)rsBarButtonTitle:(NSString *)title
                                color:(UIColor *)textColor
                                            target:(id)target
                                            action:(SEL)selector
{
  
    // 创建自定义按钮
    UIButton *btn_click = [UIButton buttonWithType:UIButtonTypeCustom];
    

    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15.0];
    label.text = title;
    label.textColor = textColor;
    btn_click.frame = CGRectMake(0, 0, 100, 50);
    [btn_click addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
   
    [label sizeToFit];
    [btn_click addSubview:label];
    
    label.frame = CGRectMake(3 , 0, label.width, label.height);
    label.bottom = 42;
    label.centerY = btn_click.centerY;
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn_click];
    return barItem;
}
+ (UIBarButtonItem *)rsBarButtonTitle:(NSString *)title
                                color:(UIColor *)textColor
                             showRedD:(BOOL)isShowRedDat
                               target:(id)target
                               action:(SEL)selector {
    // 创建自定义按钮
    UIButton *btn_click = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15.0];
    label.text = title;
    label.textColor = textColor;
    btn_click.frame = CGRectMake(0, 0, 100, 50);
    [btn_click addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [label sizeToFit];
    [btn_click addSubview:label];
    
    label.frame = CGRectMake(3 , 0, label.width, label.height);
    label.bottom = 42;
    label.centerY = btn_click.centerY;
    
    
    
    if (isShowRedDat) {
        UIView *redDotView = [[UIView alloc] init];
        [btn_click addSubview:redDotView];
        [redDotView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(btn_click);
            make.trailing.equalTo(btn_click).offset(- label.width - 20);
            make.width.height.mas_equalTo(8);
        }];
        redDotView.layer.masksToBounds = YES;
        redDotView.layer.cornerRadius = 4;
    }
    
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn_click];
    return barItem;
    
}


+ (UIBarButtonItem *)rsLeftBarButtonTitleBlewImage:(UIImage *)image
                                         title:(NSString *)title
                                        target:(id)target
                                        action:(SEL)selector
{
    
    // 创建自定义按钮
    UIButton *btn_click = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12.0];
    label.text = title;
    label.textColor = UIColorFromRGB(0x333333);
    btn_click.frame = CGRectMake(0, 0, 100, 50);
    [btn_click addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn_click addSubview:imageView];
    imageView.frame = CGRectMake(10, 5, imageView.width, imageView.height);
    [label sizeToFit];
    [btn_click addSubview:label];
    
    label.frame = CGRectMake(10 , 0, label.width, label.height);
    label.bottom = 42;
    label.centerX = imageView.centerX;
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn_click];
    return barItem;
}

/*
 * 是否显示红点
 */
+ (UIBarButtonItem *)rsBarButtonItemWithTitle:(NSString *)title
                                     showRedD:(BOOL)isShowRedDat
                                       target:(id)target
                                       action:(SEL)selector {
    
    return [UIBarButtonItem rsBarButtonItemWithTitle:title
                                               image:nil
                                            showRedD:isShowRedDat
                                    heightLightImage:nil
                                        disableImage:nil
                                              target:target
                                              action:selector];
}

+ (UIBarButtonItem *)rsBarButtonItemWithTitle:(NSString *)title
                                       target:(id)target
                                       action:(SEL)selector{
    
    return [UIBarButtonItem rsBarButtonItemWithTitle:title
                                                   image:nil
                                        heightLightImage:nil
                                            disableImage:nil
                                                  target:target
                                                  action:selector];
    

}

+ (UIButton*)rsCustomBarButtonWithTitle:(NSString*)title
                                  image:(UIImage *)image
                       heightLightImage:(UIImage *)hlImage
                           disableImage:(UIImage *)disImage
                                 target:(id)target
                                 action:(SEL)selector
{
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (image != nil) {
        [customButton setImage:image forState:UIControlStateNormal];
        [customButton setBackgroundColor:[UIColor clearColor]];
    }
    else {
//        [customButton setBackgroundColor:[UIColor blueColor]];
        customButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    if (hlImage != nil) {
        [customButton setImage:hlImage forState:UIControlStateHighlighted];
    }
    if (nil != disImage)
    {
        [customButton setImage:disImage forState:UIControlStateDisabled];
    }
//    if (title.length <= 2) {
        [customButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
//    }
//    else
//    {
//        [customButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
//    }
    [customButton.titleLabel setShadowOffset:CGSizeMake(0.0f, 0.5f)];
    if (title!=nil && [title isKindOfClass:[NSString class]]  && ![title isEqualToString:@""]) {
        [customButton setTitle:title forState:UIControlStateNormal];
        [customButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
//        [customButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [customButton setTitleShadowColor:RGBACOLOR(0, 0, 0, 0.4) forState:UIControlStateDisabled];
        
    }

    [customButton setTitleColor:RGBACOLOR(0, 0, 0, 0.3) forState:UIControlStateDisabled];
    [customButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return customButton;
}

@end
