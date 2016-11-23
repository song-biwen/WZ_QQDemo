//
//  WZMessageViewController.m
//  WZQQDemo
//
//  Created by songbiwen on 2016/11/23.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZMessageViewController.h"
#import "WZDrawerViewController.h" //抽屉

@interface WZMessageViewController ()

@end

@implementation WZMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blueColor];
}

//显示抽屉左视图
- (IBAction)moreButtonAction:(id)sender {
    NSLog(@"%s",__func__);
    
    [[WZDrawerViewController sharedInstance] showLeftViewController];
}


@end
