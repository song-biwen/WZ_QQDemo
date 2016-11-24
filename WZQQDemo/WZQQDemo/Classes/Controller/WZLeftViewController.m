//
//  WZLeftViewController.m
//  WZQQDemo
//
//  Created by songbiwen on 2016/11/23.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZLeftViewController.h"
#import "WZDrawerViewController.h" //抽屉控制器
#import "WZHelloViewController.h"

@interface WZLeftViewController ()

@end

@implementation WZLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 40)];
    button.backgroundColor = [UIColor brownColor];
    [button setTitle:@"WZHelloViewController" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

/**
 按钮点击事件
 */
- (void)buttonAction {
    WZHelloViewController *helloVC = [[WZHelloViewController alloc] init];
    [[WZDrawerViewController sharedInstance] pushToNextViewController:helloVC];
    
}
@end
