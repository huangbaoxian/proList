//
//  HBXEditNoteViewController.m
//  proList
//
//  Created by huangbaoxian on 2019/7/2.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXEditNoteViewController.h"

@interface HBXEditNoteViewController ()

@property (nonatomic, strong) UITextField *titleFiled;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *toolBar;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIButton *confirmButton;
    
@end

@implementation HBXEditNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor  whiteColor];
    [self creatSubView];
    // Do any additional setup after loading the view.
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
    
    self.titleFiled.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 10)];
    self.titleFiled.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.confirmButton];
    self.confirmButton.frame = CGRectMake(15, self.container.bottom + 15, self.view.width - 30, 34);
    self.confirmButton.layer.masksToBounds = YES;
    self.confirmButton.layer.cornerRadius = 8;
    self.confirmButton.layer.borderWidth = 1.0;
    self.confirmButton.layer.borderColor = [UIColorFromRGB(0x4bccbc) CGColor];
    
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
            self.imageView.image = [UIImage imageNamed:@"add_wrong_book_btn"];
        }
        
        break;
        
        
        default:
        break;
    }
}
    
- (void)confirmButtonClick:(UIButton *)sender {
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
