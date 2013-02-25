//
//  AmeriPrideSalesforceEditTableViewController.m
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 2/25/13.
//  Copyright (c) 2013 Aaron C Wright. All rights reserved.
//

#import "AmeriPrideSalesforceEditTableViewController.h"

@implementation AmeriPrideSalesforceEditTableViewController

@synthesize editSwitch = _editSwitch;
@synthesize resetButton = _resetButton;

# pragma mark -
# pragma mark actions

- (void)toggle:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:AmeriPrideSalesforceDidToggleEditNotification object:sender];
}

- (void)reset:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:AmeriPrideSalesforceDidRequestEditResetNotification object:sender];
}

@end
