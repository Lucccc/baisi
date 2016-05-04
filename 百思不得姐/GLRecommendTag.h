//
//  GLRecommendTag.h
//  百思不得姐
//
//  Created by Lucccc on 16/4/28.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLRecommendTag : NSObject

//图片
@property (nonatomic, copy) NSString *image_list;

//名字
@property (nonatomic, copy) NSString *theme_name;

//订阅数
@property (nonatomic, assign) NSInteger sub_number;
@end
