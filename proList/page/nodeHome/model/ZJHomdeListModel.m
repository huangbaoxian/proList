//
//  ZJHomdeListModel.m
//  proList
//
//  Created by huangbaoxian on 2019/7/1.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "ZJHomdeListModel.h"

@implementation ZJHomdeListModel

- (CGFloat)cellHeight {
    if (_cellHeight > 0) {
        return _cellHeight;
    }
    CGFloat height = 0;
    switch (self.type) {
        case HBXEditTypeTitle:
                {
                    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0]};
                    CGRect rect =  [self.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 30, 10000) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
                    height = rect.size.height;
                }
            break;
        case HBXEditTypeContent:
        {
            NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0]};
            CGRect rect =  [self.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 30, 10000) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
            height = rect.size.height;
        }
            break;
        case HBXEditTypeImage:
        {
            
            height = (SCREEN_WIDTH - 30)/(self.imageWidth) * self.imageHeight;
            NSLog(@"SCREEN_WIDTH:%f %f %f %f", SCREEN_WIDTH - 30,self.imageWidth, self.imageHeight, height);
        }
            break;
        default:
            break;
    }
    height += 15;
    _cellHeight = height;
    return _cellHeight;
    
    
}

- (instancetype)init {
    if (self = [super init]) {
        _imageWidth = 1;
    }
    return self;
}

@end
