//
//  WZDrawerViewController.m
//  WZQQDemo
//
//  Created by songbiwen on 2016/11/23.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZDrawerViewController.h"//抽屉视图
#import "WZMainViewController.h"
#import "WZLeftViewController.h"


@interface WZDrawerViewController ()
//抽屉的主视图
@property (nonatomic, strong)  WZMainViewController *mainVC;

//抽屉的左视图
@property (nonatomic, strong) WZLeftViewController *leftVC;
//左视图显示的宽度
@property (nonatomic, assign) CGFloat leftWidth;

//
@property (nonatomic, strong) UIButton *corverButton;
@end

@implementation WZDrawerViewController

/**
 初始化视图
 
 @param leftVC 抽屉左视图
 @param mainVC 抽屉主视图
 @param leftWidth 左视图显示的宽度
 @return WZDrawerViewController
 */
+ (instancetype)drawerVCWithLeftVC:(UIViewController *)leftVC withMainVC:(UIViewController *)mainVC withLeftWidth:(CGFloat)leftWidth {
    //创建抽屉控制器
    WZDrawerViewController *drawerVc = [[WZDrawerViewController alloc] init];
    
    //初始化属性
    drawerVc.mainVC = (WZMainViewController *)mainVC;
    drawerVc.leftVC = (WZLeftViewController *)leftVC;
    drawerVc.leftWidth = leftWidth;
    
    //将左边的视图添加到抽屉视图上
    [drawerVc.view addSubview:leftVC.view];
    //将主视图添加到抽屉视图上
    [drawerVc.view addSubview:mainVC.view];
    
    //苹果规定，如果两个的view为父子关系，则这两个控制器也必须为父子关系
    [drawerVc addChildViewController:leftVC];
    [drawerVc addChildViewController:mainVC];
    return drawerVc;
}


/**
 初始化视图
 
 @return WZDrawerViewController
 */
+ (instancetype)sharedInstance {
    return (WZDrawerViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
}


/**
 显示抽屉的左视图
 */
- (void)showLeftViewController {
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.mainVC.view.transform = CGAffineTransformMakeTranslation(self.leftWidth, 0);
        self.leftVC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.mainVC.view addSubview:self.corverButton];
    }];
}


/**
 隐藏抽屉的左视图
 */
- (void)hiddenLeftViewController {
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.mainVC.view.transform = CGAffineTransformIdentity;
        self.leftVC.view.transform = CGAffineTransformMakeTranslation(-self.leftWidth, 0);
    } completion:^(BOOL finished) {
        [self.corverButton removeFromSuperview];
        self.corverButton = nil;
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //给mainVC添加阴影部分
    self.mainVC.view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.mainVC.view.layer.shadowOffset = CGSizeMake(-3, -3);
    self.mainVC.view.layer.cornerRadius = 5;
    self.mainVC.view.layer.shadowOpacity = 0.2;
    
    
    //更新左视图的位置
    self.leftVC.view.transform = CGAffineTransformMakeTranslation(-self.leftWidth, 0);
    
    //给mainVC子视图添加手势
    for (UIViewController *childVC in self.mainVC.childViewControllers) {
         UIScreenEdgePanGestureRecognizer *screenEdgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(screenEdgePanGestureAction:)];
        screenEdgePanGesture.edges = UIRectEdgeLeft;
        [childVC.view addGestureRecognizer:screenEdgePanGesture];
    }
    
}


/**
 边境侧滑

 */
- (void)screenEdgePanGestureAction:(UIScreenEdgePanGestureRecognizer *)gesture {
    NSLog(@"%s",__func__);
    //获取屏幕宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    //手势所在的x
    CGFloat originX = [gesture translationInView:gesture.view].x;
    NSLog(@"%f",originX);
    
    if (originX < 0) {
        originX = 0;
    }
    if (originX > self.leftWidth) {
        originX = self.leftWidth;
    }
    if (gesture.state == UIGestureRecognizerStateChanged) {
        //一直在改变
        self.mainVC.view.transform = CGAffineTransformMakeTranslation(originX, 0);
        self.leftVC.view.transform = CGAffineTransformMakeTranslation(-self.leftWidth + originX, 0);
    }
    
    else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        if (self.mainVC.view.frame.origin.x > screenW * 0.5) {
            //当所在的位置位于屏幕一半右侧时，显示左边视图
            [self showLeftViewController];
        }else {
            //当所在的位置位于屏幕一半的左侧时，隐藏左边视图
            [self hiddenLeftViewController];
        }
    }
}




/**
 给按钮添加滑动手势
 */
- (void)panGestureAction:(UIPanGestureRecognizer *)gesture {
    NSLog(@"%s",__func__);
    
    //获取屏幕宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    //手势所在的x
    CGFloat originX = [gesture translationInView:gesture.view].x;
//    NSLog(@"%f",originX);
    
    if (originX > 0) {
        originX = 0;
    }
    
    if (originX < -self.leftWidth) {
        originX = -self.leftWidth;
    }
    
    CGFloat distance = self.leftWidth - ABS(originX);
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        //一直在改变
        self.mainVC.view.transform = CGAffineTransformMakeTranslation(distance, 0);
        self.leftVC.view.transform = CGAffineTransformMakeTranslation(originX, 0);
    }
    
    else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        if (self.mainVC.view.frame.origin.x > screenW * 0.5) {
            //当所在的位置位于屏幕一半右侧时，显示左边视图
            [self showLeftViewController];
        }else {
            //当所在的位置位于屏幕一半的左侧时，隐藏左边视图
            [self hiddenLeftViewController];
        }
    }
}


- (UIButton *)corverButton {
    if (!_corverButton) {
        _corverButton = [[UIButton alloc] initWithFrame:self.mainVC.view.bounds];
        _corverButton.backgroundColor = [UIColor clearColor];
        //给button添加点击事件
        [_corverButton addTarget:self action:@selector(hiddenLeftViewController) forControlEvents:UIControlEventTouchUpInside];
        
        //给按钮添加手势
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        [_corverButton addGestureRecognizer:panGesture];
    }
    return _corverButton;
}

/**
 跳转到下个页面
 
 @param vc 即将显示的视图控制器
 */
- (void)pushToNextViewController:(UIViewController *)vc {
    NSLog(@"%s",__func__);
    [self hiddenLeftViewController];
    
//    self.mainVC.selectedViewController UINavigationController
    [self.mainVC.selectedViewController pushViewController:vc animated:NO];
}
@end
