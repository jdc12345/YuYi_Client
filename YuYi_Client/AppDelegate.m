//
//  AppDelegate.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/1/18.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "AppDelegate.h"
#import "YYTabBarController.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
//// 如果需要使用idfa功能所需要引入的头文件（可选）
//#import <AdSupport/AdSupport.h>

#import <RongIMKit/RongIMKit.h>

#import "CcUserModel.h"
#import "YYLogInVC.h"
#import "YYWordsViewController.h"
#import "HttpClient.h"
#import "RCUserModel.h"
#import "YYNavigationController.h"

@interface AppDelegate ()<JPUSHRegisterDelegate,RCIMReceiveMessageDelegate,UNUserNotificationCenterDelegate>
@property (nonatomic, strong) YYTabBarController *yyTabBar;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //创建Window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    CcUserModel *userModel = [CcUserModel defaultClient];
    NSString *userToken = userModel.userToken;
    
    if (userToken) {
        //初始化一个tabBar控制器
        YYTabBarController *tabbarVC = [[YYTabBarController alloc]init];
        self.window.rootViewController = tabbarVC;
        [self.window makeKeyAndVisible];
        self.yyTabBar = tabbarVC;
    }else{
        YYLogInVC *logInVC = [[YYLogInVC alloc]init];
        YYNavigationController *navigationVc = [[YYNavigationController alloc] initWithRootViewController:logInVC];
        self.window.rootViewController = navigationVc;
    }
            
    NSLog(@"注册");
    
    
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    
    
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
//    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"4439dd4f42e0ba09ef4fd4e7"
                          channel:@"App Store"
                 apsForProduction:0
            advertisingIdentifier:nil];
//r---------- 1 融云初始化 ----------
    [[RCIM sharedRCIM] initWithAppKey:@"25wehl3u2qo7w"];
    
//r---------- 2 登陆融云 ----------
        //r---------- 2.1 向服务区请求用户信息 ----------
        [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@%@",mRCtokenUrl,userModel.telephoneNum] method:0 parameters:nil prepareExecute:^{
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            RCUserModel *userModel_rc = [RCUserModel defaultClient];
            userModel_rc.token = responseObject[@"token"];
            userModel_rc.Avatar = responseObject[@"Avatar"];
            userModel_rc.TrueName = responseObject[@"TrueName"];
            userModel_rc.info_id = responseObject[@"id"];
            
            //r---------- 2.2 用服务区请求的用户信息登录融云 ----------
            [[RCIM sharedRCIM] connectWithToken:userModel_rc.token     success:^(NSString *userId) {
                NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
                
               [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:userId name:userModel_rc.TrueName portrait:[NSString stringWithFormat:@"%@%@",mPrefixUrl,userModel_rc.Avatar]];
                
                [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
            } error:^(RCConnectErrorCode status) {
                NSLog(@"登陆的错误码为:%ld", (long)status);
            } tokenIncorrect:^{
                //token过期或者不正确。
                //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                NSLog(@"token错误");
            }];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error);
        }];

    
    

    
    
    // 融云控制台输出信息种类
    [RCIMClient sharedRCIMClient].logLevel = RC_Log_Level_Error;
    
    //r---------- 3 向用户请求允许推送 ----------
    if ([application
         respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, 用于iOS8以及iOS8之后的系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
        if (granted) {
            //点击允许
            NSLog(@"注册通知成功");
            [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                NSLog(@"%@", settings);
            }];
        } else {
            //点击不允许
            NSLog(@"注册通知失败");
        }
    }];
    //注册推送（同iOS8）
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    
    //////////////////
    // Override point for customization after application launch.
    return YES;
}


#pragma mark -
#pragma mark ------------JPUSH----------------------
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    NSLog(@"deviceToken == %@",deviceToken);
    
    
    
    NSString *token = [deviceToken description];
    token = [token stringByReplacingOccurrencesOfString:@"<"
                                             withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">"
                                             withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@" "
                                             withString:@""];
    //r---------- 4 上传设备token给融云，用以APNs远程推送 ----------
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
    
}
//r---------- 5 注册推送失败原因 ----------
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    
    NSLog(@"%@",userInfo);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [SVProgressHUD dismiss];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    application.applicationIconBadgeNumber = 0;
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// RC push
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
}
#pragma mark- RCIMReceiveMessageDelegate
//r---------- 6 收到消息，left剩余条数 ----------
- (void)onRCIMReceiveMessage:(RCMessage *)message
                        left:(int)left{
    
    int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                         @(ConversationType_PRIVATE),
                                                                         @(ConversationType_DISCUSSION),
                                                                         @(ConversationType_APPSERVICE),
                                                                         @(ConversationType_PUBLICSERVICE),
                                                                         @(ConversationType_GROUP)
                                                                         ]];
    
    NSString * unreadNum = [NSString stringWithFormat:@"%d",unreadMsgCount];
    NSDictionary * dict = @{@"unreadNum":unreadNum};

    //r---------- 6.1 发送未读信息通知 ----------
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MessageUnreadNum" object:nil userInfo:dict];
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (version >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    UIApplication *app = [UIApplication sharedApplication];
    //r---------- 6.2 显示未读信息数 ----------
    app.applicationIconBadgeNumber = unreadMsgCount;
    
    //消息内容
    NSString *messageContent = @"";
    // 注册通知
    if ([message.content isMemberOfClass:[RCTextMessage class]]) {
        RCTextMessage *testMessage = (RCTextMessage *)message.content;
        NSLog(@"消息内容：%@", testMessage.content);
        messageContent = testMessage.content;
        //        UILocalNotification *locatNotific = [[UILocalNotification alloc]init];
        //        locatNotific.alertTitle = testMessage.content;
        //        [[UIApplication sharedApplication] presentLocalNotificationNow:locatNotific];
    }
    NSLog(@"还剩余的未接收的消息数：%d", left);
    
    
    
    
    
    
    //r---------- 6.3 创建本地通知，当app还未被系统杀死时候推送的是本地通知 ----------
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    

    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:3.0];

    localNote.alertBody = messageContent;

    localNote.alertAction = @"解锁";

    localNote.hasAction = NO;

    localNote.alertLaunchImage = @"123Abc";
    // 2.6.设置alertTitle
    localNote.alertTitle = @"你有一条新消息";
    // 2.7.设置有通知时的音效
    localNote.soundName = @"buyao.wav";
    // 2.8.设置应用程序图标右上角的数字
    localNote.applicationIconBadgeNumber = unreadMsgCount;
    
    // 2.9.设置额外信息（通话人的id）
    localNote.userInfo = @{@"targetId" : message.targetId};
    
    // 3.调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
}
// ---------------------通知的点击事件-------------------
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    //点击通知进入应用
    YYWordsViewController *wordVC = [[YYWordsViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    wordVC.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    UNNotification *notification = response.notification;
    UNNotificationRequest *request = notification.request;
    //将显示在通知上的内容
    UNNotificationContent *content = request.content;
    //用户信息，本地通知传过来了通话人的id(targetId)
    NSDictionary *userInfo = content.userInfo;
    NSLog(@"----------------%@",userInfo);
    wordVC.targetId = userInfo[@"targetId"];
//    UIViewController *currentVC = [(UINavigationController *)self.window.rootViewController visibleViewController];
//    if ([currentVC respondsToSelector:@selector(pushViewController: animated:)]) {
//        [currentVC performSelector:@selector(pushViewController: animated:) withObject:wordVC withObject:@YES];
//    }
//    NSLog(@"response:%@", response);
    
    //已经获得了通话人的id，需要处理跳转逻辑
    self.yyTabBar.selectedIndex = 2;
    
    
    if ([self.yyTabBar.viewControllers.lastObject respondsToSelector:@selector(pushViewController: animated:)]) {
        [self.yyTabBar.viewControllers.lastObject pushViewController:wordVC animated:YES];
    }
    NSLog(@"response:%@", response);
}
@end
