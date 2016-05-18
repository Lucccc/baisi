//
//  GLTopic.h
//  百思不得姐
//
//  Created by Lucccc on 16/5/16.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLTopic : NSObject

/**
 *  名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  头像的路径
 */
@property (nonatomic, copy) NSString *profile_image;

/**
 *  发帖时间
 */
@property (nonatomic, copy) NSString *create_time;

/**
 *  文字内容
 */
@property (nonatomic, copy) NSString *text;

/**
 *  顶的数量
 */
@property (nonatomic, assign) NSInteger ding;

/**
 *  踩的数量
 */
@property (nonatomic, assign) NSInteger cai;

/**
 *  转发的数量
 */
@property (nonatomic, assign) NSInteger repost;

/**
 *  评论的数量
 */
@property (nonatomic, assign) NSInteger comment;
/**
 *  是否为新浪v
 */
@property (nonatomic, assign,getter = issina_v) BOOL sina_v;
/**
 *  图片的宽度
 */
@property (nonatomic, assign) CGFloat width;
/**
 *  图片的高度
 */
@property (nonatomic, assign) CGFloat height;
/**
 *  图片的路径
 */
@property (nonatomic, copy) NSString *small_image;
@property (nonatomic, copy) NSString *middle_image;
@property (nonatomic, copy) NSString *large_image;

/**
 *  帖子的类型
 */
@property (nonatomic, assign) GLTopicType type;

//------------------------------额外的辅助属性
/**
 *  cell的高度
 */
@property (nonatomic, assign,readonly) CGFloat cellHeight;
/**
 *  图片控件的frame
 */
@property (nonatomic, assign,readonly) CGRect pictureViewFrame;
/**
 *  图片是否过大
 */
@property (nonatomic, assign, getter=istooBigPicture) BOOL tooBigPicture;
/**
 *  图片下载进度
 */
@property (nonatomic, assign) CGFloat pictureProgress;

@end
