//
//  GLRecommendViewController.m
//  百思不得姐
//
//  Created by Lucccc on 16/4/27.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "GLRecommendTypeCell.h"
#import <MJExtension.h>
#import "GLRecommendCategory.h"
#import "GLRecommendUserCell.h"
#import "GLRecommendUser.h"
#import <MJRefresh.h>
#define GLSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface GLRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 *  右侧的用户列表
 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/**
 *  左边的类别表格
 */

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/**
 *  左边的类别数据
 */
@property (nonatomic,strong)NSArray *categories;
/**
 *  请求参数
 */
@property (nonatomic,strong)NSDictionary *params;
/**
 *  AFN的请求管理者
 */
@property (nonatomic,strong)AFHTTPSessionManager *manager;

@end

@implementation GLRecommendViewController

static NSString * const GLCategoryId = @"category";
static NSString * const GLUserId = @"user";

-(AFHTTPSessionManager *)manager{
    if(!_manager){
        _manager = [AFHTTPSessionManager manager];
    }
    
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //控件的初始化
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
    
    
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        GLLog(@"%@", responseObject);
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        //服务器返回json数据
        
        self.categories = [GLRecommendCategory mj_objectArrayWithKeyValuesArray: responseObject[@"list"]] ;
        
        //刷新表格
        [self.categoryTableView reloadData];
        
        //默认选中第一行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        //第一次选择刷新
        [self.userTableView.mj_header beginRefreshing];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //显示失败信息
        //隐藏指示器
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
}

-(void)setupTableView{
    //注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([GLRecommendTypeCell class]) bundle:nil] forCellReuseIdentifier:GLCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([GLRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:GLUserId];
    
    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    self.title = @"推荐关注";
    //设置背景颜色
    self.view.backgroundColor = GLGlobalBg;
}

-(void)setupRefresh{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    //添加刷新控件
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
}



#pragma mark--加载用户数据
-(void)loadNewUsers{
    GLLogFunc;
    
    GLRecommendCategory *rc = GLSelectedCategory;
    
    //设置当前页码为1
    rc.currentPage = 1;
    //发送请求给服务器，加载右侧数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = rc.ID;
    params[@"page"] = @(rc.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        GLLog(@"%@",responseObject);
        NSArray *users = [GLRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //清除所有旧数据
        [rc.users removeAllObjects];
        
        //添加到当前类别对应的用户组
        [rc.users addObjectsFromArray:users];
        
        //保存总数
        rc.total = [responseObject[@"total"] integerValue];
        
        //判断是不是最后一次请求
        if(self.params != params) return;
        
        //刷新右边表格
        [self.userTableView reloadData];
        
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        
        //让底部控件结束刷新
        [self checkFooterState];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(self.params != params) return;
        GLLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        
    }];
    
}


-(void)loadMoreUsers{
    GLLogFunc;
    GLRecommendCategory *category = GLSelectedCategory;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = category.ID;
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        GLLog(@"%@",responseObject);
        NSArray *users = [GLRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //添加到当前类别对应的用户组
        [category.users addObjectsFromArray:users];
        
        //判断是不是最后一次请求
        if(self.params != params) return;
        
        //刷新右边表格
        [self.userTableView reloadData];
        
        //让底部控件结束刷新
        [self checkFooterState];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(self.params != params) return;
        GLLog(@"%@",error);
        //提醒
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        
        //让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
        
    }];
    
}

//时刻监测footer的状态
-(void)checkFooterState{
    GLRecommendCategory *c = GLSelectedCategory;
    
    //每次刷新右边数据时，都控制footer的显示或隐藏
    self.userTableView.mj_footer.hidden = (c.users.count == 0);
    
    if(c.users.count == c.total){//全部加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        //让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categoryTableView) {//左边的类别表格
        return self.categories.count;
    }else{//右边的用户表格
        //监测footer状态
        [self checkFooterState];
        
        //左边被选中的类别模型
        return [GLSelectedCategory users].count;

    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //左边的类别表格
    if (tableView == self.categoryTableView) {
        GLRecommendTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:GLCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
    }else{//右边的类别表格
        GLRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:GLUserId];
        cell.user = [GLSelectedCategory users][indexPath.row];
        return cell;
    }
    
}

#pragma mark Tableview的代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    GLRecommendCategory *c = self.categories[indexPath.row];
    GLLog(@"%@",c.name);
    //结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    
    if (c.users.count) {
        //显示曾经数据
        [self.userTableView reloadData];
        
        }else{
        
            //马上刷新表格，马上显示当前category的用户数据，不要让用户看到残留数据
            [self.userTableView reloadData];
    
            //进入下拉刷新状态
            [self.userTableView.mj_header beginRefreshing];
           
        }
    
    
}

#pragma mark --控制器的销毁
-(void)dealloc{
    //停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}


@end
