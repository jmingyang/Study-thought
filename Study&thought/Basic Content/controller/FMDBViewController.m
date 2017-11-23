//
//  FMDBViewController.m
//  Study&thought
//
//  Created by lucid on 2017/11/22.
//  Copyright © 2017年 Gooou. All rights reserved.
//

#import "FMDBViewController.h"
#import "UIColor+Hex.h"

@interface FMDBViewController ()

@end

@implementation FMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 62)];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.text = @"FMDB";
    titleLab.textColor = [UIColor colorWithHexString:@"#333333"];
    titleLab.textAlignment = NSTextAlignmentLeft;
    [titleLab setFont:[UIFont fontWithName:@"CourierNewPSMT" size:24.0]];
    self.navigationController.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 5);
    self.navigationController.navigationBar.layer.shadowOpacity = 0.2;
    self.navigationController.navigationBar.layer.shadowRadius = 8;
    self.navigationController.navigationBar.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.navigationController.navigationBar.bounds].CGPath;
    self.navigationItem.titleView = titleLab;
    
    [self openDatabase];
}

- (void)openDatabase {
    //1.获得数据库文件的路径
    _dbPath = [[NSBundle mainBundle] pathForResource:@"Database" ofType:@"sqlite"];
    NSLog(@"%@",_dbPath);
    //2.获取数据库
    _db = [FMDatabase databaseWithPath:_dbPath];
    if ([_db open]) {
        NSLog(@"打开数据库成功");
    } else {
        NSLog(@"打开数据库失败");
    }
}
@end
