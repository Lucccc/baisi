//
//  GLLoginRegisterViewController.m
//  百思不得姐
//
//  Created by Lucccc on 16/5/3.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLLoginRegisterViewController.h"

@interface GLLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
//登陆框距离控制器view左边间距
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation GLLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //改变placeholder的第一种做法
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSAttributedString *placeholder = [[NSAttributedString alloc]initWithString:@"手机号" attributes:attrs];
    self.phoneTextField.attributedPlaceholder = placeholder;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showLoginOrRegister:(UIButton *)button {
    if (self.loginViewLeftMargin.constant == 0) {//显示注册
        self.loginViewLeftMargin.constant =  -self.view.width;
        [button setTitle:@"已有账号？" forState:UIControlStateNormal];
       
    }else{
        self.loginViewLeftMargin.constant = 0;
        [button setTitle:@"注册账号" forState:UIControlStateNormal];
    }

    [UIView animateWithDuration:0.25 animations:^{
    [self.view layoutIfNeeded];
    }];

    
    
}

//设置控制器状态栏围白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
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
