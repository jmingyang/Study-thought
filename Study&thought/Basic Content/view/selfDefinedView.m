//
//  selfDefinedView.m
//  Study&thought
//
//  Created by lucid on 2017/11/21.
//  Copyright © 2017年 Gooou. All rights reserved.
//

#import "selfDefinedView.h"
#import "Masonry.h"
@implementation selfDefinedView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    //给view里的block赋值
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        UIButton *btn = [UIButton new];
        btn.backgroundColor = [UIColor blackColor];
        [btn setTitle:@"press" forState:UIControlStateNormal];
        [btn setTintColor:[UIColor whiteColor]];
        [btn addTarget:self action:@selector(btnFunc) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {//使用第三方框架实现自动布局
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(40);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(self.mas_bottom).with.offset(-50);
        }];
    }
    return self;

}

- (void)btnFunc {
    [self.delegate delegateFunc];
}

- (void)addViewBlock:( void (^) (void) ) block {
    viewClickBlock = block;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    //在此处使用点击block
    viewClickBlock();
}
@end
