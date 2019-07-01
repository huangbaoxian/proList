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

@interface MyViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) MyHeaderView *headView;
    
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  initViews];
    // Do any additional setup after loading the view.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
    
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataArray[section];
    return array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJMySettingItem *item = nil;
    NSArray *array = self.dataArray[indexPath.section];
    item = [array objectAtIndex:indexPath.row];
    return item.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZJMySettingItem *object = nil;
    NSArray *array = self.dataArray[indexPath.section];
    object = [array objectAtIndex:indexPath.row];
//    if ([object isKindOfClass:[ZJMySettingItem class]]) {
//        ZJMySettingItem *item = object;
//        if (item.pageType == ZJPageWrongBook) {
//
//            NSString *value = [[MisManager shared] ZJGetValueForKey:iSSCANWRONGBOOK];
//            if (!value  || value.length == 0) {
//                [[MisManager shared] ZJSetValue:@"1" key:iSSCANWRONGBOOK];
//                [self.tableView reloadData];
//            }
//        }
//        if (item.selectedBlock) {
//            item.selectedBlock(nil);
//        }
//    }else if ([object isKindOfClass:[ZJMySetHeadItem class]]){
//        [self gotoMyInfo];
//    }
}
   
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id object = nil;
    NSMutableArray *array = self.dataArray[indexPath.section];
    object = array[indexPath.row];
    
    HBXMyTableViewCell *cell = nil;

    cell = [tableView dequeueReusableCellWithIdentifier:[HBXMyTableViewCell className]];
    if (cell == nil) {
        cell = [[HBXMyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:[HBXMyTableViewCell className]];
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
    
    self.headView = [[MyHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 120)];
    self.tableView.tableHeaderView = self.headView;
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
