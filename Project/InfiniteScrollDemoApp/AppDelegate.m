//
//  AppDelegate.m
//  InfiniteScrollDemoApp
//
//  Created by Marek Mościchowski on 12/01/14.
//  Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import "AppDelegate.h"
#import "UIImageView+LoremPixel.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    return YES;
}

@end
