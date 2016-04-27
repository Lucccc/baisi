//
//  UIBarButtonItem+GLExtension.m
//  百思不得姐
//
//  Created by Lucccc on 16/4/27.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "UIBarButtonItem+GLExtension.h"

@implementation UIBarButtonItem (GLExtension)

+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage  target:(id)target action:(SEL)action{
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [Button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    Button.size = Button.currentBackgroundImage.size;
    [Button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
   
    return [[self alloc]initWithCustomView:Button];
}
@end
