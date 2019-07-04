//
//  HBXImageBrowserManager.m
//  proList
//
//  Created by huangbaoxian on 2019/7/4.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXImageBrowserManager.h"
#import "MWPhotoBrowser.h"
@interface HBXImageBrowserManager ()

@property (strong, nonatomic) NSMutableArray *photos;
@property (nonatomic, assign) BOOL isShowEditButton;
@property (nonatomic, strong) UIImage *editImage;
@property (nonatomic, assign) BOOL rotate;
@property (nonatomic, assign) BOOL isShowLandScpace;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation HBXImageBrowserManager

- (void)handleImageArray:(NSArray *)imageArray {
    [self.photos removeAllObjects];
    
    if (imageArray.count > 0) {
        for (id data in imageArray ) {
            MWPhoto *photo = nil;
            if ( [data isKindOfClass:[NSString class]] ) {
                photo = [[MWPhoto alloc] initWithURL:[NSURL URLWithString:data]];
            }else if([data isKindOfClass:[UIImage class]] ){
                photo = [[MWPhoto alloc] initWithImage:data];
            }
            [self.photos addObject:photo];
        }
    }
}

- (void)handleImageArray:(NSArray *)imageArray index:(int)index {
    [self handleImageArray:imageArray];
    [self showPhotoBrowser:index];
}

- (void)showPhotoBrowser:(int)index {
    
        MWPhotoBrowser *browser = [self creatPhotoBrowser:index];
        UINavigationController* naVC = [[UINavigationController alloc] initWithRootViewController:browser];
        naVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [AppNavigator showModalViewController:naVC animated:YES];
}

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return [self.photos count];
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < self.photos.count)
    {
        return [self.photos objectAtIndex:index];
    }
    
    return nil;
}


- (NSMutableArray *)photos {
    if (!_photos) {
        _photos = [[NSMutableArray alloc] init];
    }
    return _photos;
}



- (MWPhotoBrowser *)creatPhotoBrowser:(int)index {
    MWPhotoBrowser *  _photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    _photoBrowser.displayActionButton = YES;
    _photoBrowser.displayNavArrows = YES;
    _photoBrowser.disPlayRotateImage = self.rotate;
    _photoBrowser.displaySelectionButtons = NO;
    _photoBrowser.alwaysShowControls = NO;
    _photoBrowser.wantsFullScreenLayout = YES;
    _photoBrowser.isShowPageContol = YES;
    _photoBrowser.zoomPhotosToFill = YES;
    _photoBrowser.enableGrid = NO;
    _photoBrowser.startOnGrid = NO;
//    _photoBrowser.disPlayEditButton = _isShowEditButton;
    [_photoBrowser setCurrentPhotoIndex:index];
    return _photoBrowser;
}

@end
