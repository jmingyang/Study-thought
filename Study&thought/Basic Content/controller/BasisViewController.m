//
//  BasisViewController.m
//  Study&thought
//
//  Created by lucid on 2017/11/20.
//  Copyright © 2017年 Gooou. All rights reserved.
//

#import "BasisViewController.h"
#import "UIColor+Hex.h"
#import "Masonry.h"
#import "FMDBViewController.h"
#import "ASIViewController.h"

@interface BasisViewController ()
//@property (nonatomic, retain) CAShapeLayer *shapelayer;
//@property (nonatomic, retain) UIBezierPath *bezierPath;
//@property (nonatomic, retain) CABasicAnimation *pathAnimation;
@end

@implementation BasisViewController
//@synthesize shapelayer;
//@synthesize bezierPath;
//@synthesize pathAnimation;
//static int x = 100;
//static int y = 100;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 62)];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.text = @"iOS基础内容学习";
    titleLab.textColor = [UIColor colorWithHexString:@"#333333"];
    titleLab.textAlignment = NSTextAlignmentLeft;
    [titleLab setFont:[UIFont fontWithName:@"CourierNewPSMT" size:24.0]];
    self.navigationController.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 5);
    self.navigationController.navigationBar.layer.shadowOpacity = 0.2;
    self.navigationController.navigationBar.layer.shadowRadius = 8;
    self.navigationController.navigationBar.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.navigationController.navigationBar.bounds].CGPath;
    self.navigationItem.titleView = titleLab;
    
    //提示
    UILabel *lab1 = [UILabel new];
    lab1.text = @"点击灰色view触发block事件";
    [self.view addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {//使用第三方框架实现自动布局
        make.height.mas_equalTo(30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_top).with.offset(150);
    }];
    UILabel *lab2 = [UILabel new];
    lab2.text = @"点击黑色按钮触发delegate事件";
    [self.view addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {//使用第三方框架实现自动布局
        make.height.mas_equalTo(30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_top).with.offset(200);
    }];
    
    //自定义的view，view自定义的方法中传入block
    selfDefinedView *self_defView = [[selfDefinedView alloc] initWithFrame:CGRectMake(200, 200, 200, 200)];
    [self_defView addViewBlock:^ {
        NSLog(@"使用block实现自定义view的事件");
        infoLab.text = @"使用block实现自定义view的事件";
    }];
    self_defView.delegate = self;//view的代理
    [self.view addSubview:self_defView];
    [self_defView mas_makeConstraints:^(MASConstraintMaker *make) {//使用第三方框架实现自动布局
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(200);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).with.offset(50);
    }];
    
    //点击后的提示
    infoLab = [UILabel new];
    [self.view addSubview:infoLab];
    [infoLab mas_makeConstraints:^(MASConstraintMaker *make) {//使用第三方框架实现自动布局
        //        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self_defView.mas_top).with.offset(-50);
    }];

    UIButton *btn = [UIButton new];
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitle:@"go FMDB" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(gotoFMDB) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {//使用第三方框架实现自动布局
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(self.view.mas_centerX).with.offset(-100);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-50);
    }];
    
    UIButton *btn1 = [UIButton new];
    btn1.backgroundColor = [UIColor blackColor];
    [btn1 setTitle:@"go ASI" forState:UIControlStateNormal];
    [btn1 setTintColor:[UIColor whiteColor]];
    [btn1 addTarget:self action:@selector(gotoASI) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {//使用第三方框架实现自动布局
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(self.view.mas_centerX).with.offset(100);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-50);
    }];
//    shapelayer = [CAShapeLayer new];
//    shapelayer.fillColor = [UIColor whiteColor].CGColor;
//    shapelayer.strokeColor = [UIColor blackColor].CGColor;//边框颜色
//    shapelayer.lineWidth = 10.f;//边框的宽度
//    [self.view.layer addSublayer:shapelayer];
//
//    bezierPath = [UIBezierPath new];
//    [bezierPath moveToPoint:CGPointMake(x, y)];
////    [bezierPath addLineToPoint:CGPointMake(100, 200)];
////    [bezierPath addLineToPoint:CGPointMake(200, 200)];
////    [bezierPath addLineToPoint:CGPointMake(400, 200)];
////    [bezierPath closePath];//将起点与结束点相连接
////    shapelayer.path = bezierPath.CGPath;
//
//    pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation.duration = 1.0;
//    pathAnimation.repeatCount = 1;
//    pathAnimation.removedOnCompletion = YES;
//    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
//    // 设置动画代理，动画结束时添加一个标签，显示折线终点的信息
//    pathAnimation.delegate = self;
////    [self.shapelayer addAnimation:pathAnimation forKey:@"strokeEnd"];
//
//    UIButton *btn = [UIButton new];
//    btn.backgroundColor = [UIColor blackColor];
//    [btn setTitle:@"press" forState:UIControlStateNormal];
//    [btn setTintColor:[UIColor whiteColor]];
//    [btn addTarget:self action:@selector(drawLine) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {//使用第三方框架实现自动布局
//        make.width.mas_equalTo(50);
//        make.height.mas_equalTo(30);
//        make.right.mas_equalTo(self.view.mas_centerX).with.offset(-50);
//        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-50);
//    }];
    
}

- (void)gotoFMDB {
    FMDBViewController *fmdbPage = [FMDBViewController new];
    [self.navigationController pushViewController:fmdbPage animated:NO];
}

- (void)gotoASI {
    ASIViewController *asiPage = [ASIViewController new];
    [self.navigationController pushViewController:asiPage animated:NO];
}

- (void)delegateFunc {
    NSLog(@"使用delegate实现自定义view的事件");
    infoLab.text = @"使用delegate实现自定义view的事件";
}

//- (void)drawLine {
//    x+=100;
//    y+=100;
//    [bezierPath addLineToPoint:CGPointMake(x, y)];
//    shapelayer.path = bezierPath.CGPath;
//    [self.shapelayer addAnimation:pathAnimation forKey:@"strokeEnd"];
//}

@end
