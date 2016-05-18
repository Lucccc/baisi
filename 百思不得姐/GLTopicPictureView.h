//
//  GLTopicPictureView.h
//  百思不得姐
//
//  Created by Lucccc on 16/5/17.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GLTopic;

@interface GLTopicPictureView : UIView
/**
 *  帖子数据模型
 */
@property (nonatomic, strong) GLTopic *topic;

+(instancetype)pictureView;

@end
