//
//  ZJTabbar.m
//  proList
//
//  Created by huangbaoxian on 2019/6/30.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "ZJTabbar.h"

@implementation ZJTabbarItem
    
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //        self.selctedBg = [[UIImageView alloc] initWithFrame:self.bounds];
        //        self.selctedBg.image = nil;//[UIImage imageForKey:@"main_toolbar_sel"];
        //        [self addSubview:self.selctedBg];
        
        CGFloat contentHeight = 24 + 3 + 10;
        
        self.bgImage = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - 24) / 2, (self.height - contentHeight) / 2, 24, 24)];
        [self addSubview:self.bgImage];
        self.bgImage.contentMode = UIViewContentModeScaleAspectFit;
        CGRect rc = self.bounds;
        rc.origin.y = self.bgImage.bottom + 3;
        rc.size.height = 10.0f;
        self.titleLabel = [[UILabel alloc] initWithFrame:rc];
        self.titleLabel.font = [UIFont systemFontOfSize:10.0f];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
    }
    return self;
}
- (void)setActive:(BOOL)active {
    if (active) {
        self.backgroundColor = self.selectedBgColor;
        //        self.selctedBg.hidden = NO;
        self.bgImage.image = self.imageActive;
        self.titleLabel.textColor = UIColorFromRGB(0xff6d41);//[UIColor colorForKey:@"CommonModule-colorTypeA"];
    }
    else {
        self.backgroundColor = [UIColor clearColor];
        //        self.selctedBg.hidden = YES;
        self.bgImage.image = self.imageUnActive;
        self.titleLabel.textColor = UIColorFromRGB(0x666666);//[UIColor colorForKey:@"CommonModule-colorTypeD"];
    }
}
- (void)showRedDotView{
    if (self.redDotView == nil) {
        self.redDotView = [[UIView alloc] initWithFrame:CGRectMake(self.bgImage.right - 4, self.bgImage.top - 4, 8, 8)];
        [self.redDotView setBackgroundColor:[UIColor redColor]];
        self.redDotView.layer.masksToBounds = YES;
        self.redDotView.layer.cornerRadius = 4.f;
        [self addSubview:self.redDotView];
    }
    self.redDotView.hidden = NO;
}
- (void)hideRedDotView{
    self.redDotView.hidden = YES;
}
- (void)showUnreadCountLabel:(NSInteger)count{
    if (count > 99) {
        count = 99;
    }
    if (self.unReadCountLabel == nil) {
        self.unReadCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bgImage.right - 6, self.bgImage.top - 4, 15, 15)];
        [self.unReadCountLabel setBackgroundColor:[UIColor redColor]];
        [self.unReadCountLabel setTextColor:[UIColor whiteColor]];
        self.unReadCountLabel.layer.masksToBounds = YES;
        self.unReadCountLabel.layer.cornerRadius = 7.5;
        self.unReadCountLabel.textAlignment = NSTextAlignmentCenter;
        [self.unReadCountLabel setFont:[UIFont systemFontOfSize:10]];
        self.unReadCountLabel.adjustsFontSizeToFitWidth = YES;
    }
    [self.unReadCountLabel setText:[NSString stringWithFormat:@"%ld",count]];
    [self addSubview:self.unReadCountLabel];
    self.unReadCountLabel.hidden = NO;
}
- (void)hideUnreadCountLabel{
    self.unReadCountLabel.hidden = YES;
}
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     - (void)drawRect:(CGRect)rect {
     // Drawing code
     }
     */
    
    @end
@implementation ZJTabbar
- (void)setTabTitleArray:(NSArray*)titles iconNormal:(NSArray*)icons iconHighted:(NSArray*)iconHls selectedBgColor:(NSArray*)colors{
    if (titles) {
        NSAssert(titles.count > 0, @"tab title count error!");
        NSAssert((titles.count == icons.count) && (titles.count == iconHls.count), @"tab button count error!" );
        self.tabCount = titles.count;
    } else {
        self.tabCount = icons.count;
    }
    // load
    UIImageView* bgImage = [[UIImageView alloc] initWithFrame:self.bounds];
    bgImage.image = [UIImage imageForKey:@"main_toolbar_bg"];
    [self addSubview:bgImage];
    
    self.tabWidth = self.frame.size.width / self.tabCount;
    
    if (self.currentIndex < 0) {
        self.currentIndex = 0;
    }
    for (NSUInteger i = 0; i<self.tabCount; i++) {
        CGRect rc = CGRectMake(self.tabWidth*i, 0.0f, self.tabWidth, self.frame.size.height-kTabbarSafeBottomMargin);
        
        NSString* buttonTitle = nil;
        if (titles) {
            buttonTitle = [titles objectAtIndex:i];
        }
        NSString* icon = [icons objectAtIndex:i];
        NSString* iconHl = [iconHls objectAtIndex:i];
        UIColor *color = [colors objectAtIndex:i];
        ZJTabbarItem* item = [[ZJTabbarItem alloc] initWithFrame:rc];
        item.imageActive = [UIImage imageForKey:iconHl];
        item.imageUnActive = [UIImage imageForKey:icon];
        item.titleLabel.text = buttonTitle;
        item.selectedBgColor = color;
        item.tag = 100+i;
        [self addSubview:item];
        
        if (self.currentIndex == i) {
            [item setActive:YES];
        }
        else {
            [item setActive:NO];
        }
        //[item showBadgeView:YES];
    }
    
    UITapGestureRecognizer* ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabPressed:)];
    [self addGestureRecognizer:ges];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, .5)];
    [line setBackgroundColor:UIColorFromRGB(0xeeeeee)];
    [self addSubview:line];
    self.backgroundColor = [UIColor whiteColor];
}
- (void)tabPressed:(UITapGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [gesture locationInView:self];
        NSInteger index = point.x / self.tabWidth;
        
        if (index == self.currentIndex) {
            [self.tabBarDelegate rsTabBar:self didSelectedIndex:self.currentIndex];
            return;
        }
        if (index >= self.tabCount) {
            return;
        }
        if (![self.tabBarDelegate canChangeToIndex:index]) {
            return;
        }
        
        ZJTabbarItem* oldView = (ZJTabbarItem*)[self viewWithTag:self.currentIndex+100];
        if ([oldView isKindOfClass:[ZJTabbarItem class]]) {
            [oldView setActive:NO];
        }
        
        [self.tabBarDelegate rsTabBar:self unSelectedIndex:self.currentIndex];
        
        self.currentIndex = index;
        
        ZJTabbarItem* itemView = (ZJTabbarItem*)[self viewWithTag:self.currentIndex+100];
        if ([itemView isKindOfClass:[ZJTabbarItem class]]) {
            [itemView setActive:YES];
        }
        
        [self.tabBarDelegate rsTabBar:self didSelectedIndex:self.currentIndex];
    }
    
}
- (void)setChangeToIndex:(NSInteger)index{
    if (index >= self.tabCount) {
        return;
    }
    if(self.currentIndex != index){
        
        ZJTabbarItem* oldView = (ZJTabbarItem*)[self viewWithTag:self.currentIndex+100];
        if ([oldView isKindOfClass:[ZJTabbarItem class]]) {
            [oldView setActive:NO];
        }
        
        [self.tabBarDelegate rsTabBar:self unSelectedIndex:self.currentIndex];
        self.currentIndex = index;
        
        ZJTabbarItem* itemView = (ZJTabbarItem*)[self viewWithTag:self.currentIndex+100];
        if ([itemView isKindOfClass:[ZJTabbarItem class]]) {
            [itemView setActive:YES];
        }
        
        [self.tabBarDelegate rsTabBar:self didSelectedIndex:self.currentIndex];
    }else{
        [self.tabBarDelegate rsTabBar:self didSelectedIndex:self.currentIndex];
    }
}
- (void)setCount:(NSInteger)count index:(NSInteger)index{
    ZJTabbarItem* itemView = (ZJTabbarItem*)[self viewWithTag:index+100];
    if (count > 0) {
        [itemView showUnreadCountLabel:count];
    }else{
        [itemView hideUnreadCountLabel];
    }
    
}
    
- (void)showRedDotWithIndex:(NSInteger)index{
    ZJTabbarItem* itemView = (ZJTabbarItem*)[self viewWithTag:index+100];
    [itemView showRedDotView];
}
- (void)hideRedDotWithIndex:(NSInteger)index{
    ZJTabbarItem* itemView = (ZJTabbarItem*)[self viewWithTag:index+100];
    [itemView hideRedDotView];
}
    
@end
