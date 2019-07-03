//
//  HBXGoalModel.m
//  proList
//
//  Created by huangbaoxian on 2019/7/4.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXGoalModel.h"

@implementation HBXGoalModel

- (CGFloat)cellHeight {
    if (_cellHeight > 0) {
        return _cellHeight;
    }
    
    if (self.content.length == 0) {
        _cellHeight = 80;
        return 80;
    }
    
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0]};
    CGRect rect =  [self.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 60, 10000) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
   
    _cellHeight = 80 + rect.size.height + 20;
    return _cellHeight;
    
    
}



@end

