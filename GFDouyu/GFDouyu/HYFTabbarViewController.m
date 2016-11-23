//
//  HYFTabbarViewController.m
//  GFDouyu
//
//  Created by 黄一帆 on 2016/11/23.
//  Copyright © 2016年 gzshanliang. All rights reserved.
//

#import "HYFTabbarViewController.h"
#import "UIView+Frame.h"
#import "UIImage+Image.h"

#import "HYFNavigationController.h"
#import "HYFRootOneViewController.h"
#import "HYFRootTwoViewController.h"
#import "HYFRootThreeViewController.h"
#import "HYFRootFourViewController.h"
#import "HYFRootFiveViewController.h"
@interface HYFTabbarViewController ()

@end

@implementation HYFTabbarViewController

+ (void)load
{
    /*
     appearance注意:
     1.任何类都可以使用appearance吗? 只有遵守了UIAppearance协议
     2.哪些属性都可以通过appearance去设置? 只要定义了UI_APPEARANCE_SELECTOR宏就能使用
     3.通过appearance去设置属性,必须要在控件显示之前去设置.
     */
    // 获取全局UITabBarItem外观
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 设置标题颜色
    // ***模型一般都是通过富文本属性去设置文字的颜色,字体等等.***
    // 通过富文本属性 去设置 文字颜色,字体
    // 设置选中状态
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attr forState:UIControlStateSelected];
    
    // 设置正常状态下
    // ****设置tabBar上按钮文字字体,必须通过正常状态下,才可以设置成功****
    NSMutableDictionary *attrNor = [NSMutableDictionary dictionary];
    attrNor[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:attrNor forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1. 添加子控制器
    [self setupAllChildViewController];
    
    // 2.设置tabBar上按钮内容
    [self setupAllTitleButton];
    
    // 3.添加中间按钮
    [self setupCenterButton];
}

#pragma mark - 设置中间按钮
- (void)setupCenterButton
{
    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
    // 注意点:******一定先设置size,在设置center********
    // 尺寸会根据内容自适应
    [plusButton sizeToFit];
    plusButton.center = CGPointMake(HYFScreenW * 0.5, self.tabBar.hyf_height * 0.5);
    [self.tabBar addSubview:plusButton];
}

#pragma mark - 设置tabBar上按钮内容
- (void)setupAllTitleButton
{
    // UITabBar上按钮由对应的子控制器的tabBarItem
    // 设置第0个按钮 => tabBarController第0个子控制器
    // 精华
    UIViewController *vc = self.childViewControllers[0];
    vc.tabBarItem.title = @"根1";
    vc.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    vc.tabBarItem.selectedImage = [UIImage imageOriginalWithImageName:@"tabBar_essence_click_icon"];
    
    // 新帖
    UIViewController *vc1 = self.childViewControllers[1];
    vc1.tabBarItem.title = @"根2";
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    vc1.tabBarItem.selectedImage = [UIImage imageOriginalWithImageName:@"tabBar_new_click_icon"];
    
    // 发布
    UIViewController *vc2 = self.childViewControllers[2];
    // 让中间按钮不能使用
    vc2.tabBarItem.enabled = NO;
    
    // 关注
    UIViewController *vc3 = self.childViewControllers[3];
    vc3.tabBarItem.title = @"根3";
    vc3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    vc3.tabBarItem.selectedImage = [UIImage imageOriginalWithImageName:@"tabBar_friendTrends_click_icon"];
    
    // 我
    UIViewController *vc4 = self.childViewControllers[4];
    vc4.tabBarItem.title = @"根4";
    vc4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    vc4.tabBarItem.selectedImage = [UIImage imageOriginalWithImageName:@"tabBar_me_click_icon"];
}

// *** 不要在外界去设置控制器的view的背景色,会导致提前加载控制器view****
#pragma mark - 添加所有子控制器
- (void)setupAllChildViewController
{
    // 精华
    HYFRootOneViewController *oneVC = [[HYFRootOneViewController alloc] init];
    HYFNavigationController *nav = [[HYFNavigationController alloc] initWithRootViewController:oneVC];
    //    [nav pushViewController:essenceVc animated:YES];
    // initWithRootViewController => push
    [self addChildViewController:nav];
    
    // 新帖
    HYFRootTwoViewController *twoVC = [[HYFRootTwoViewController alloc] init];
    HYFNavigationController *nav1 = [[HYFNavigationController alloc] initWithRootViewController:twoVC];
    // initWithRootViewController => push
    [self addChildViewController:nav1];
    
    // 发布
    UIViewController *publishVc = [[UIViewController alloc] init];
    [self addChildViewController:publishVc];
    
    // 关注
    HYFRootThreeViewController *threeVC = [[HYFRootThreeViewController alloc] init];
    HYFNavigationController *nav3 = [[HYFNavigationController alloc] initWithRootViewController:threeVC];
    // initWithRootViewController => push
    [self addChildViewController:nav3];
    
    // 我
    HYFRootFourViewController *fourVC = [[HYFRootFourViewController alloc] init];
    HYFNavigationController *nav4 = [[HYFNavigationController alloc] initWithRootViewController:fourVC];
    // initWithRootViewController => push
    [self addChildViewController:nav4];
}

@end
