//
//  mainTableViewCell.m
//  Study&thought
//
//  Created by lucid on 2017/11/19.
//  Copyright © 2017年 Gooou. All rights reserved.
//

#import "mainTableViewCell.h"
#import "UIColor+Hex.h"
#import "Masonry.h"
@implementation mainTableViewCell
@synthesize titleLab;
@synthesize clickImg;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //大标题
        titleLab = [UILabel new];
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.textColor = [UIColor colorWithHexString:@"#666666"];
        titleLab.textAlignment = NSTextAlignmentCenter;
        [titleLab setFont:[UIFont fontWithName:@"CourierNewPS-BoldMT" size:24.0]];
        [self.contentView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {//使用第三方框架实现自动布局
            make.centerY.mas_equalTo(self.contentView.mas_centerY).with.offset(-10);
            make.width.mas_equalTo(self.contentView.mas_width);
            make.height.mas_equalTo(50);
        }];
        //touch
        UILabel *bottomlab = [UILabel new];
        bottomlab.backgroundColor = [UIColor clearColor];
        bottomlab.text = @"touch for enter";
        bottomlab.textColor = [UIColor colorWithHexString:@"#999999"];
        bottomlab.textAlignment = NSTextAlignmentRight;
        bottomlab.adjustsFontSizeToFitWidth = YES;
        [bottomlab setFont:[UIFont fontWithName:@"Courier" size:14.0]];
        [self.contentView addSubview:bottomlab];
        [bottomlab mas_makeConstraints:^(MASConstraintMaker *make) {//使用第三方框架实现自动布局
            make.height.mas_equalTo(20);
            make.right.mas_equalTo(self.contentView.mas_right).with.offset(-50);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-20);
        }];
        //touch
        clickImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clickhand1"]];
        [self.contentView addSubview:clickImg];
        [clickImg mas_makeConstraints:^(MASConstraintMaker *make) {//使用第三方框架实现自动布局
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
            make.right.mas_equalTo(self.contentView.mas_right).with.offset(-10);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-10);
        }];
        //分割线
        UIView *bottomLine = [UIView new];
        bottomLine.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
        [self.contentView addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {//使用第三方框架实现自动布局
            make.height.mas_equalTo(1);
            make.width.mas_equalTo(self.contentView.mas_width);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
    }
    return self;
}

- (void)addCellPressBlock:( void (^) (void) ) pressblock{
    pressCellBlock = pressblock;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
//    NSLog(@"touch开始");
//    for(UITouch *touch in [event touchesForView:clickImg]) {
//        pressCellBlock();
//    }
//    //在此处使用点击block
//}
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesEnded:touches withEvent:event];
//    NSLog(@"touch结束");
//    //在此处使用点击block
//}
@end
