//
//  AppDelegate.h
//  Study&thought
//
//  Created by lucid on 2017/11/19.
//  Copyright © 2017年 Gooou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    FMDatabase *_db;
    NSString *_dbPath;
}
@property (strong, nonatomic) UIWindow *window;


@end

