//
//  mainTableViewCell.h
//  Study&thought
//
//  Created by lucid on 2017/11/19.
//  Copyright © 2017年 Gooou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mainTableViewCell : UITableViewCell
{
    void (^pressCellBlock)(void);//声明一个block
}
@property (nonatomic,retain) UILabel *titleLab;
@property (nonatomic,retain) UIImageView *clickImg;
- (void)addCellPressBlock:( void (^) (void) ) pressblock;
@end
