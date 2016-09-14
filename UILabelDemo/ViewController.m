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

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.navigationItem.title = @"UILableDemo";
    
    self.dataSource = [[NSMutableArray alloc]initWithObjects:
                       @"sdajfkldsajklfjdsaklfjjkhkjfhklrdjglkdfsjlkgjdf;lskhl;fkjhljfgklhjklfgjhkl;jfdlkhjfgdlkjhkl;fgjkhjfkjsdhkfjskljhsdkjhfskdjfhjklsdjkhfsdhjkfhkjdshfjkdshjkfhdsjkhgjkfdhgjkdfhjkgfdhjkghfdjkhgjkfdshgjkfdhsgjkhdfjkghfdjkhgkjdfshgkjfdshkgjhdfkjghfdkjlhgkfdlhglfdshgkjdfhgkjdlfhgkjlfdhkjlghdfskljghfdkghfkljhgkhlhjklfhkj",
                       @"fuidsahfudhgfhdjsghjje1)我是一只小小小鸟,2)我是一只小小小鸟huihgejrkhgjlkerhguihrewioughrewuioghreuih",
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

    return [self.dataSource count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
    //;
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
//        cell.leftUtilityButtons = [self leftButtons];
        cell.rightUtilityButtons = [self rightButtons];
        cell.delegate = self;
    }
    [cell layoutSubviewsWithText:[self p_textAtIndexPath:indexPath]];
    return cell;

}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"More"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    
    return rightUtilityButtons;
}

- (NSArray *)leftButtons
{
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.07 green:0.75f blue:0.16f alpha:1.0]
                                                icon:[UIImage imageNamed:@"check.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:1.0]
                                                icon:[UIImage imageNamed:@"clock.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0]
                                                icon:[UIImage imageNamed:@"cross.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.55f green:0.27f blue:0.07f alpha:1.0]
                                                icon:[UIImage imageNamed:@"list.png"]];
    
    return leftUtilityButtons;
}


#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            NSLog(@"check button was pressed");
            break;
        case 1:
            NSLog(@"clock button was pressed");
            break;
        case 2:
            NSLog(@"cross button was pressed");
            break;
        case 3:
            NSLog(@"list button was pressed");
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:{
            NSLog(@"More button was pressed");
            UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"More more more" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles: nil];
            [alertTest show];
            
            [cell hideUtilityButtonsAnimated:YES];
        }
            break;
        case 1:
        {
            // Delete button was pressed
            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            [self p_removeTextAtIndexPath:cellIndexPath];
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];

        
            break;
        }
        default:
            break;
    }
}

- (NSString *)p_textAtIndexPath:(NSIndexPath *)indexPath{

    return [self.dataSource objectAtIndex:indexPath.row];
}

- (void)p_removeTextAtIndexPath:(NSIndexPath *)indexPath{
    

    NSLog(@"row = %ld,section = %ld",indexPath.row,indexPath.section);
    [self.dataSource removeObjectAtIndex:indexPath.row];
}





@end
