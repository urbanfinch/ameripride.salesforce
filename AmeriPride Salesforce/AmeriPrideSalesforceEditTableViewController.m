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
@synthesize saveButton = _saveButton;
@synthesize resetButton = _resetButton;

# pragma mark -
# pragma mark awake

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changed:)
                                                 name:AmeriPrideSalesforcePresentationChangedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changed:)
                                                 name:AmeriPrideSalesforceDocumentChangedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changed:)
                                                 name:AmeriPrideSalesforceSaveChangedNotification
                                               object:nil];
}

# pragma mark -
# pragma mark actions

- (void)toggle:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:AmeriPrideSalesforceDidToggleEditNotification object:sender];
}

- (void)save:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:AmeriPrideSalesforceDidRequestEditSaveNotification object:sender];
}

- (void)reset:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:AmeriPrideSalesforceDidRequestEditResetNotification object:sender];
}

# pragma mark -
# pragma mark notifications

- (void)changed:(NSNotification *)notification {
    [_editSwitch setOn:NO animated:NO];
}

@end
