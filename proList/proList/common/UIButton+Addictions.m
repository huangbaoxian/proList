//
//  UIButton+Addictions.m
//  RenrenOfficial-iOS-Concept
//
//  Created by Guichao Huang on 13-12-12.
//  Copyright (c) 2013年 renren. All rights reserved.
//

#import "UIButton+Addictions.h"


@implementation UIButton (FlexSpace)

- (void)setLayout:(OTSUIButtonLayoutStyle )aLayoutStyle
          spacing:(CGFloat)aSpacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGFloat totalHeight = (imageSize.height + titleSize.height + aSpacing);
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets titleEdgeInsets = UIEdgeInsetsZero;
    if (aLayoutStyle == OTSImageLeftTitleRightStyle) {
        imageEdgeInsets = UIEdgeInsetsMake(0, -(aSpacing / 2.0f), 0, 0 );
        titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, - (aSpacing / 2.0f));
    }
    else if (aLayoutStyle == OTSTitleLeftImageRightStyle) {
        imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -(titleSize.width * 2 + aSpacing / 2.0f));
        titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width * 2 + aSpacing / 2.0f), 0, 0);
    }else if (aLayoutStyle == OTSImageTopTitleBootomStyle){
        imageEdgeInsets = UIEdgeInsetsMake( -(totalHeight - imageSize.height),
                                           0.0,
                                           0.0,
                                           - titleSize.width);
        titleEdgeInsets  = UIEdgeInsetsMake(0.0,
                                            -imageSize.width,
                                            - (totalHeight - titleSize.height),
                                            0.0);
    }else if (aLayoutStyle == OTSTitleTopImageBootomStyle){
        imageEdgeInsets = UIEdgeInsetsMake(0.0,
                                           0.0,
                                           -(totalHeight - imageSize.height),
                                           - titleSize.width);
        
        titleEdgeInsets = UIEdgeInsetsMake(-(totalHeight - titleSize.height),
                                           0.0,
                                           -imageSize.width,
                                           0.0);
    }
    self.imageEdgeInsets = imageEdgeInsets;
    self.titleEdgeInsets = titleEdgeInsets;
}
@end

@implementation UIButton(SubviewsPosition)

- (void)centerImageAndTitleWithSpacing:(CGFloat)spacing
{
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
}

@end


@implementation UIButton(SetImage)

- (void)setImageWithNameForStateNormal:(NSString *)normal
{
    [self setImageWithNameForStateNormal:normal highlighted:nil selected:nil disabled:nil];
}

- (void)setImageWithNameForStateNormal:(NSString *)normal highlightedAndSelected:(NSString *)highlightedAndSelected disabled:(NSString *)disabled
{
    [self setImageWithNameForStateNormal:normal highlighted:highlightedAndSelected selected:highlightedAndSelected disabled:disabled];
}

- (void)setImageWithNameForStateNormal:(NSString *)normal highlighted:(NSString *)highlighted selected:(NSString *)selected disabled:(NSString *)disabled
{
    if(normal)
        [self setImage:[UIImage imageForKey:normal] forState:UIControlStateNormal];
    if(highlighted)
        [self setImage:[UIImage imageForKey:highlighted] forState:UIControlStateHighlighted];
    if(selected)
        [self setImage:[UIImage imageForKey:selected] forState:UIControlStateSelected];
    if(disabled)
        [self setImage:[UIImage imageForKey:disabled] forState:UIControlStateDisabled];
}

@end