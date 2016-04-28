//
//  GLRecommendCategory.m
//  百思不得姐
//
//  Created by Lucccc on 16/4/28.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLRecommendCategory.h"
#import <MJExtension.h>

@implementation GLRecommendCategory

-(NSMutableArray *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName;
{
    return @{
             @"ID" : @"id",
             };
}


@end
