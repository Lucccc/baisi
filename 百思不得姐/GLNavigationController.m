//
//  GLNavigationController.m
//  百思不得姐
//
//  Created by Lucccc on 16/4/27.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLNavigationController.h"

@implementation GLNavigationController
/**
 *  当第一次使用这个类时会调用
 */
+(void)initialize{
    
    //只有在glnavigation中才会设置
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18]}];
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    
    //self.navigationBar.tintColor = [UIColor blueColor];
    
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    //设置所有push控制器的 返回按钮
    if (self.childViewControllers.count > 0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
        //让按钮内部所有内容左对齐
        button.contentHorizontalAlignment  = UIControlContentHorizontalAlignmentLeft;
        //[button sizeToFit];
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
         viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    }
    viewController.hidesBottomBarWhenPushed = YES;
    //这句super的push要放在后面，让viewcontroller可以覆盖上面设置的leftbarbuttonItem
    [super pushViewController:viewController animated:animated];
    viewController.hidesBottomBarWhenPushed =NO;
    
   
    
}

-(void)back{
    [self popViewControllerAnimated:YES];
}

@end
