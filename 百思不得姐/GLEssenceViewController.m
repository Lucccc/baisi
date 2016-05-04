//
//  GLEssenceViewController.m
//  百思不得姐
//
//  Created by Lucccc on 16/4/26.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLEssenceViewController.h"
#import "GLRecommendTagsViewController.h"

@interface GLEssenceViewController ()

@end

@implementation GLEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置导航栏内容
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航栏左边内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    //设置背景颜色
    self.view.backgroundColor = GLGlobalBg;
    
    
    
}



-(void)tagClick{
   
    GLRecommendTagsViewController *tagVC = [[GLRecommendTagsViewController alloc]init];
    [self.navigationController pushViewController:tagVC animated:YES];
    
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
