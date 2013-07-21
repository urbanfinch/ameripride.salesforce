//
//  AmeriPrideSalesforceSaveTableViewController.m
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 7/21/13.
//  Copyright (c) 2013 Aaron C Wright. All rights reserved.
//

#import "AmeriPrideSalesforceSaveTableViewController.h"

@implementation AmeriPrideSalesforceSaveTableViewController

@synthesize activityIndicator = _activityIndicator;
@synthesize activityButton = _activityButton;
@synthesize refreshButton = _refreshButton;
@synthesize navigationBar = _navigationBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reload:)
                                                 name:AmeriPrideSalesforceSavesDidInitializeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reload:)
                                                 name:AmeriPrideSalesforceSavesDidChangeNotification
                                               object:nil];
    
    self.clearsSelectionOnViewWillAppear = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == (UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight));
}

# pragma mark -
# pragma mark actions

- (void)refresh:(id)sender {
    if (_activityButton == nil)
    {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20,20)];
        _activityButton = [[UIBarButtonItem alloc]initWithCustomView:_activityIndicator];
    }
    
    self.navigationBar.topItem.rightBarButtonItem = _activityButton;
    [_activityIndicator startAnimating];
    
    [[AmeriPrideSalesforceSaveManager defaultManager] initialize];
}

- (void)reload:(id)sender {
    [self.tableView reloadData];
    
    [_activityIndicator stopAnimating];
    self.navigationBar.topItem.rightBarButtonItem = _refreshButton;
}

# pragma mark -
# pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[AmeriPrideSalesforceSaveManager defaultManager] saves] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AmeriPrideSalesforceSave *save = [[[AmeriPrideSalesforceSaveManager defaultManager] saves] objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"Save";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [[cell textLabel] setText:[save title]];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%@ - %@", [save presentation], [save date]]];
    
    return cell;
}

# pragma mark -
# pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[AmeriPrideSalesforceSaveManager defaultManager] setSave:[[[AmeriPrideSalesforceSaveManager defaultManager] saves] objectAtIndex:indexPath.row]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:AmeriPrideSalesforceSaveChangedNotification object:[NSNumber numberWithInteger:indexPath.row]];
}

@end
