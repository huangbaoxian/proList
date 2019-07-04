//
//  NoteListViewController.m
//  proList
//
//  Created by huangbaoxian on 2019/7/1.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "NoteListViewController.h"
#import "HBXActionModel.h"
#import "HBXActionHeaderModel.h"
#import "HBXGoalSettingViewController.h"


#define VIEWHEIGHT 50
#define VIEWSPACE 10

@interface NoteListViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) NSMutableArray  *dataArray;

@end

@implementation NoteListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"controllerConfig" ofType:@"json"];
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    NSError *error = nil;
    NSDictionary *dict  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    NSArray *array = dict[@"links"];
//    NSLog(@"%@", array);
    
    for (NSDictionary *dict in array) {
        HBXActionHeaderModel *model = [[HBXActionHeaderModel alloc] init];
        model.title = dict[@"title"];
        model.data = [HBXActionModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        [self.dataArray addObject:model];
    }
    
    //mj_objectArrayWithKeyValuesArray
    [self creatSubViews];
    // Do any additional setup after loading the view.
}

- (void)creatSubViews {
    [self.view addSubview:self.scrollView];
//    [self.scrollView addSubview:self.container];
    
    NSLog(@"%@", self.dataArray);
    
    CGFloat viewHeight = 0;
    for (int i = 0; i < self.dataArray.count; i++) {
        viewHeight += VIEWHEIGHT;
        HBXActionHeaderModel *model = self.dataArray[i];
        
        NSInteger count =model.data.count/2;
        if(model.data.count %2 > 0) {
            count++;
        }
        CGFloat he = count * VIEWHEIGHT + (count - 1) * VIEWSPACE;
        viewHeight += he;
    }
    
    
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, viewHeight);
    
    CGFloat originY = 0;
    CGFloat viewWidth = (self.view.width - 45)/2;
    viewHeight = 0;
    
    NSInteger index = 1;
    for (int i =0 ; i < self.dataArray.count; i++) {
        HBXActionHeaderModel *model = self.dataArray[i];
        UIView *containerView = [[UIView alloc] init];
        containerView.backgroundColor = [UIColor whiteColor];
        viewHeight += VIEWHEIGHT;
        NSInteger count =model.data.count/2;
        if(model.data.count %2 > 0) {
            count++;
        }
        CGFloat he = count * VIEWHEIGHT + (count - 1) * VIEWSPACE;
        viewHeight = he;
        containerView.frame = CGRectMake(0, originY, SCREEN_WIDTH, viewHeight);
        [self.scrollView addSubview:containerView];
        
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH - 60, VIEWHEIGHT)];
        headLabel.textColor = UIColorFromRGB(0x333333);
        headLabel.font = [UIFont systemFontOfSize: 14.0];
        [containerView addSubview:headLabel];
        headLabel.backgroundColor = [UIColor whiteColor];
        headLabel.text = model.title;
        
        for (int k = 0; k< model.data.count; k++) {
            HBXActionModel *subModel = model.data[k];
            UIView *itemView = [self getItemViewWithModel:subModel];
            itemView.frame = CGRectMake(15 + (k % 2) * (viewWidth + VIEWSPACE),VIEWHEIGHT + k/2 *  (VIEWHEIGHT + 10) , viewWidth, VIEWHEIGHT);
            [containerView addSubview:itemView];
            index++;
            subModel.index = index;
            itemView.tag = index;
            itemView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGuest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
            [itemView addGestureRecognizer:tapGuest];
            
        }
        originY += viewHeight;
    }
    
    
}

- (void)tapClick:(UITapGestureRecognizer *)sender {
    NSLog(@"%d", sender.view.tag);
    
    HBXActionModel *param = nil;
    for (HBXActionHeaderModel *model in self.dataArray) {
        for (HBXActionModel *subModel in model.data) {
            if (subModel.index == sender.view.tag) {
                param = subModel;
                HBXGoalSettingViewController *vc = [[HBXGoalSettingViewController alloc] initWithModel:param];
                [AppNavigator pushViewController:vc animated:YES];
                break;
                return;
            }
        }
    }
    
}



- (UIView *)getItemViewWithModel:(HBXActionModel *)model {
    CGFloat viewWidth = (self.view.width - 45)/2;
    CGFloat viewHeight = VIEWHEIGHT;
    
    UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    itemView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    UIImageView *headView = [[UIImageView alloc] init];
    [itemView addSubview:headView];
    
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont systemFontOfSize:14.0];
    title.textColor = UIColorFromRGB(0x333333);
    [itemView addSubview:title];
    
    UILabel *desc = [[UILabel alloc] init];
    desc.font = [UIFont systemFontOfSize:14.0];
    desc.textColor = UIColorFromRGB(0x666666);
    [itemView addSubview:desc];
    
    
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(itemView);
        make.leading.equalTo(itemView).offset(15);
        make.width.height.mas_equalTo(40);
    }];
    headView.layer.masksToBounds = YES;
    headView.layer.cornerRadius = 20;
    
    headView.image  = [UIImage imageNamed:model.imageSel];
    title.text = model.name;
    desc.text = model.time;
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(itemView).offset(-10);
        make.leading.equalTo(headView.mas_trailing).offset(15);
    }];
    
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(itemView).offset(5);
        make.leading.equalTo(headView.mas_trailing).offset(15);
    }];
    
    itemView.layer.masksToBounds = YES;
    itemView.layer.cornerRadius  = 2;

    return itemView;
}

- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] init];
//        _container.backgroundColor =
    }
    return _container;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
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
