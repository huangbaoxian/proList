//
//  HBXHisHomeViewController.m
//  proList
//
//  Created by huangbaoxian on 2019/7/1.
//  Copyright © 2019 黄保贤. All rights reserved.
//

#import "HBXHisHomeViewController.h"
#import "HBXHomeListCell.h"
#import "ZJHomdeListModel.h"
#import "HBXCreatNoteViewController.h"

@interface HBXHisHomeViewController ()
    
@property (nonatomic, strong) UITableView *tableView;
    
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIBarButtonItem *rightBtnItem;
    
@end

@implementation HBXHisHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavBar];
    self.navigationItem.rightBarButtonItem = self.rightBtnItem;
}
- (void)setupNavBar {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:AppFont(18), NSForegroundColorAttributeName:SYS_White_Color}];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage getImageWithColor:AppHTMLColor(@"4bccbc")] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)creatNewRecord {
    HBXCreatNoteViewController *vc = [[HBXCreatNoteViewController alloc] init];
    [AppNavigator pushViewController:vc animated:YES];
}
    
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
    
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataArray[section];
    return array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJHomdeListModel *item = nil;
    NSArray *array = self.dataArray[indexPath.section];
    item = [array objectAtIndex:indexPath.row];
    return item.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HBXHomeListCell *object = nil;
    NSArray *array = self.dataArray[indexPath.section];
    object = [array objectAtIndex:indexPath.row];
    
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id object = nil;
    NSMutableArray *array = self.dataArray[indexPath.section];
    object = array[indexPath.row];
    
    HBXHomeListCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:[HBXHomeListCell className]];
    if (cell == nil) {
        cell = [[HBXHomeListCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:[HBXHomeListCell className]];
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
    
    
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end