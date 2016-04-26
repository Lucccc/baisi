//
//  GLTabBarController.m
//  百思不得姐
//
//  Created by Lucccc on 16/4/26.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLTabBarController.h"

@implementation GLTabBarController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //通过apperance统一设置UITabbarItem文字属性
    //方法后面带有UI_APPERANCE_SELECTOR的方法都可以通过apperance对象设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];

    NSMutableDictionary *selectedattrs = [NSMutableDictionary dictionary];
    selectedattrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedattrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedattrs forState:UIControlStateSelected];
    //添加子控制器
    UIViewController *vc01 = [[UIViewController alloc]init];
    vc01.tabBarItem.title = @"精华";
    //设置字体
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
//    attrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
//    [vc01.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    vc01.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
//显示黑色
//    UIImage *image = [UIImage imageNamed:@"tabBar_essence_click_icon"];
//    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc01.tabBarItem.selectedImage = image;
    vc01.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    vc01.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:vc01];
    
    UIViewController *vc02 = [[UIViewController alloc]init];
    vc02.tabBarItem.title = @"新帖";
    vc02.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    vc02.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    vc02.view.backgroundColor = [UIColor grayColor];
    [self addChildViewController:vc02];
    
    UIViewController *vc03 = [[UIViewController alloc]init];
    vc03.tabBarItem.title = @"关注";
    vc03.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    vc03.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    vc03.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:vc03];
    
    UIViewController *vc04 = [[UIViewController alloc]init];
    vc04.tabBarItem.title = @"我";
    vc04.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    vc04.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    vc04.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:vc04];

    
    
}

@end
