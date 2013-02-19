//
//  AmeriPrideSalesforceSplashViewController.m
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 11/29/12.
//  Copyright (c) 2012 Aaron C Wright. All rights reserved.
//

#import "AmeriPrideSalesforceSplashViewController.h"

@implementation AmeriPrideSalesforceSplashViewController

# pragma mark -
# pragma mark init

- (id)initWithContentURL:(NSURL *)contentURL {
    self = [super initWithContentURL:contentURL];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playbackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:[self moviePlayer]];
    }
    return self;
}

# pragma mark -
# pragma mark view

-(void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

# pragma mark -
# pragma mark notifications

- (void)playbackDidFinish:(NSNotification *)notification {
    UIStoryboard *authStoryboard = [UIStoryboard storyboardWithName:@"AmeriPrideSalesforceStoryboard" bundle:nil];
    UISplitViewController *splitViewController = [authStoryboard instantiateInitialViewController];
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    splitViewController.delegate = (id)navigationController.topViewController;
    
    [[[self view] window] setRootViewController:splitViewController];
    [[[self view] window] makeKeyAndVisible];
}
@end
