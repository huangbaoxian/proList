//
//  HBXDetailViewController.m
//  proList
//
//  Created by huangbaoxian on 2019/7/2.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXDetailViewController.h"
#import "HBXHomeListCell.h"
#import "ZJHomdeListModel.h"
#import "HBXCreatNoteViewController.h"
#import "HBXNoteDetailCell.h"
#import "GKPhotoBrowser.h"
#import "HBXImageBrowserManager.h"


@interface HBXDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableDictionary *param;
@property (nonatomic, strong) HBXImageBrowserManager *manager;

@end

@implementation HBXDetailViewController

- (instancetype)initWithParam:(NSDictionary *)param {
    if (self = [super init]) {
        _param = [NSMutableDictionary dictionaryWithDictionary:param];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    if (self.param.count > 0) {
        NSArray *data = [ZJHomdeListModel mj_objectArrayWithKeyValuesArray:self.param[@"list"]];
        [self.dataArray addObjectsFromArray:data];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
    
    // Do any additional setup after loading the view.
}

- (void)addModel:(ZJHomdeListModel *)model {
    [self.dataArray addObject:model];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJHomdeListModel *item = self.dataArray[indexPath.row];
    return item.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    ZJHomdeListModel *item = self.dataArray[indexPath.row];
    NSMutableArray *itemArray = [NSMutableArray array];
    
    int index = 0;
    
    for (int i = 0 ; i < self.dataArray.count; i++) {
        ZJHomdeListModel *data = self.dataArray[i];
        if (data.type == HBXEditTypeImage) {
             UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:data.content];
            if (image) {
                [itemArray addObject:image];
            }
            if([item.content isEqualToString:data.content]) {
                index = i;
            }
        }
    }    
    [self.manager handleImageArray:itemArray index:index];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJHomdeListModel *object = nil;
    object = self.dataArray[indexPath.row];
    HBXNoteDetailCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:[HBXNoteDetailCell className]];
    if (cell == nil) {
        cell = [[HBXNoteDetailCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:[HBXNoteDetailCell className]];
    }
    [cell cellHeightWithItem:object];
    return cell;
}


- (void)initViews{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.view.height - PHONE_CUSTOM_TABBAR_HEIGHT);
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.top.equalTo(self.view);
    }];
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

- (HBXImageBrowserManager *)manager {
    if (!_manager) {
        _manager = [[HBXImageBrowserManager alloc] init];
    }
    return _manager;
}
@end
