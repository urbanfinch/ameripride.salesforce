//
//  AmeriPrideSalesforceAppDelegate.m
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 11/25/12.
//  Copyright (c) 2012 Aaron C Wright. All rights reserved.
//

#import "AmeriPrideSalesforceAppDelegate.h"

@implementation AmeriPrideSalesforceAppDelegate

@synthesize window = _window;

# pragma mark -
# pragma mark NSApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"WebKitStoreWebDataForBackup"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    NSURL *splashURL = [[NSBundle mainBundle] URLForResource:@"Splash" withExtension:@"mp4"];
    
    AmeriPrideSalesforceSplashViewController *splashViewController = [[AmeriPrideSalesforceSplashViewController alloc] initWithContentURL:splashURL];
    splashViewController.moviePlayer.controlStyle = MPMovieControlStyleNone;
    splashViewController.moviePlayer.scalingMode = MPMovieScalingModeFill;
    [splashViewController.moviePlayer.backgroundView  addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default-Landscape~ipad.png"]]];
    [splashViewController.moviePlayer setFullscreen:YES animated:NO];
    [splashViewController.moviePlayer prepareToPlay];
    [splashViewController.moviePlayer play];
    
    [self.window setRootViewController:splashViewController];
    [self.window makeKeyAndVisible];
    
    NSURL *url = (NSURL *)[launchOptions valueForKey:UIApplicationLaunchOptionsURLKey];
    if (url != nil && [url isFileURL]) {
        [[AmeriPrideSalesforceDocumentManager defaultManager] openDocumentURL:url];
    }
    
    [[AmeriPrideSalesforceDocumentManager defaultManager] rebuildDocumentCache];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [[AmeriPrideSalesforceDocumentManager defaultManager] openDocumentURL:url];
    [[AmeriPrideSalesforceDocumentManager defaultManager] rebuildDocumentCache];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [[AmeriPrideSalesforceDocumentManager defaultManager] openDocumentURL:url];
    [[AmeriPrideSalesforceDocumentManager defaultManager] rebuildDocumentCache];
    
    return YES;
}

@end
