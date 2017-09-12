//  Copyright (c) 2016年 __MyCompanyName__. All rights reserved.
//
#import "YYTabBarController.h"
// #import "UIImage+Common.h"
#import "YYTabBar.h"
#import "YYNavigationController.h"
#import "YYHomePageViewController.h"
#import "YYMeasureViewController.h"
#import "YYConsultViewController.h"
#import "YYPersonalViewController.h"
#import "CcUserModel.h"

#define kTabbarItemTag 100
@interface YYTabBarController () <UITabBarControllerDelegate>

@property (nonatomic, strong) YYTabBar *tabBarView;


@end

@implementation YYTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CcUserModel *ccuserModel = [CcUserModel defaultClient];
    if(![ccuserModel.telephoneNum isEqualToString:@"18511694068"]){
    self.tabBarView = [YYTabBar initWithTabs:4 systemTabBarHeight:self.tabBar.bounds.size.height selected:^(NSUInteger index) {
        self.selectedIndex = index;
    }];
    }else{
        self.tabBarView = [YYTabBar initWithTabs:3 systemTabBarHeight:self.tabBar.bounds.size.height selected:^(NSUInteger index) {
            self.selectedIndex = index;
        }];
    }
    [self setupMainContents];
    [self setValue:self.tabBarView forKey:@"tabBar"];
}


-(void)viewWillAppear:(BOOL)animated {
    [self.selectedViewController beginAppearanceTransition: YES animated: animated];
}

-(void) viewDidAppear:(BOOL)animated {
    [self.selectedViewController endAppearanceTransition];
}

-(void) viewWillDisappear:(BOOL)animated {
    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
}

-(void) viewDidDisappear:(BOOL)animated {
    [self.selectedViewController endAppearanceTransition];
}

- (void)setupMainContents {
    
    CcUserModel *ccuserModel = [CcUserModel defaultClient];
    
    

    // 首页
    YYHomePageViewController *homeVC = [[YYHomePageViewController alloc] init];
    [self addChildViewControllerAtIndex:0 childViewController:homeVC title:@"首页" normalImage:@"firstPage_unhome" selectedImage:@"firstPage_home"];
    
    // 测量
    YYMeasureViewController *measureVC = [[YYMeasureViewController alloc] init];
    [self addChildViewControllerAtIndex:1 childViewController:measureVC title:@"测量" normalImage:@"firstPage_unmeasure" selectedImage:@"firstPage_measure"];
    if(![ccuserModel.telephoneNum isEqualToString:@"18511694068"]){
    // 咨询
    YYConsultViewController *consultVC = [[YYConsultViewController alloc] init];
    [self addChildViewControllerAtIndex:2 childViewController:consultVC title:@"咨询" normalImage:@"firstPage_unconsult" selectedImage:@"firstPage_consult"];
        // 我的
        YYPersonalViewController *personalVC = [[YYPersonalViewController alloc] init];
        [self addChildViewControllerAtIndex:3 childViewController:personalVC title:@"我的" normalImage:@"firstPage_unmine" selectedImage:@"firstPage_mine"];
    }else{
        YYPersonalViewController *personalVC = [[YYPersonalViewController alloc] init];
        [self addChildViewControllerAtIndex:2 childViewController:personalVC title:@"我的" normalImage:@"firstPage_unmine" selectedImage:@"firstPage_mine"];
    }

}

/**
 *  Add a child view controller.
 *
 *  @param index                index of the child Controller
 *  @param childViewController  child Controller
 *  @param title                title for item within TabBar
 *  @param normalImage          unselected image for item within TabBar
 *  @param selectedImage        selected image for item within TabBar
 */
- (void)addChildViewControllerAtIndex:(NSInteger)index childViewController:(UIViewController *)childViewController title:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage {
    // Set content of the corresponding tab bar item for child controller.
    
    [self.tabBarView setTabAtIndex:index title:title normalImage:normalImage selectedImage:selectedImage];
    
    // Add child Controller to TabBarController.
    YYNavigationController *navigationVc = [[YYNavigationController alloc] initWithRootViewController:childViewController];
    [self addChildViewController:navigationVc];
}

#pragma mark - Actions.
- (void)switchTab:(NSUInteger)index {
    self.selectedIndex = index;
    [self.tabBarView selectTab:index];
}

@end
