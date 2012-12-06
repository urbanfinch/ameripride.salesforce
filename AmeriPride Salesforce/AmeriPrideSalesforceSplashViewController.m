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
                                                 selector:@selector(playbackDidFinish)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:[self moviePlayer]];
    }
    return self;
}

# pragma mark -
# pragma mark view

-(void)viewWillAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

# pragma mark -
# pragma mark notifications

- (void)playbackDidFinish:(NSNotification *)notification {
    [self dismissModalViewControllerAnimated:YES];
}
@end