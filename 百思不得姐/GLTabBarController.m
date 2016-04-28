//
//  GLTabBarController.m
//  百思不得姐
//
//  Created by Lucccc on 16/4/26.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLTabBarController.h"
#import "GLMeViewController.h"
#import "GLNewViewController.h"
#import "GLEssenceViewController.h"
#import "GLFriendTrendsViewController.h"
#import "GLTabBar.h"
#import "GLNavigationController.h"

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
    [self setupChilVC:[[GLEssenceViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon"  selectedImage:@"tabBar_essence_click_icon" ];
    [self setupChilVC:[[GLNewViewController alloc]init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setupChilVC:[[GLFriendTrendsViewController alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupChilVC:[[GLMeViewController alloc]init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    //更换tabBar
    [self setValue:[[GLTabBar alloc]init] forKey:@"tabBar"];
   
    
    
//    UIViewController *vc01 = [[UIViewController alloc]init];
//    vc01.tabBarItem.title = @"精华";
//    //设置字体
////    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
////    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
////    attrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
////    [vc01.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
//    vc01.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
////显示黑色
////    UIImage *image = [UIImage imageNamed:@"tabBar_essence_click_icon"];
////    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
////    vc01.tabBarItem.selectedImage = image;
//    vc01.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
//    vc01.view.backgroundColor = [UIColor redColor];
//    [self addChildViewController:vc01];
//    
//    UIViewController *vc02 = [[UIViewController alloc]init];
//    vc02.tabBarItem.title = @"新帖";
//    vc02.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
//    vc02.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
//    vc02.view.backgroundColor = [UIColor grayColor];
//    [self addChildViewController:vc02];
//    
//    UIViewController *vc03 = [[UIViewController alloc]init];
//    vc03.tabBarItem.title = @"关注";
//    vc03.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
//    vc03.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
//    vc03.view.backgroundColor = [UIColor greenColor];
//    [self addChildViewController:vc03];
//    
//    UIViewController *vc04 = [[UIViewController alloc]init];
//    vc04.tabBarItem.title = @"我";
//    vc04.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
//    vc04.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
//    vc04.view.backgroundColor = [UIColor blueColor];
//    [self addChildViewController:vc04];

    
    
}
/**
 *  初始化子控制器
 *
 */
-(void)setupChilVC: (UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
   
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    //vc.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    
    
    //包装一个导航控制器 添加导航控制器tabbarcontroller的子控制器
    GLNavigationController *nav = [[GLNavigationController alloc]initWithRootViewController:vc];
    
    //设置导航背景颜色
    
    [self addChildViewController:nav];

    
}

@end
