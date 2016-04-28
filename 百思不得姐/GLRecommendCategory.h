//
//  GLRecommendCategory.h
//  百思不得姐
//
//  Created by Lucccc on 16/4/28.
//  Copyright © 2016年 Lucccc. All rights reserved.
//左边的推荐数据模型

#import <Foundation/Foundation.h>

@interface GLRecommendCategory : NSObject
/**
 *  id
 */
@property (nonatomic, copy) NSString *ID;

/**
 *  name
 */
@property (nonatomic, copy) NSString *name;
/**
 *  count
 */
@property (nonatomic, assign) NSInteger count;

//当前类别的数组
@property (nonatomic, strong) NSMutableArray *users;

//总数
@property (nonatomic, assign) NSInteger total;

//当前页码
@property (nonatomic, assign) NSInteger currentPage;




@end
