//
//  ViewController.h
//  Study&thought
//
//  Created by lucid on 2017/11/19.
//  Copyright © 2017年 Gooou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource , UITableViewDelegate> {
    
}
@property (nonatomic, retain) UITableView *mainTable;
@property (nonatomic,strong) NSArray *bigPlanArr;
@end

