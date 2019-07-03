//
//  MyViewController.m
//  proList
//
//  Created by huangbaoxian on 2019/7/1.
//  Copyright © 2019 黄保贤. All rights reserved.
//
#import "MyHeaderView.h"
#import "MyViewController.h"
#import "HBXMyTableViewCell.h"
#import "ZJMySettingItem.h"
#import "ZJMySettingItem.h"
#import "MySettingViewController.h"
#import "HBXMessgaeListViewController.h"
#import "HBXFeedViewController.h"


@interface MyViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) MyHeaderView *headView;
    
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  initViews];
//    [self initData];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self initData];
}

- (void)initData {
    NSString *path = nil;
    path = [[NSBundle mainBundle] pathForResource:@"myConfig" ofType:@"json"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    if (dict) {
        [self handleConfig:dict[@"data"]];
    }
   
}

- (void)handleConfig:(NSDictionary *)info {
    if ([info isKindOfClass:[NSDictionary class]]) {
       
        
        NSArray *bottomArray = info[@"itemList"];
        if (bottomArray.count) {
            [self.dataArray removeAllObjects];
            for (NSArray *array in bottomArray) {
                NSMutableArray *source = [NSMutableArray array];
                for (NSDictionary *param in array) {
                    ZJMySettingItem *item = [ZJMySettingItem itemWithDict:param];
                    [source addObject:item];
                }
                if (source.count) {
                    [self.dataArray addObjectsFromArray:source];
                }
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
//    ZJMySettingItem *item = self.dataArray[indexPath.row];
//    NSArray *array = ;
//    item = [array objectAtIndex:indexPath.row];
//    return item.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZJMySettingItem *object = self.dataArray[indexPath.row];
    if (object.type == KSetMessage) {
        HBXMessgaeListViewController *vc = [[HBXMessgaeListViewController alloc] init];
        [AppNavigator pushViewController:vc animated:YES];
    }else if(object.type == kSetFeedBack) {        
        HBXFeedViewController *vc = [[HBXFeedViewController alloc] init];
        [AppNavigator pushViewController:vc animated:YES];
    }

}
   
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id object = self.dataArray[indexPath.row];
   
    HBXMyTableViewCell *cell = nil;

    cell = [tableView dequeueReusableCellWithIdentifier:[HBXMyTableViewCell className]];
    if (cell == nil) {
        cell = [[HBXMyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:[HBXMyTableViewCell className]];
    }
    [cell cellHeightWithItem:object];
    return cell;
}

- (void)headTap {
    MySettingViewController *vc = [[MySettingViewController alloc] init];
    [AppNavigator pushViewController:vc animated:YES];
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
    
    self.headView = [[MyHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 120)];
    self.tableView.tableHeaderView = self.headView;
    
    self.headView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGuest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTap)];
    [self.headView addGestureRecognizer:tapGuest];
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
