//
//  GLShowPictureViewController.m
//  百思不得姐
//
//  Created by Lucccc on 16/5/17.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLShowPictureViewController.h"
#import <UIImageView+WebCache.h>
#import "GLTopic.h"
#import <SVProgressHUD.h>
#import "GLTopicPictureView.h"
#import "GLProgressView.h"

@interface GLShowPictureViewController ()
@property (weak, nonatomic) IBOutlet GLProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic)UIImageView *imageView;
@end

@implementation GLShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    //显示宽度
    //显示高度 图片高度
    
    CGFloat pictureW = screenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    if (pictureH > screenH) {
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }else{
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = screenH * 0.5;
    }
    
    
    //马上显示最新的进度条（防止因网速慢，导致显示其他进度）
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    
    //下载图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //设置进度条圆角，颜色
        self.progressView.roundedCorners = 2;
        self.progressView.progressLabel.textColor = [UIColor whiteColor];
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
        
        NSString *text = [NSString stringWithFormat:@"%.0f%%",1.0* receivedSize / expectedSize * 100];
        text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        self.progressView.progressLabel.text = text;
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
}

-(IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)save {
    //将图片保存至相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
         [SVProgressHUD showSuccessWithStatus:@"保存失败！"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
