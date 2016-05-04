//
//  GLPushGuideView.m
//  百思不得姐
//
//  Created by Lucccc on 16/5/4.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLPushGuideView.h"

@implementation GLPushGuideView

+(void)show{
    
    GLLog(@"%@",[NSBundle mainBundle].infoDictionary);
    NSString *Vkey = @"CFBundleShortVersionString";
    //获取得当前软件版本号
    NSString *currentVer = [NSBundle mainBundle].infoDictionary[Vkey];
    //获得沙盒中版本号
    NSString *sanboxVer = [[NSUserDefaults standardUserDefaults]stringForKey:Vkey];
    
    if (![currentVer isEqualToString:sanboxVer]) {//第一次打开版本
        GLPushGuideView *guideView = [GLPushGuideView pushGuide];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        guideView.frame  = window.bounds;
        [window addSubview:guideView];
        //存储版本号
        [[NSUserDefaults standardUserDefaults]setObject:currentVer forKey:Vkey];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    //GLPushGuideView *guideView = [GLPushGuideView pushGuide];
    
    
    
}

+(instancetype)pushGuide{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}

- (IBAction)btnClick:(id)sender {
    
    [self removeFromSuperview];
    
}

@end
