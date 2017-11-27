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
@synthesize upgradeOrderArr;

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
    
    upgradeOrderArr = [NSMutableArray arrayWithObjects:@"ALTER TABLE t_foods ADD Price integer",
                       @"CREATE TABLE IF NOT EXISTS t_foods_extra (id integer PRIMARY KEY AUTOINCREMENT, FoodsCodeId text NOT NULL,FoodsMode text NOT NULL,Price integer NOT NULL,HolidayPrice integer NOT NULL,Remark text NOT NULL);",
                        nil];
    //@"ALTER TABLE t_foods DROP Remark text",
    [self openDatabase];
    [self upgradeDatabasetoVersion:2];
    
    myQueue = [FMDatabaseQueue databaseQueueWithPath:_dbPath];
    //多线程插入t_foods表中的Price
    [self fillFoodPrice];
    //多线程插入t_foodsextra表数据
    [self fillFoodExtra];
//    [upgradeOrderArr addObject:@"ALTER TABLE t_foods_extra DROP COLUMN Remark"];
//    [self upgradeDatabasetoVersion:3];
}

- (void)openDatabase {
    //1.获得数据库文件的路径
//    _dbPath = [[NSBundle mainBundle] pathForResource:@"Database" ofType:@"sqlite"];
    _dbPath = [[NSUserDefaults standardUserDefaults] objectForKey:@"datapath"];
    NSLog(@"%@",_dbPath);
    //2.获取数据库
    _db = [FMDatabase databaseWithPath:_dbPath];
    if ([_db open]) {
        NSLog(@"打开数据库成功");
//        [_db executeUpdate:@"ALTER TABLE t_foods ADD Price integer"];
    } else {
        NSLog(@"打开数据库失败");
    }
}

- (void)upgradeDatabasetoVersion:(NSInteger)version {
    if(version > upgradeOrderArr.count) {
        NSLog(@"error");
        return;
    }
    NSInteger oldversion = [[NSUserDefaults standardUserDefaults] integerForKey:@"Database_version"];
    if(oldversion < version) {//未升级的版本为0，以后的每次升级+1，数组中的一条指令代表一次升级
        for(NSInteger i = oldversion;i<version;i++){
            [myQueue inDatabase:^(FMDatabase *db) {
                BOOL result = [_db executeUpdate:upgradeOrderArr[i]];
                if (result) {
                    [[NSUserDefaults standardUserDefaults] setObject:@(i+1) forKey:@"Database_version"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    NSLog(@"升级到版本%ld成功",i+1);
                } else {
                    NSLog(@"升级失败");
                }
            }];
        }
    }else if(oldversion == version){
        NSLog(@"已是最新版本！");
    }
    
//    switch (oldVersion) {
//        case 1:
//            NSLog(@"1");
//        case 2:
//            NSLog(@"2");
//        case 3:
//            NSLog(@"3");
//        case 4:
//            NSLog(@"4");
//        default:
//            NSLog(@"default");
//            break;
//    }
    
}

- (void)fillFoodPrice {
    NSError *error;
    NSString *_foodPath = [[NSBundle mainBundle] pathForResource:@"foodinfo" ofType:@"json"];
    NSDictionary *_foodDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:_foodPath] options:NSJSONReadingMutableLeaves error:&error];
    NSArray *arr = _foodDic[@"Food"];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [myQueue inDatabase:^(FMDatabase *db) {
            int countNum = 0;
            for(int i = 0;i<arr.count;i++) {
                NSDictionary *dic = arr[i];
                //插入数据
                BOOL result = [_db executeUpdate:@"update t_foods set Price = ? where FoodsCodeId = ?",dic[@"Price"],dic[@"FoodsCodeId"]];
                if (result) {
                    //NSLog(@"插入成功");
                    countNum++;
                } else {
                    NSLog(@"插入失败");
                }
            }
            NSLog(@"成功更新%d条Price",countNum);
        }];
    });
}

- (void)fillFoodExtra {
    NSError *error;
    NSString *_foodPath = [[NSBundle mainBundle] pathForResource:@"foodinfo" ofType:@"json"];
    NSDictionary *_foodDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:_foodPath] options:NSJSONReadingMutableLeaves error:&error];
    NSArray *arr = _foodDic[@"Food"];
   
//    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:_dbPath];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [myQueue inDatabase:^(FMDatabase *db) {
            int countNum = 0;
            for(int i = 0;i<arr.count;i++) {
                NSDictionary *dic = arr[i];
                NSArray *array = @[dic[@"FoodsCodeId"],dic[@"FoodsMode"],dic[@"Price"],dic[@"HolidayPrice"],dic[@"Remark"]];
                //插入数据
                BOOL result = [_db executeUpdate:@"INSERT INTO t_foods_extra(FoodsCodeId, FoodsMode, Price,HolidayPrice,Remark) VALUES  (?,?,?,?,?);" withArgumentsInArray:array];
                if (result) {
                    countNum++;
                } else {
                    NSLog(@"插入失败");
                }
            }
            NSLog(@"成功插入%d条数据",countNum);
        }];
    });
}
@end
