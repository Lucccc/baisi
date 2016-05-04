//
//  GLRecommendTagsViewController.m
//  百思不得姐
//
//  Created by Lucccc on 16/4/28.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLRecommendTagsViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "GLRecommendTag.h"
#import <MJExtension.h>
#import "GLRecommendTagCell.h"

@interface GLRecommendTagsViewController ()

/**
 *  标签数据
 */
@property (nonatomic,strong)NSArray *tags;

@end

static NSString * const GLTagsId  = @"tag";

@implementation GLRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupTableView];
    
    [self loadTags];
   
}

-(void)setupTableView{
    self.title = @"推荐标签";
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GLRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:GLTagsId];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = GLGlobalBg;

}

-(void)loadTags{
    
    //发送请求
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        GLLog(@"%@",responseObject);
        self.tags = [GLRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GLRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:GLTagsId];
    
    cell.recommendTag  = self.tags[indexPath.row];
    
   
   
    return cell;
}



@end
