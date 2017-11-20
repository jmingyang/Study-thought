//
//  ViewController.m
//  Study&thought
//
//  Created by lucid on 2017/11/19.
//  Copyright © 2017年 Gooou. All rights reserved.
//

#import "ViewController.h"
#import "mainTableViewCell.h"
#import "UIColor+Hex.h"
#import "BasisViewController.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize mainTable;
@synthesize bigPlanArr;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 62)];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.text = @"Study & thought";
    titleLab.textColor = [UIColor colorWithHexString:@"#333333"];
    titleLab.textAlignment = NSTextAlignmentLeft;
    [titleLab setFont:[UIFont fontWithName:@"CourierNewPSMT" size:24.0]];
    self.navigationController.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 5);
    self.navigationController.navigationBar.layer.shadowOpacity = 0.2;
    self.navigationController.navigationBar.layer.shadowRadius = 8;
    self.navigationController.navigationBar.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.navigationController.navigationBar.bounds].CGPath;
    self.navigationItem.titleView = titleLab;
    
    mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.showsVerticalScrollIndicator = NO;
//    mainTable.allowsSelection = NO;
    mainTable.scrollEnabled = NO;
    [mainTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:mainTable];
    
    bigPlanArr = @[@"iOS基础内容学习",@"iOS独立程序练习",@"网校APP项目代码串讲"];
}

#pragma mark --UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (self.view.bounds.size.height-64)/3;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier= @"Cell";
    mainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[mainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.titleLab.text = bigPlanArr[indexPath.row];
        [cell addCellPressBlock:^{
            NSLog(@"dasihfiahiafsdiifoasd");
        }];
    }
    return cell;
}
#pragma mark --UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell点击");
    BasisViewController *basPage = [[BasisViewController alloc] init];
    [self.navigationController pushViewController:basPage animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
