//
//  AmeriPrideSalesforcePresentationTableViewController.m
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 12/7/12.
//  Copyright (c) 2012 Aaron C Wright. All rights reserved.
//

#import "AmeriPrideSalesforcePresentationTableViewController.h"

@implementation AmeriPrideSalesforcePresentationTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.clearsSelectionOnViewWillAppear = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == (UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight));
}

# pragma mark - 
# pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[AmeriPrideSalesforcePresentationManager defaultManager] presentations] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AmeriPrideSalesforcePresentation *presentation = [[[AmeriPrideSalesforcePresentationManager defaultManager] presentations] objectAtIndex:indexPath.row];
                              
    static NSString *CellIdentifier = @"Presentation";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [[cell textLabel] setText:[presentation title]];
    
    return cell;
}

# pragma mark - 
# pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[AmeriPrideSalesforcePresentationManager defaultManager] setPresentation:[[[AmeriPrideSalesforcePresentationManager defaultManager] presentations] objectAtIndex:indexPath.row]];

    [[NSNotificationCenter defaultCenter] postNotificationName:AmeriPrideSalesforcePresentationChangedNotification object:[NSNumber numberWithInteger:indexPath.row]];
}

@end
