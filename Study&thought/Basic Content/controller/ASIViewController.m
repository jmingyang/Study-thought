//
//  ASIViewController.m
//  Study&thought
//
//  Created by lucid on 2017/11/28.
//  Copyright © 2017年 Gooou. All rights reserved.
//

#import "ASIViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "UIColor+Hex.h"
#import "Masonry.h"

@interface ASIViewController ()

@end

@implementation ASIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 62)];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.text = @"ASIHttpRequest";
    titleLab.textColor = [UIColor colorWithHexString:@"#333333"];
    titleLab.textAlignment = NSTextAlignmentLeft;
    [titleLab setFont:[UIFont fontWithName:@"CourierNewPSMT" size:24.0]];
    self.navigationController.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 5);
    self.navigationController.navigationBar.layer.shadowOpacity = 0.2;
    self.navigationController.navigationBar.layer.shadowRadius = 8;
    self.navigationController.navigationBar.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.navigationController.navigationBar.bounds].CGPath;
    self.navigationItem.titleView = titleLab;
    
    UIButton *btn1 = [UIButton new];
    btn1.backgroundColor = [UIColor blackColor];
    [btn1 setTitle:@"Get" forState:UIControlStateNormal];
    [btn1 setTintColor:[UIColor whiteColor]];
    [btn1 addTarget:self action:@selector(getFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {//使用第三方框架实现自动布局
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-self.view.bounds.size.height*3/4+50);
    }];
    
    UIButton *btn2 = [UIButton new];
    btn2.backgroundColor = [UIColor blackColor];
    [btn2 setTitle:@"POST" forState:UIControlStateNormal];
    [btn2 setTintColor:[UIColor whiteColor]];
    [btn2 addTarget:self action:@selector(postFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {//使用第三方框架实现自动布局
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-self.view.bounds.size.height*2/4+50);
    }];
    
    UIButton *btn3 = [UIButton new];
    btn3.backgroundColor = [UIColor blackColor];
    [btn3 setTitle:@"Download" forState:UIControlStateNormal];
    [btn3 setTintColor:[UIColor whiteColor]];
    [btn3 addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {//使用第三方框架实现自动布局
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-self.view.bounds.size.height*1/4+50);
    }];
    
//    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8888/"];
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//    [request startSynchronous];
//    NSError *error = [request error];
//    if (!error) {
////        NSString *response = [request responseString];
//        NSString *response = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",response);
//    }
}

- (void)getFunction {
    
}

- (void)postFunction {
    //方法一
//    NSString *urlString = [NSString stringWithFormat:@"http://localhost:3000/users/postpage"];
//    ASIFormDataRequest *requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
//
//    //设置需要POST的数据，这里提交两个数据，A=a&B=b
//    [requestForm setPostValue:@"4:01" forKey:@"time"];
//    [requestForm setPostValue:@"school" forKey:@"place"];
//    [requestForm startSynchronous];
//
//    //输入返回的信息
//    NSLog(@"response\n%@",[requestForm responseString]);//返回nil
    //方法二
    // 创建请求
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/users/postpage"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    // 超时
    request.timeOutSeconds = 5;
    // 请求方法
    request.requestMethod = @"POST";
    // 拼接请求体
    NSData *data = [@"time='4:01'&place='school'" dataUsingEncoding:NSUTF8StringEncoding];
    [request appendPostData:data];
    [request startSynchronous];
    NSLog(@"response\n%@",[request responseString]);
}

- (void)download {
    //创建请求对象
    NSURL *url=[NSURL URLWithString:@"http://localhost:3000/images/1.jpg"];//加自己的地址
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    
    //设置文件保存路径
    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES)lastObject];
    NSString *filename=[cachePath stringByAppendingString:@"1.jpg"];
    request.downloadDestinationPath=filename;
    NSLog(@"%@",filename);
    //发送网络请求（异步）
    [request setDelegate:self];
    [request startAsynchronous];
    
//    NSError *error = [request error];
//    if (!error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            UIImageView *backimg = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:filename]];
//            backimg.contentMode = UIViewContentModeScaleToFill;
//            [self.view insertSubview:backimg atIndex:0];
//        });
//
//    }
    [request setCompletionBlock:^{
        //成功下载提示
        UIImageView *backimg = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:filename]];
        backimg.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        backimg.contentMode = UIViewContentModeCenter;
        [self.view insertSubview:backimg atIndex:0];
    }];
}

-  (void)requestFinished:(ASIHTTPRequest *)request{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    NSData *responseData = [request responseData];
}
-  (void)requestFailed:(ASIHTTPRequest *)request{
    NSError *error = [request error];
}

@end
