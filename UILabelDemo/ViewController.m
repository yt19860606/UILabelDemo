//
//  ViewController.m
//  UILabelDemo
//
//  Created by zhongpingjiang on 16/9/12.
//  Copyright © 2016年 shaoqing. All rights reserved.
//

#import "ViewController.h"
#import "QSShowTextCell.h"
#import "UIColor+BgColor.h"

static NSString * const kShowTextCellReuseIdentifier = @"QSShowTextCell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.navigationItem.title = @"UILableDemo";
    
    self.dataSource = [NSArray arrayWithObjects:
                       @"1)我是一只小小小鸟,2)我是一只小小小鸟",
                       @"1)我是一只小小小鸟,2)我是一只小小小鸟,3)我是一只小小小鸟,4)我是一只小小小鸟,5)我是一只小小小鸟,6)我是一只小小小鸟。",
                       @"1)我是一只小小小鸟,2)我是一只小小小鸟,3)我是一只小小小鸟,4)我是一只小小小鸟,5)我是一只小小小鸟,6)我是一只小小小鸟,7)我是一只小小小鸟,8)我是一只小小小鸟,9)我是一只小小小鸟。",
                       @"1)我是一只小小小鸟,2)我是一只小小小鸟,3)我是一只小小小鸟,4)我是一只小小小鸟,5)我是一只小小小鸟,6)我是一只小小小鸟,7)我是一只小小小鸟,8)我是一只小小小鸟,9)我是一只小小小鸟。10)我是一只小小小鸟,11)我是一只小小小鸟,12)我是一只小小小鸟。",nil];
    
    self.view.backgroundColor = [UIColor colorWithRGB:0xf3f3f7];
    [self.view addSubview:self.tableView];
}


- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [QSShowTextCell cellHeightWithText:[self p_textAtIndexPath:indexPath]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return [self.dataSource count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return 0.01f;
    }
    return 10.00f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    QSShowTextCell *cell = [tableView dequeueReusableCellWithIdentifier:kShowTextCellReuseIdentifier];
    if (!cell) {
        
        cell = [[QSShowTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kShowTextCellReuseIdentifier];
    }
    [cell layoutSubviewsWithText:[self p_textAtIndexPath:indexPath]];
    return cell;

}

- (NSString *)p_textAtIndexPath:(NSIndexPath *)indexPath{

    return [self.dataSource objectAtIndex:indexPath.section];
}





@end
