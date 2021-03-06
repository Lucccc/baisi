//
//  GLTabBar.m
//  百思不得姐
//
//  Created by Lucccc on 16/4/27.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLTabBar.h"
#import "GLPublishViewController.h"
@interface GLTabBar()
/**
 *  发布按钮
 */
@property (nonatomic,weak)UIButton *publishButton;

@end

@implementation GLTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        //设置tabbar的背景图片
         [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        //添加加号
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        //添加点击事件
        [publishButton addTarget:self action:@selector(publishButtonClick) forControlEvents:UIControlEventTouchUpInside];
       //设置按钮frame
        publishButton.size = publishButton.currentBackgroundImage.size;
        [self addSubview:publishButton];
       
        self.publishButton = publishButton;
    }
    return self;
}

-(void)publishButtonClick{
    GLPublishViewController *publishVC = [[GLPublishViewController alloc]init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVC animated:NO completion:nil];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    //设置发布按钮的frame
//    self.publishButton.width = self.publishButton.currentBackgroundImage.size.width;
//    self.publishButton.height =self.publishButton.currentBackgroundImage.size.height;
       self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    //设置其他的UITabbarbutton 的frame
    
    NSInteger index = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    for (UIView *button in self.subviews) {
        if(![button isKindOfClass:NSClassFromString(@"UITabBarButton")])continue;
        CGFloat buttonX = buttonW * ((index > 1)?(index+1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index ++;
        
    }
}
@end
