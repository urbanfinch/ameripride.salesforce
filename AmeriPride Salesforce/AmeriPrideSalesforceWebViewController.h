//
//  AmeriPrideSalesforceWebViewController.h
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 11/25/12.
//  Copyright (c) 2012 Aaron C Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "AmeriPrideSalesforcePresentationManager.h"

@interface AmeriPrideSalesforceWebViewController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate, UIPrintInteractionControllerDelegate>

@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *actionButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *editButton;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) UIPrintInteractionController *printInteractionController;

- (void)preferencesChanged:(NSNotification *)notification;

- (IBAction)action:(id)sender;
- (IBAction)email:(id)sender;
- (IBAction)print:(id)sender;
- (IBAction)update:(id)sender;

@end
