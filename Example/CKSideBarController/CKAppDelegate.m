//
//  CKAppDelegate.m
//  CKSideBarController
//
//  Created by Jason Kozemczak on 11/23/12.
//  Copyright (c) 2012 Jason Kozemczak. All rights reserved.
//

#import "CKAppDelegate.h"
#import "CKSideBarController.h"
#import "CKTestViewController.h"

@interface CKAppDelegate () <CKSideBarControllerDelegate>

@property(nonatomic) CKSideBarController *barController;
@property(nonatomic) UINavigationController *controller2;
@property(nonatomic) UINavigationController *controller1;
@property(nonatomic) UINavigationController *controller3;

@end

@implementation CKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];

    self.controller1 = [self navControllerWithTitle:@"Tweets" backgroundColor:[UIColor whiteColor] barImage:nil];
    self.controller2 = [self navControllerWithTitle:@"Connect" backgroundColor:[UIColor whiteColor] barImage:[UIImage imageNamed:@"compose.png"]];
    self.controller3 = [self navControllerWithTitle:@"Can't Touch" backgroundColor:[UIColor whiteColor] barImage:[UIImage imageNamed:@"search.png"]];
    
    self.barController = [[CKSideBarController alloc] init];
    self.barController.delegate = self;
    self.barController.viewControllers = @[
        self.controller1,
        self.controller2,
        self.controller3
    ];
    self.window.rootViewController = self.barController;

    return YES;
}

BOOL setTabBarTitle = YES;
- (UINavigationController *)navControllerWithTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor barImage:(UIImage *)image {
    CKTestViewController *controller = [[CKTestViewController alloc] init];
    controller.title = title;
    controller.view.backgroundColor = backgroundColor;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    if (setTabBarTitle)
        navController.tabBarItem.title = title;
    navController.tabBarItem.image = image;

    setTabBarTitle = !setTabBarTitle;

    return navController;
}

- (void)updateViewControllers {
    self.barController.viewControllers = @[
        self.controller1,
        self.controller3,
        self.controller2
    ];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

}

#pragma mark - CKSideBarControllerDelegate

- (BOOL)sideBarController:(CKSideBarController *)sideBarController shouldSelectViewController:(UIViewController *)viewController {
    return (![viewController.title isEqualToString:@"Can't Touch"]);
}

- (void)sideBarController:(CKSideBarController *)sideBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"viewController %@ selected!", viewController);
}


@end