//
//  GLTopicCell.m
//  百思不得姐
//
//  Created by Lucccc on 16/5/16.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLTopicCell.h"
#import <UIImageView+WebCache.h>
#import "GLTopic.h"
#import "GLTopicPictureView.h"

@interface GLTopicCell ()
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *name;
/**
 *  创建时间
 */
@property (weak, nonatomic) IBOutlet UILabel *createTime;
/**
 *  顶数量
 */
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
/**
 *  踩数量
 */
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
/**
 *  转发数量
 */
@property (weak, nonatomic) IBOutlet UIButton *repostBtn;
/**
 *  评论数量
 */
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
/**
 *  新浪加v
 */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
/**
 *  帖子中的文字内容
 */
@property (weak, nonatomic) IBOutlet UILabel *myTextLable;
/**
 *  图片帖子中间的内容
 */
@property (nonatomic,weak)GLTopicPictureView *pictureView;
@end

@implementation GLTopicCell

-(GLTopicPictureView *)pictureView{
    if (!_pictureView) {
        GLTopicPictureView *pictureView = [GLTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
        
    }
    return _pictureView;
}

-(void)awakeFromNib{
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

-(void)setTopic:(GLTopic *)topic{
    _topic = topic;
    
   
    
    self.sinaVView.hidden = !topic.sina_v;
   
    //设置头像
    [self.profileImage sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置昵称
    self.name.text = topic.name;
    
    //设置时间
    self.createTime.text = topic.create_time;
    
    
    //设置工具栏
    [self setupButtonTitle:self.dingBtn count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiBtn count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostBtn count:topic.repost placeholder:@"转发"];
    [self setupButtonTitle:self.commentBtn count:topic.comment placeholder:@"评论"];
    
    //设置文字
    self.myTextLable.text = topic.text;
    
    //根据帖子类型添加对应内容到cell中间
    if (topic.type == GLTopicTypePicture ) {//图片帖子
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureViewFrame;
    }
}

/**
 *  设置工具栏标题
 *
 *  @param button      传入按钮
 *  @param count       数据
 *  @param placeholder 如果没有数据显示文字
 */
-(void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder{
    
    NSString *title = nil;
    if (count > 10000) {
        title = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }else if (count == 0){
    
        title = placeholder;
    }else{
        title = [NSString stringWithFormat:@"%zd",count];
    }
    
    [button setTitle:title forState:UIControlStateNormal];
}

-(void)setFrame:(CGRect)frame{
    frame.origin.x = GLTopicMargin;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= GLTopicMargin;
    frame.origin.y += GLTopicMargin;
    
    [super setFrame:frame];
    
}
@end
