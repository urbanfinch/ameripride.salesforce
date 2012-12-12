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
    [self.window makeKeyAndVisible];
    
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    splitViewController.delegate = (id)navigationController.topViewController;
    
    NSURL *splashURL = [[NSBundle mainBundle] URLForResource:@"Splash" withExtension:@"mp4"];
    
    AmeriPrideSalesforceSplashViewController *splashViewController = [[AmeriPrideSalesforceSplashViewController alloc] initWithContentURL:splashURL];
    [splashViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    splashViewController.moviePlayer.controlStyle = MPMovieControlStyleNone;
    splashViewController.moviePlayer.scalingMode = MPMovieScalingModeFill;
    [splashViewController.moviePlayer.backgroundView  addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default-Landscape~ipad.png"]]];
    [splashViewController.moviePlayer setFullscreen:YES animated:NO];
    [splashViewController.moviePlayer prepareToPlay];
    [splashViewController.moviePlayer play];
    
    /*double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){*/
        [self.window.rootViewController setModalPresentationStyle:UIModalPresentationFullScreen];
        [self.window.rootViewController presentModalViewController:splashViewController animated:YES];
    //});
    
    return YES;
}

@end
