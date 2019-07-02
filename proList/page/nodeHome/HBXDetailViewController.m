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


@interface HBXDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation HBXDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
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
    NSLog(@"cellHeight: %f", item.cellHeight);
    return item.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    HBXHomeListCell *object = nil;
//    NSArray *array = self.dataArray[indexPath.section];
//    object = [array objectAtIndex:indexPath.row];
//
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
    //    [((HBXMyTableViewCell *)cell) hideSepLine: (array.count - 1 == indexPath.row)];
    
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

@end