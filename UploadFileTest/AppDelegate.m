//
//  AppDelegate.m
//  UploadFileTest
//
//  Created by 许明洋 on 2020/12/8.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "UploadViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
//    ViewController *vc = [[ViewController alloc] init];
    UploadViewController *vc = [[UploadViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    return YES;
}

@end
