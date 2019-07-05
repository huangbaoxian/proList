//
//  ZJAvatarSettingViewController.m
//  proList
//
//  Created by huangbaoxian on 2019/7/4.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "ZJAvatarSettingViewController.h"

@interface ZJAvatarSettingViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIImageView *showImageView;
@property (nonatomic, strong) UIImage *avatorImage;

@property (nonatomic, strong) UIButton *cameraBtn;
@property (nonatomic, strong) UIButton *library;
@property (nonatomic, strong) NSString *avatorUrl;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) UIBarButtonItem *rightBtnItem;

@end

@implementation ZJAvatarSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人头像";
    self.view.backgroundColor = UIColorFromRGB(0xF8F8F8);
    [self initViews];
    [self initRigtItem];
    
    // Do any additional setup after loading the view.
}

- (void)creatNewRecord {
    
    if (!self.avatorImage) {
        [SVProgressHUD showInfoWithStatus:@"请选择一张图片"];
        return;
    }
    
    if (self.isLoading) {
         [SVProgressHUD showInfoWithStatus:@"正在上传"];
        return;
    }
    self.isLoading = YES;
    
    [SVProgressHUD showWithStatus:@""];
    
    
    NSString *url = [NSString stringWithFormat:@"http://localhost/head%f.jpg",[[NSDate date] timeIntervalSinceNow]];
    APPCONTEXT.currentUser.avatarUrl = url;
    
    [[SDImageCache sharedImageCache] storeImage:self.avatorImage forKey:url  completion:nil];
    [SVProgressHUD dismiss];
    
    [APPCONTEXT saveInfo];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)initRigtItem {
    self.navigationItem.rightBarButtonItem = self.rightBtnItem;
}

- (void)initViews {
    [self.view addSubview:self.showImageView];
    [self.view addSubview:self.cameraBtn];
    [self.view addSubview:self.library];
    
    UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:APPCONTEXT.currentUser.avatarUrl];
    self.showImageView.image = image;
    
    
    CGFloat width = SCREEN_WIDTH > SCREEN_HEIGHT ?  SCREEN_HEIGHT :  SCREEN_WIDTH;
    self.showImageView.frame = CGRectMake(0, 0, width, width);
    
    [self.view addSubview: self.cameraBtn];
    [self.view addSubview: self.library];
    
    
    UIView *cameraSuper = [[UIView alloc]initWithFrame:CGRectMake(15, self.showImageView.bottom + 45, width - 30, 45)];
    [self.view addSubview:cameraSuper];
    cameraSuper.layer.shadowColor = [UIColorFromRGB(0xe6e2e8) CGColor];
    cameraSuper.layer.shadowOffset = CGSizeMake(3, 3);
    cameraSuper.layer.shadowOpacity = 1;
    cameraSuper.layer.shadowRadius = 3.0;
    cameraSuper.layer.cornerRadius = 9.0;
    cameraSuper.clipsToBounds = NO;
    [cameraSuper addSubview:self.cameraBtn];
    self.cameraBtn.frame = cameraSuper.bounds;
    
    
    UIView *librarySuper = [[UIView alloc]initWithFrame:CGRectMake(15, cameraSuper.bottom + 20, width - 30, 45)];
    [self.view addSubview:librarySuper];
    librarySuper.layer.shadowColor = [UIColorFromRGB(0xe6e2e8) CGColor];
    librarySuper.layer.shadowOffset = CGSizeMake(3, 3);
    librarySuper.layer.shadowOpacity = 1;
    librarySuper.layer.shadowRadius = 3.0;
    librarySuper.layer.cornerRadius = 9.0;
    librarySuper.clipsToBounds = NO;
    [librarySuper addSubview:self.library];
    self.library.frame = librarySuper.bounds;
    
    self.cameraBtn.layer.cornerRadius = 4.0;
    self.cameraBtn.layer.borderColor = [UIColorFromRGB(0xd4d4d4) CGColor];
    self.cameraBtn.layer.borderWidth = 1.0f;
    
    
    self.library.layer.cornerRadius = 4.0;
    self.library.layer.borderColor = [UIColorFromRGB(0xd4d4d4) CGColor];
    self.library.layer.borderWidth = 1.0f;
    
}

#pragma mark - imagepicker
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    CGFloat width = KUPLOADIMAGEWIDTH;
    CGFloat height = image.size.height * width / image.size.width;
    image = [UIImage scaleToSize:image size:CGSizeMake(width, height)];
    image = [UIImage compressImage:image maxLength:700*700];
    self.avatorImage = image;
    self.showImageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)takePhoto{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [AppNavigator showModalViewController:imagePickerController animated:YES];
}
- (void)choosePic{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [AppNavigator showModalViewController:imagePickerController animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImageView *)showImageView {
    if (!_showImageView) {
        _showImageView = [[UIImageView alloc] init];
        _showImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _showImageView;
}


- (UIButton *)library {
    if (!_library) {
        _library = [UIButton buttonWithType:UIButtonTypeCustom];
        [_library setTitle:@"从相册选一张" forState:UIControlStateNormal];
        [_library setTitleColor:UIColorFromRGB(0x484848) forState:UIControlStateNormal];
        [_library addTarget:self action:@selector(choosePic) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _library;
}

- (UIButton *)cameraBtn {
    
    if (!_cameraBtn) {
        _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraBtn setTitleColor:UIColorFromRGB(0x484848) forState:UIControlStateNormal];
        [_cameraBtn setTitle:@"拍一张照片" forState:UIControlStateNormal];
        [_cameraBtn addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraBtn;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
