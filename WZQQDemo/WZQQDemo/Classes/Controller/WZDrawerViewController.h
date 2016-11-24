//
//  WZDrawerViewController.h
//  WZQQDemo
//
//  Created by songbiwen on 2016/11/23.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZDrawerViewController : UIViewController

/**
 初始化视图

 @param leftVC 抽屉左视图
 @param mainVC 抽屉主视图
 @param leftWidth 左视图显示的宽度
 @return WZDrawerViewController
 */
+ (instancetype)drawerVCWithLeftVC:(UIViewController *)leftVC withMainVC:(UIViewController *)mainVC withLeftWidth:(CGFloat)leftWidth;


/**
 初始化视图

 @return WZDrawerViewController
 */
+ (instancetype)sharedInstance;


/**
 显示抽屉的左视图
 */
- (void)showLeftViewController;


/**
 跳转到下个页面

 @param vc 即将显示的视图控制器
 */
- (void)pushToNextViewController:(UIViewController *)vc;
@end
