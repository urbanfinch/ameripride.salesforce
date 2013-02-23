//
//  AmeriPrideSalesforceWebViewController.h
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 11/25/12.
//  Copyright (c) 2012 Aaron C Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "AmeriPrideSalesforceWebView.h"
#import "AmeriPrideSalesforcePrintWebView.h"
#import "AmeriPrideSalesforceNotifications.h"
#import "AmeriPrideSalesforcePresentationManager.h"

@interface AmeriPrideSalesforceWebViewController : UIViewController <UISplitViewControllerDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate, UIPrintInteractionControllerDelegate>

@property (nonatomic, strong) IBOutlet AmeriPrideSalesforceWebView *webView;
@property (nonatomic, strong) IBOutlet AmeriPrideSalesforcePrintWebView *printWebView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *toggleButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *actionButton;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) UIPrintInteractionController *printInteractionController;
@property (nonatomic, assign) BOOL masterVisible;
@property (nonatomic, assign) BOOL editing;

- (void)presentationChanged:(NSNotification *)notification;

- (IBAction)action:(id)sender;
- (IBAction)email:(id)sender;
- (IBAction)print:(id)sender;
- (IBAction)edit:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)load:(id)sender;
- (IBAction)toggle:(id)sender;

@end
