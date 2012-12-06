//
//  AmeriPrideSalesforceAppDelegate.m
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 11/25/12.
//  Copyright (c) 2012 Aaron C Wright. All rights reserved.
//

#import "AmeriPrideSalesforceAppDelegate.h"

@implementation AmeriPrideSalesforceAppDelegate

# pragma mark -
# pragma mark NSApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self.window makeKeyAndVisible];
    
    NSURL *splashURL = [[NSBundle mainBundle] URLForResource:@"Splash" withExtension:@"mp4"];
    
    AmeriPrideSalesforceSplashViewController *splashViewController = [[AmeriPrideSalesforceSplashViewController alloc] initWithContentURL:splashURL];
    [splashViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    splashViewController.moviePlayer.controlStyle = MPMovieControlStyleNone;
    splashViewController.moviePlayer.scalingMode = MPMovieScalingModeFill;
    [splashViewController.moviePlayer.backgroundView  addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default-Landscape~ipad.png"]]];
    [splashViewController.moviePlayer setFullscreen:YES animated:NO];
    [splashViewController.moviePlayer prepareToPlay];
    [splashViewController.moviePlayer play];
    
    [self.window.rootViewController setModalPresentationStyle:UIModalPresentationFullScreen];
	[self.window.rootViewController presentModalViewController:splashViewController animated:YES];
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
