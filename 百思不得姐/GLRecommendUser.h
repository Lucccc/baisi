//
//  GLRecommendUser.h
//  百思不得姐
//
//  Created by Lucccc on 16/4/28.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLRecommendUser : NSObject
//头像
@property (nonatomic, copy) NSString *header;
//粉丝数量
@property (nonatomic, assign) NSInteger fans_count;
//昵称
@property (nonatomic, copy) NSString *screen_name;


@end
