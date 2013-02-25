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
@property (nonatomic, strong) IBOutlet UIButton *resetButton;

- (IBAction)toggle:(id)sender;
- (IBAction)reset:(id)sender;

@end
