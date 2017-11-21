//
//  selfDefinedView.h
//  Study&thought
//
//  Created by lucid on 2017/11/21.
//  Copyright © 2017年 Gooou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol selfDefinedViewDelegate <NSObject>
- (void)delegateFunc;
@end

@interface selfDefinedView : UIView
{
    void (^viewClickBlock)(void);//声明一个block
}
- (void)addViewBlock:( void (^) (void) ) block;
@property(nonatomic, weak) id<selfDefinedViewDelegate> delegate;
@end


