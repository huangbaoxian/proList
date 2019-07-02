//
//  UIButton+Addictions.h
//  RenrenOfficial-iOS-Concept
//
//  Created by Guichao Huang on 13-12-12.
//  Copyright (c) 2013年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, OTSUIButtonLayoutStyle) {
    OTSImageLeftTitleRightStyle = 0, //默认的方式 image左 title右
    OTSTitleLeftImageRightStyle = 1, // image右,title左
    OTSImageTopTitleBootomStyle = 2, //image上，title下
    OTSTitleTopImageBootomStyle = 3, // image下,title上
};

@interface UIButton (FlexSpace)
/**
 *	功能:设置UIButton的布局，图片和文字按照指定方向显示
 *
 *	@param aLayoutStyle:参见OTSUIButtonLayoutStyle
 *	@param aSpacing:图片和文字之间的间隔
 */
- (void)setLayout:(OTSUIButtonLayoutStyle )aLayoutStyle
          spacing:(CGFloat)aSpacing;

@end


@interface UIButton(SubviewsPosition)

- (void)centerImageAndTitleWithSpacing:(CGFloat)spacing;

@end

@interface UIButton(SetImage)

- (void)setImageWithNameForStateNormal:(NSString *)normal;
- (void)setImageWithNameForStateNormal:(NSString *)normal highlightedAndSelected:(NSString *)highlightedAndSelected disabled:(NSString *)disabled;
- (void)setImageWithNameForStateNormal:(NSString *)normal highlighted:(NSString *)highlighted selected:(NSString *)selected disabled:(NSString *)disabled;

@end
