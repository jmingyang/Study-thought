//
//  FMDBViewController.h
//  Study&thought
//
//  Created by lucid on 2017/11/22.
//  Copyright © 2017年 Gooou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
@interface FMDBViewController : UIViewController
{
    FMDatabase *_db;
    NSString *_dbPath;
    FMDatabaseQueue *myQueue;
}
@property (nonatomic,strong) NSMutableArray *upgradeOrderArr;
@end
