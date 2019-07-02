//
//  HBXEditNoteViewController.m
//  proList
//
//  Created by huangbaoxian on 2019/7/2.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXEditNoteViewController.h"
#import "ZJHomdeListModel.h"
#include <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "HBXDetailViewController.h"

@interface HBXEditNoteViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UITextField *titleFiled;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *toolBar;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) HBXEditType editType;
@property (nonatomic, strong) UIButton *addImageButton;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIBarButtonItem *rightBtnItem;
@property (nonatomic, strong) HBXDetailViewController *detailVC;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *detailTitle;
@property (nonatomic, strong) NSString *signImage;

    
@end

@implementation HBXEditNoteViewController

- (instancetype)initWithDate:(NSString *)date {
    if (self = [super init]) {
        _date = date;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor  whiteColor];
    [self creatSubView];
    self.navigationItem.rightBarButtonItem = self.rightBtnItem;
    // Do any additional setup after loading the view.
}

- (void)creatNewRecord {
    
    NSMutableArray *storeArray = [[NSMutableArray alloc] init];
    for (ZJHomdeListModel *model in self.dataArray) {
        NSDictionary *dict = [model mj_keyValues];
        [storeArray addObject:dict];
    }
    NSMutableDictionary *record = [NSMutableDictionary dictionary];
    record[@"list"] = storeArray;
    record[@"date"] = self.date ?: @"";
    record[@"title"] = self.detailTitle;
    record[@"image"] = self.signImage;
    [ToolHelper saveNote:record];
    
    NSLog(@"storeArray: %@", storeArray);
    
}
    
- (void)creatSubView {
    [self.view addSubview:self.toolBar];
    self.toolBar.frame = CGRectMake(0, 15, self.view.width , 40);
    
    [self addToolBarSubView];
    
    [self.view addSubview:self.container];
    self.container.frame = CGRectMake(15, self.toolBar.bottom + 15, self.view.width - 30, 120);
    
    
    [self.container addSubview:self.titleFiled];
    [self.container addSubview:self.textView];
    [self.container addSubview:self.imageView];
    [self.imageView addSubview:self.addImageButton];
    
    
    self.titleFiled.frame = self.container.bounds;
    self.textView.frame = self.container.bounds;
    self.imageView.frame = self.container.bounds;
    self.textView.hidden = YES;
    self.imageView.hidden = YES;
    
    

    self.titleFiled.layer.masksToBounds = YES;
    self.titleFiled.layer.cornerRadius = 8;
    self.titleFiled.layer.borderWidth = 1.0;
    self.titleFiled.layer.borderColor = [UIColorFromRGB(0x4bccbc) CGColor];
    
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 8;
    self.textView.layer.borderWidth = 1.0;
    self.textView.layer.borderColor = [UIColorFromRGB(0x4bccbc) CGColor];
    
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 8;
    self.imageView.layer.borderWidth = 1.0;
    self.imageView.layer.borderColor = [UIColorFromRGB(0x4bccbc) CGColor];
    self.imageView.userInteractionEnabled = YES;
    self.titleFiled.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 10)];
    self.titleFiled.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.confirmButton];
    self.confirmButton.frame = CGRectMake(15, self.container.bottom + 15, self.view.width - 30, 34);
    self.confirmButton.layer.masksToBounds = YES;
    self.confirmButton.layer.cornerRadius = 8;
    self.confirmButton.layer.borderWidth = 1.0;
    self.confirmButton.layer.borderColor = [UIColorFromRGB(0x4bccbc) CGColor];
    
    self.addImageButton.frame = CGRectMake((self.imageView.width - 80)/2, (self.imageView.height - 80)/2, 80, 80);

    self.detailVC = [[HBXDetailViewController alloc] init];
    [self addChildViewController:self.detailVC];
    [self.view addSubview:self.detailVC.view];
    self.detailVC.view.frame = CGRectMake(0 , self.confirmButton.bottom + 30, self.view.width, self.view.height - self.confirmButton.bottom - 30 - 10);
    
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.addImageButton.hidden = _image;
}

- (void)addImageButtonClick:(UIButton *)sender {
    WeakSelf
    [ZJAlertManager showAlertVtitle:@""
                            message:@""
                       comfirmTitle:@"拍照"
                        cancelTitle:@"选择照片"
                              style:UIAlertControllerStyleActionSheet
                      comfirmAction:^(id param) {
                          [weakSelf takePhotoFromCamera];
                      } cancleAction:^(id param) {
                          [weakSelf takePhotoFromLibrary];
                      }];
    
}

- (void)btnClick:(UIButton *)btn {
    self.titleFiled.hidden = YES;
    self.textView.hidden = YES;
    self.imageView.hidden = YES;

    switch (btn.tag - 1000) {
        case HBXEditTypeTitle: {
             self.titleFiled.hidden = NO;
        }
        
        break;
        case HBXEditTypeContent: {
            self.textView.hidden = NO;
        }
        
        break;
        case HBXEditTypeImage: {
            self.imageView.hidden = NO;
        }
        
        break;
        default:
        break;
    }
    self.editType = btn.tag - 1000;
}
    
- (void)confirmButtonClick:(UIButton *)sender {
    ZJHomdeListModel *model = [[ZJHomdeListModel alloc] init];
    model.type = self.editType;
    switch (self.editType) {
        case HBXEditTypeTitle:
        {
            if(self.titleFiled.text.length == 0) return;
            if(!self.detailTitle) {
                self.detailTitle = self.titleFiled.text;
            }
            model.content = self.titleFiled.text;
        }
            break;
        case HBXEditTypeContent:
        {
            if(self.textView.text.length == 0) return;
            model.content = self.textView.text;
        }
            break;
        case HBXEditTypeImage:
        {
            if(!self.image)return;
            
            NSString *url = [NSString stringWithFormat:@"http://localhost/%f.jpg",[[NSDate date] timeIntervalSinceNow]];
            model.content = url;
            [[SDImageCache sharedImageCache] storeImage:self.image forKey:url toDisk:YES completion: nil];
                                    
            model.type = HBXEditTypeImage;
            model.imageWidth = self.image.size.width;
            model.imageHeight = self.image.size.height;
            if (!self.signImage) {self.signImage = url;}
            
        }
            break;
        default:
            break;
    }
    
    [self.dataArray addObject:model];
    [self.detailVC addModel:model];
    
    self.textView.text = @"";
    self.imageView.image = nil;
    self.titleFiled.text = @"";
}



- (void)addToolBarSubView {
    NSArray *array = @[@"标题",@"内容",@"图片"];
    CGFloat btnWith = (self.view.width - 30 - 15 * (array.count - 1))/array.count;
    CGFloat btnHeight = 25;
    CGFloat space = 15;
    
    self.toolBar.userInteractionEnabled = YES;
   
    for (int i = 0 ; i < array.count; i++) {
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        btn.tag = i + 1000;
        [self.toolBar addSubview:btn];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 12.5;
        btn.layer.borderWidth = 1.0;
        btn.layer.borderColor = [UIColorFromRGB(0x4bccbc) CGColor];
        btn.frame = CGRectMake(15 + i *(btnWith + space), 7.5, btnWith, btnHeight);
    }
}

#pragma mark pickerViewDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *_uploadImage = info[UIImagePickerControllerOriginalImage];
    if (_uploadImage) {
        [self handleImage:_uploadImage];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)handleImage:(UIImage *)image {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage * completeImage = [image fixOrientation];
        CGFloat cropWidth = completeImage.size.width;
        if (cropWidth > 1080) {
            cropWidth = 1080;
        }
        
        CGFloat cropHeight =  cropWidth *completeImage.size.height/completeImage.size.width;
        WeakSelf
        completeImage = [UIImage scaleToSize:completeImage size:CGSizeMake(cropWidth, cropHeight)];
        completeImage = [UIImage compressImage:completeImage maxLength:cropWidth*cropHeight];
      
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.imageView.image = completeImage;
            weakSelf.image = completeImage;
            
        });
    });
}


- (void)takePhotoFromCamera {
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
//    [self presentViewController:self.imagePicker animated:YES completion:nil];
    [AppNavigator showModalViewController:self.imagePicker animated:YES];
}



- (void)takePhotoFromLibrary {
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
//    [self presentViewController:self.imagePicker animated:YES completion:nil];
    [AppNavigator showModalViewController:self.imagePicker animated:YES];
}



- (UIBarButtonItem *)rightBtnItem {
    if (!_rightBtnItem) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"保存" forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 50, 30);
        [btn addTarget:self action:@selector(creatNewRecord) forControlEvents:UIControlEventTouchUpInside];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    return _rightBtnItem;
}
    
- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] init];
    }
    return _container;
}
    
    
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}
    
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:14.0];
        _textView.textColor = UIColorFromRGB(0x333333);
    }
    return _textView;
}
- (UITextField *)titleFiled {
    if (!_titleFiled) {
        _titleFiled = [[UITextField alloc] init];
        _titleFiled.font = [UIFont systemFontOfSize:14.0];
        _titleFiled.textColor = UIColorFromRGB(0x333333);
        _titleFiled.placeholder = @"请输入标题";
    }
    return _titleFiled;
}

- (UIView *)toolBar {
    if (!_toolBar) {
        _toolBar = [[UIView alloc] init];
    }
    return _toolBar;
}
    
- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:UIColorFromRGB(0x4bccbc)  forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UIButton *)addImageButton {
    if (!_addImageButton) {
        _addImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addImageButton setImage:[UIImage imageNamed:@"add_wrong_book_btn"] forState: UIControlStateNormal];
        [_addImageButton addTarget:self action:@selector(addImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addImageButton;
}



- (UIImagePickerController *)imagePicker
{
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.modalPresentationStyle= UIModalPresentationOverFullScreen;
        _imagePicker.delegate = self;
    }
    
    return _imagePicker;
}

@end
