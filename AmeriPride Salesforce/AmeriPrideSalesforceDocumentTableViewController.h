//
//  AmeriPrideSalesforceDocumentTableViewController.h
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 2/24/13.
//  Copyright (c) 2013 Aaron C Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmeriPrideSalesforceNotifications.h"
#import "AmeriPrideSalesforceDocumentManager.h"
#import "AmeriPrideSalesforceDocument.h"

@interface AmeriPrideSalesforceDocumentTableViewController : UITableViewController

@property UIActivityIndicatorView *activityIndicator;
@property IBOutlet UIBarButtonItem *activityButton;
@property IBOutlet UIBarButtonItem *refreshButton;
@property IBOutlet UINavigationBar *navigationBar;

- (IBAction)refresh:(id)sender;
- (IBAction)reload:(id)sender;

@end
