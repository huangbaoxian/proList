//
//  HBXModelListViewController.m
//  proList
//
//  Created by huangbaoxian on 2019/7/4.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXModelListViewController.h"
#import "HBXGoalTableViewCell.h"
#import "HBXGoalModel.h"
#import "HBXDetailViewController.h"
#import "NoteListViewController.h"


@interface HBXModelListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIBarButtonItem *rightBtnItem;

@end

@implementation HBXModelListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的计划";
    [self initViews];
    self.navigationItem.rightBarButtonItem = self.rightBtnItem;
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self initData];
}

- (void)initData {
    NSArray *storyList = [ToolHelper getModelList];
    if (storyList.count > 0) {
        NSArray *list = [HBXGoalModel mj_objectArrayWithKeyValuesArray:storyList];
        
        if (!list || [list count] == 0) {
            [self showEmptViewWithMessage:@"暂无内容" view:self.tableView];
        }else {
            [self hideEmptView];
        }
        
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:list];
        [self.tableView reloadData];                        
    }else {
        if (!storyList || [storyList count] == 0) {
            [self showEmptViewWithMessage:@"暂无内容" view:self.tableView];
        }else {
            [self hideEmptView];
        }
    }
}

- (void)creatNewRecord {
    NoteListViewController *vc = [[NoteListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupNavBar {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:AppFont(18), NSForegroundColorAttributeName:SYS_White_Color}];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage getImageWithColor:AppHTMLColor(@"4bccbc")] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        HBXGoalModel *item = self.dataArray[indexPath.row];
    return item.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *list = [ToolHelper getNoteList];
    NSDictionary *param = list[indexPath.row];
//    HBXDetailViewController *vc = [[HBXDetailViewController alloc] initWithParam:param];
//    [AppNavigator pushViewController:vc animated:YES];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id object = self.dataArray[indexPath.row];
    
    HBXGoalTableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:[HBXGoalTableViewCell className]];
    if (cell == nil) {
        cell = [[HBXGoalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:[HBXGoalTableViewCell className]];
    }
    //    [((HBXMyTableViewCell *)cell) hideSepLine: (array.count - 1 == indexPath.row)];
    
    [cell cellHeightWithItem:object];
    return cell;
}


- (void)initViews{
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.view.height - PHONE_CUSTOM_TABBAR_HEIGHT);
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = NO;
    
}



- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UIBarButtonItem *)rightBtnItem {
    if (!_rightBtnItem) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"新建" forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 50, 30);
        [btn addTarget:self action:@selector(creatNewRecord) forControlEvents:UIControlEventTouchUpInside];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    return _rightBtnItem;
}


@end
