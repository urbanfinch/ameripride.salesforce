//
//  AmeriPrideSalesforceEditTableViewController.h
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 2/25/13.
//  Copyright (c) 2013 Aaron C Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmeriPrideSalesforceNotifications.h"

@interface AmeriPrideSalesforceEditTableViewController : UITableViewController

@property (nonatomic, strong) IBOutlet UISwitch *editSwitch;
@property (nonatomic, strong) IBOutlet UIButton *saveButton;
@property (nonatomic, strong) IBOutlet UIButton *resetButton;

- (IBAction)toggle:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)reset:(id)sender;

- (void)changed:(NSNotification *)notification;

@end
