//
//  GLPublishViewController.m
//  百思不得姐
//
//  Created by Lucccc on 16/5/18.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLPublishViewController.h"
#import "GLVerticalButton.h"

@interface GLPublishViewController ()

@end

@implementation GLPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //添加标语
    UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.y = GLscreenH * 0.2;
    sloganView.centerX = GLscreenW * 0.5;
    [self.view addSubview:sloganView];
    
    
    //中间六个按钮
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (GLscreenH - 2 * buttonH) * 0.5;
    int maxCols = 3;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (GLscreenW - 2 *buttonStartX - maxCols * buttonW) / (maxCols - 1);
    
    //数据
    NSArray *images = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"离线下载"];
    
    for (int i = 0; i < images.count; i++) {
        GLVerticalButton *button  = [[GLVerticalButton alloc]init];
        //设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        
        //设置frame
        button.width = buttonW;
        button.height = buttonH;
        int row = i / maxCols;
        int col = i % maxCols;
        button.x = buttonStartX + col * (xMargin + buttonW);
        button.y = buttonStartY + row * buttonH;
        [self.view addSubview:button];
    }
}

- (IBAction)cancel {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
