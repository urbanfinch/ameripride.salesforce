//
//  AmeriPrideSalesforceSaveTableViewController.h
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 7/21/13.
//  Copyright (c) 2013 Aaron C Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmeriPrideSalesforceNotifications.h"
#import "AmeriPrideSalesforceSaveManager.h"
#import "AmeriPrideSalesforceSave.h"

@interface AmeriPrideSalesforceSaveTableViewController : UITableViewController

@property UIActivityIndicatorView *activityIndicator;
@property IBOutlet UIBarButtonItem *activityButton;
@property IBOutlet UIBarButtonItem *refreshButton;
@property IBOutlet UINavigationBar *navigationBar;

- (IBAction)refresh:(id)sender;
- (IBAction)reload:(id)sender;

@end
