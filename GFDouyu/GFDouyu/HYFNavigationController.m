//
//  HYFNavigationController.m
//  GFDouyu
//
//  Created by 黄一帆 on 2016/11/23.
//  Copyright © 2016年 gzshanliang. All rights reserved.
//

#import "HYFNavigationController.h"

@interface HYFNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation HYFNavigationController

/*
 滑动返回功能失效 => 把系统返回按钮覆盖
 系统滑动返回功能 是 用interactivePopGestureRecognizer去实现
 
 1.恢复滑动返回功能 => 为什么滑动返回功能失效 => 1.可能把interactivePopGestureRecognizer.enable = NO 2.也不可能把手势清空 3.代理做了事情
 
 
 // 假死状态:程序还在运行,但是界面死了,在根控制器的view下滑动返回
 
 // 让手势失效 1.直接把手势清空 2.设置手势enable 3.通过代理也可以让手势失效
 
 滑动返回功能在iOS7才有
 滑动返回功能底层实现原理: 1.给导航控制器的view添加pan手势 2.在每次push的时候,当之前界面截屏 3.当滑动返回的时候,把图片展示到上一层
 */


/*
 全屏滑动
 系统的滑动返回功能,只能在最左边的边缘才能触发
 触发这个interactivePopGestureRecognizer手势,就有滑动返回功能,触发target,action
 // <UIScreenEdgePanGestureRecognizer: 0x7fb8d0c32fa0; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fb8d0ea2cb0>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fb8d0c327d0>)>>
 // action=handleNavigationTransition:
 // target=<_UINavigationInteractiveTransition 0x7fb8d0c327d0>)>>
 */

+ (void)load
{
    // 获取当前类的导航条
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    // iOS7适配: Bug:在做发短信功能的时候,发现联系人黑屏
    
    // 设置导航条标题字体
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [bar setTitleTextAttributes:attr];
    
    // 设置导航条背景图片
//    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [bar setBackgroundColor:[UIColor purpleColor]];
}

// <_UINavigationInteractiveTransition: 0x7ff7a4aa0300>:手势代理
- (void)viewDidLoad {
    [super viewDidLoad];
    
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 控制全屏手势什么时候触发
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    
    // 限制系统边缘滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
}

#pragma mark - UIGestureRecognizerDelegate
// 判断下是否接收这个手指,触发手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 每次触发手势的时候就会调用
    // 判断下当前在不在根控制器
    return self.childViewControllers.count > 1;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 判断下当前控制器是否是非跟控制器
    if (self.childViewControllers.count > 0) { // 非根控制器
        // 非根控制器才需要设置返回按钮
        
        // 导航条上按钮位置 不能自己决定
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [backButton sizeToFit];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        // 设置导航条左边按钮为返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        // 隐藏底部条
        viewController.hidesBottomBarWhenPushed = YES;
        //        NSLog(@"%d",self.interactivePopGestureRecognizer.enabled);
    }
    
    
    // 真正执行跳转
    [super pushViewController:viewController animated:animated];
    
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
