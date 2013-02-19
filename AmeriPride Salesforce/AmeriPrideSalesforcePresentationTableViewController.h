//
//  AmeriPrideSalesforcePresentationTableViewController.h
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 12/7/12.
//  Copyright (c) 2012 Aaron C Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmeriPrideSalesforceNotifications.h"
#import "AmeriPrideSalesforceDocumentManager.h"
#import "AmeriPrideSalesforcePresentationManager.h"

@interface AmeriPrideSalesforcePresentationTableViewController : UITableViewController

@property UIActivityIndicatorView *activityIndicator;
@property IBOutlet UIBarButtonItem *activityButton;
@property IBOutlet UIBarButtonItem *refreshButton;

- (IBAction)refresh:(id)sender;
- (IBAction)reload:(id)sender;

@end
