//
//  GLFriendTrendsViewController.m
//  百思不得姐
//
//  Created by Lucccc on 16/4/26.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLFriendTrendsViewController.h"
#import "GLRecommendViewController.h"

@interface GLFriendTrendsViewController ()

@end


@implementation GLFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置导航栏内容
    self.navigationItem.title = @"我的关注";

    //设置导航栏左边内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    //设置背景颜色
    self.view.backgroundColor = GLGlobalBg;
    

}



-(void)friendsClick{
    GLLog(@"%s",__func__);
    GLRecommendViewController *vc = [[GLRecommendViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
