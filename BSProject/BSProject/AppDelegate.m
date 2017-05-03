//
//  AppDelegate.m
//  BSProject
//
//  Created by Liu-Mac on 4/25/17.
//  Copyright © 2017 Liu-Mac. All rights reserved.
//

#import "AppDelegate.h"
#import "LCMainTabBarC.h"
#import "LCPushGuideView.h"

#import <UMSocialCore/UMSocialCore.h>
#import <Bugly/Bugly.h>
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 友盟分享
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"590839e05312dd1f970016bf"];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
    
    // Bugly
    // 读取 Info.plist 中的配置
    [Bugly startWithAppId:nil];
    
    // 设置默认扬声器发声, 如果插上耳机, 就使用耳机发声
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord
                                     withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker
                                           error:nil];
    
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 根控制器
    LCMainTabBarC *tabBarC = [LCMainTabBarC new];
    tabBarC.delegate = self;
    
    // 设置窗口的根控制器
    self.window.rootViewController = tabBarC;
    
    // 显示窗口
    [self.window makeKeyAndVisible];
    
    // 显示引导页
    [LCPushGuideView show];
    
    return YES;
}

- (void)confitUShareSettings {
    
    /*
     * 打开图片水印
     */
    [UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms {
    
    /* 设置微信的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"2139382427"  appSecret:@"507fccf0efde8a900cc86700abc13827" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#pragma mark - UITabBarControllerDelegate

// 当选中 tabBarController 的 子控制器 时调用
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    [NotificationCenter postNotificationName:UITabBarControllerDidSelectViewControllerNotification object:nil];
}

@end
