//
//  GLTopicPictureView.m
//  百思不得姐
//
//  Created by Lucccc on 16/5/17.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "GLTopic.h"
#import <DALabeledCircularProgressView.h>
#import "GLShowPictureViewController.h"

@interface GLTopicPictureView()
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**
 *  gif标志
 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/**
 *  大图按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation GLTopicPictureView

+(instancetype)pictureView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

-(void)awakeFromNib{
    
    //去除自动resize
    [self setAutoresizingMask:UIViewAutoresizingNone];
    //设置进度条圆角，颜色
    self.progressView.roundedCorners = 2;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    
    //给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture)]];
   
}

-(void)showPicture{
    GLLogFunc;
    GLShowPictureViewController *picVC = [[GLShowPictureViewController alloc]init];
    picVC.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picVC animated:YES completion:nil];
}

-(void)setTopic:(GLTopic *)topic{
    _topic = topic;
    
    //设置数据
    
    //马上显示最新的进度条（防止因网速慢，导致显示其他进度）
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        //计算进度值
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        
        //显示进度值
        [self.progressView setProgress:progress animated:NO];
        NSString *text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
        text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        self.progressView.progressLabel.text = text;
        
        topic.pictureProgress = progress;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        //判断如果是大图片再进行绘图处理
        if (topic.istooBigPicture == NO) return ;
        
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureViewFrame.size, YES, 0.0);
        //将下载完的图片截取至图形上下文
        CGFloat width = topic.pictureViewFrame.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        //获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        //结束图形上下文
        UIGraphicsEndImageContext();
    }];
    
    //判断是否为gif
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    /**
     *  在不知道图片扩展名时，如何知道图片的真实类型？
     *  取出图片数据的第一个字节，就可以判断图片的真实类型 （sd_contentTypeForImageData)
     */
    
    //判断是否显示点击查看全图按钮
    if (topic.istooBigPicture) {//大图
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
    
}
@end
