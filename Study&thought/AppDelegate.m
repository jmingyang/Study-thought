//
//  AppDelegate.m
//  Study&thought
//
//  Created by lucid on 2017/11/19.
//  Copyright © 2017年 Gooou. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self creatDatabase];
    [self fillDataToTable];
    
    ViewController *root = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
    self.window.rootViewController = nav;
    
    return YES;
}

- (void)creatDatabase {
    //1.获得数据库文件的路径
//    _dbPath = [[NSBundle mainBundle] pathForResource:@"Database" ofType:@"sqlite"];
    NSString *_docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //设置数据库名称
    NSString *_dbPath = [_docPath stringByAppendingPathComponent:@"Database.sqlite"];
    [[NSUserDefaults standardUserDefaults] setObject:_dbPath forKey:@"datapath"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"数据库地址：%@",_dbPath);
    //2.获取数据库
    _db = [FMDatabase databaseWithPath:_dbPath];
    if ([_db open]) {
        NSLog(@"创建或打开已有数据库成功");
        //3.创建表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_foods (id integer PRIMARY KEY AUTOINCREMENT, FoodsCodeId text NOT NULL, FoodsChiName text NOT NULL,AttachCategory text NOT NULL);"];
        if (result) {
            NSLog(@"创建表成功，设置版本号！");
            NSInteger version_ = [[NSUserDefaults standardUserDefaults] integerForKey:@"Database_version"];
            if (!version_) {
                [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:@"Database_version"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            NSLog(@"当前版本号为：%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"Database_version"]);
        } else {
            NSLog(@"创建表失败");
        }
    } else {
        NSLog(@"打开数据库失败");
    }
}

- (void)fillDataToTable {
    NSError *error;
    NSString *_foodPath = [[NSBundle mainBundle] pathForResource:@"foodinfo" ofType:@"json"];
    NSDictionary *_foodDic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:_foodPath] options:NSJSONReadingMutableLeaves error:&error];
    NSArray *arr = _foodDic[@"Food"];
    int countNum = 0;
    for(int i = 0;i<arr.count;i++) {
        NSDictionary *dic = arr[i];
        NSArray *array = @[dic[@"FoodsCodeId"],dic[@"FoodsChiName"],dic[@"AttachCategory"]];
        //插入数据
        BOOL result = [_db executeUpdate:@"INSERT INTO t_foods(FoodsCodeId, FoodsChiName, AttachCategory) VALUES  (?,?,?);" withArgumentsInArray:array];
        if (result) {
//            NSLog(@"插入成功");
            countNum++;
        } else {
            NSLog(@"插入失败");
        }
    }
    NSLog(@"成功插入%d条数据",countNum);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
