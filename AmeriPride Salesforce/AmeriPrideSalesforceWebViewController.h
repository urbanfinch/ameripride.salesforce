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
#import "AmeriPrideSalesforceDocumentManager.h"

@interface AmeriPrideSalesforceWebViewController : UIViewController <UISplitViewControllerDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate, UIPrintInteractionControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) IBOutlet AmeriPrideSalesforceWebView *webView;
@property (nonatomic, strong) IBOutlet AmeriPrideSalesforcePrintWebView *printWebView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *toggleButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *actionButton;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) UIPrintInteractionController *printInteractionController;
@property (nonatomic, strong) UIPopoverController *editPopoverController;
@property (nonatomic, strong) NSURL *selectedURL;
@property (nonatomic, assign) BOOL masterVisible;
@property (nonatomic, assign) BOOL editing;

- (void)initButtons;
- (void)defaultsChanged:(NSNotification *)notification;
- (void)presentationChanged:(NSNotification *)notification;
- (void)documentChanged:(NSNotification *)notification;

- (IBAction)showEditPopover:(id)sender;
- (IBAction)action:(id)sender;
- (IBAction)email:(id)sender;
- (IBAction)print:(id)sender;
- (IBAction)edit:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)loadPresentation:(id)sender;
- (IBAction)loadDocument:(id)sender;
- (IBAction)toggle:(id)sender;

@end
