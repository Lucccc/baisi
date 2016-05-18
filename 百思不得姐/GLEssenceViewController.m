//
//  GLEssenceViewController.m
//  百思不得姐
//
//  Created by Lucccc on 16/4/26.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLEssenceViewController.h"
#import "GLRecommendTagsViewController.h"
#import "GLAllViewController.h"
#import "GLVideoViewController.h"
#import "GLVoiceViewController.h"
#import "GLPictureViewController.h"
#import "GLWordViewController.h"

@interface GLEssenceViewController ()<UIScrollViewDelegate>
/**
 *  标签栏底部的红色指示器
 */
@property (nonatomic,weak)UIView *indicatorView;
/**
 *  当前选中按钮
 */
@property (nonatomic,weak)UIButton *selectedButton;
/**
 *  顶部所有标签
 */
@property (nonatomic,weak)UIView *titlesView;

/**
 *  内容view
 */
@property (nonatomic,weak)UIScrollView *contentView;

@end

@implementation GLEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化子控制器
    [self setupChildVces];
    
    //设置导航栏
    [self setupNav];
    
    
    
    
    //设置顶部标签栏
    [self setupTitleView];

    //底部的scrollView
    [self setupContentView];
    
    
    
    
}

/**
 *  初始化子控制器
 */
-(void)setupChildVces{
    GLAllViewController *all  = [[GLAllViewController alloc]init];
    [self addChildViewController:all];
    
    GLVoiceViewController *voice  = [[GLVoiceViewController alloc]init];
    [self addChildViewController:voice];
    GLVideoViewController *video  = [[GLVideoViewController alloc]init];
    [self addChildViewController:video];
    GLPictureViewController *picture  = [[GLPictureViewController alloc]init];
    [self addChildViewController:picture];
    GLWordViewController *word  = [[GLWordViewController alloc]init];
    [self addChildViewController:word];
    
}

/**
 *  设置顶部标签栏
 */
-(void)setupTitleView{
    UIView *titlesView = [[UIView alloc]init];
    titlesView.width = self.view.width;
    titlesView.height = GLTitlesViewH;
    titlesView.y = GLTitlesViewY;
    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //底部红色指示器
    UIView *indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.tag = -1;
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    
    self.indicatorView = indicatorView;
    
    
    NSArray *titles = @[@"全部",@"视频 ",@"声音",@"图片",@"段子"];
    CGFloat height = titlesView.height;
    CGFloat width = titlesView.width/titles.count;
    //内部的字标签
    for (NSInteger i = 0; i<titles.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        //[button layoutIfNeeded];//强制布局（更新子控件）
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        //默认点击第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            //让按钮内部的lable根据文字的内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    [titlesView addSubview:indicatorView];
}

-(void)titleClick:(UIButton *)button{
    //修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = self.selectedButton.titleLabel.width;
        self.indicatorView.centerX = self.selectedButton.centerX;
    }];
    
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
    
    
}

/**
 *  设置底部的scrollView
 */
-(void)setupContentView{
    //不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc]init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
    
//    [contentView addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
//    UISwitch *s = [[UISwitch alloc]init];
//    s.y = 800 - s.height;
//    [contentView addSubview:s];
//    
//    contentView.contentSize = CGSizeMake(0, 800);
//    contentView.width = self.view.width;
//    contentView.y = 99;
//    contentView.height = self.view.height - contentView.y - self.tabBarController.tabBar.height;
    
}

/**
 *  设置导航栏
 */
-(void)setupNav{
    
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

#pragma mark - <UIScrollViewDelegate>
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //添加子控制器的view
   
    
    //当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    //取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;//设置view的y值为0（默认为20）
    vc.view.height = scrollView.height;//设置控制器view的height值为整个屏幕高度（默认比屏幕高毒少20）
    
        
    [scrollView addSubview: vc.view];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
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
