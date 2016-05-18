//
//  GLTopicCell.h
//  百思不得姐
//
//  Created by Lucccc on 16/5/16.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLTopic;
@interface GLTopicCell : UITableViewCell
/**
 *  帖子数据
 */
@property (nonatomic, strong) GLTopic *topic;

@end
