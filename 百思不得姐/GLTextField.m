//
//  GLTextField.m
//  百思不得姐
//
//  Created by Lucccc on 16/5/4.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLTextField.h"

static NSString * const GLPlaceholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation GLTextField

-(void)awakeFromNib{
    //设置光标颜色
    self.tintColor = self.textColor;
    
    //不成为第一响应者
    [self resignFirstResponder];
    
}

/**
 *  当文本框点击时
 *
 */
-(BOOL)becomeFirstResponder{
    //修改站位文字颜色
    [self setValue:self.textColor forKeyPath:GLPlaceholderColorKeyPath];
    return [super becomeFirstResponder];
}

/**
 *  当文本失去聚焦时
 *
 */
-(BOOL)resignFirstResponder{
    //修改站位文字颜色
    [self setValue:[UIColor grayColor]forKeyPath:GLPlaceholderColorKeyPath];
    return [super resignFirstResponder];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
