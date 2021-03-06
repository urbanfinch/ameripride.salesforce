//
//  AmeriPrideSalesforceAppDelegate.h
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 11/25/12.
//  Copyright (c) 2012 Aaron C Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmeriPrideSalesforcePresentationManager.h"
#import "AmeriPrideSalesforceDocumentManager.h"
#import "AmeriPrideSalesforceSaveManager.h"
#import "AmeriPrideSalesforceSplashViewController.h"
#import "AmeriPrideSalesforceWebViewController.h"

@interface AmeriPrideSalesforceAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)presentSplashScreen;

@end
