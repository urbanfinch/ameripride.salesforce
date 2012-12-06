//
//  AmeriPrideSalesforceSplashViewController.h
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 11/29/12.
//  Copyright (c) 2012 Aaron C Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface AmeriPrideSalesforceSplashViewController : MPMoviePlayerViewController

- (void)playbackDidFinish:(NSNotification *)notification;

@end
