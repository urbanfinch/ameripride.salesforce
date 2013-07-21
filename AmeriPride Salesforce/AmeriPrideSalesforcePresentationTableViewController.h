//
//  AmeriPrideSalesforcePresentationTableViewController.h
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 12/7/12.
//  Copyright (c) 2012 Aaron C Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmeriPrideSalesforceNotifications.h"
#import "AmeriPrideSalesforcePresentationManager.h"
#import "AmeriPrideSalesforcePresentation.h"

@interface AmeriPrideSalesforcePresentationTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property UIActivityIndicatorView *activityIndicator;
@property IBOutlet UIBarButtonItem *activityButton;
@property IBOutlet UIBarButtonItem *refreshButton;
@property IBOutlet UINavigationBar *navigationBar;

- (IBAction)refresh:(id)sender;
- (IBAction)reload:(id)sender;

@end
