//
//  GLTopicViewController.m
//  百思不得姐
//
//  Created by Lucccc on 16/5/13.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLTopicViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "GLTopic.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "GLTopicCell.h"

@interface GLTopicViewController ()
/**
 *  帖子数据
 */
@property (nonatomic,strong)NSMutableArray *topics;
/**
 * 当加载下一页时需要这个参数
 */
@property (nonatomic,copy)NSString *maxtime;
/**
 *当前页码
 */
@property (nonatomic,assign)NSInteger *page;

@end

@implementation GLTopicViewController

-(NSMutableArray *)topics{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化表格
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
    
}

static NSString * const GLTopicCellId = @"topic";

-(void)setupTableView{
    
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = GLTitlesViewH + GLTitlesViewY;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GLTopicCell class]) bundle:nil] forCellReuseIdentifier:GLTopicCellId];
    
}

-(void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    //自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    // self.tableView.mj_footer.hidden = YES;
}

#pragma mark －数据处理
/**
 *  加载新的帖子
 */
-(void)loadNewTopics{
    
    //页码
    self.page = 0;
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = self.type;
    
    //发送请求
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        GLLog(@"%@",responseObject);
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典转模型
        self.topics = [GLTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        GLLog(@"%@",error);
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

/**
 *  加载更多帖子数据
 */
-(void)loadMoreTopics{
    
    //结束下啦刷新
    [self.tableView.mj_header endRefreshing];
    
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = self.type;
    NSInteger page = self.page + 1;
    params[@"page"] = [NSString stringWithFormat:@"%zd",page];
    params[@"maxtime"] = self.maxtime;
    
    //发送请求
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        GLLog(@"%@",responseObject);
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典转模型
        NSArray *newtopics = [GLTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newtopics];
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        //设置页码
        self.page = page;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        GLLog(@"%@",error);
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GLTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:GLTopicCellId];
    
    cell.topic  = self.topics[indexPath.row];
    
    
    return cell;
}

#pragma mark -算行高代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //取出帖子模型
    GLTopic *topic = self.topics[indexPath.row];
    
    //返回模型帖子高度
    
    return topic.cellHeight;
}
@end
