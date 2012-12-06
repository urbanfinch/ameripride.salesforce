//
//  AmeriPrideSalesforceWebViewController.m
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 11/25/12.
//  Copyright (c) 2012 Aaron C Wright. All rights reserved.
//

#import "AmeriPrideSalesforceWebViewController.h"

@implementation AmeriPrideSalesforceWebViewController

@synthesize webView = _webView;
@synthesize actionButton = _actionButton;
@synthesize editButton = _editButton;
@synthesize actionSheet = _actionSheet;
@synthesize printInteractionController = _printInteractionController;

# pragma mark -
# pragma mark awake

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
               selector:@selector(preferencesChanged:)
                   name:NSUserDefaultsDidChangeNotification
                 object:nil];
}

# pragma mark -
# pragma mark view

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
	
    [self update:self];
}

# pragma mark -
# pragma mark notifications

- (void)preferencesChanged:(NSNotification *)notification {
    [self update:self];
}

# pragma mark -
# pragma mark actions

- (void)action:(id)sender {
    if (_printInteractionController) {
        [_printInteractionController dismissAnimated:YES];
        _printInteractionController = nil;
    }
    
    if (_actionSheet) {
        [_actionSheet dismissWithClickedButtonIndex:_actionSheet.cancelButtonIndex animated:YES];
        _actionSheet = nil;
        return;
    } else {
        _actionSheet = [[UIActionSheet alloc] init];
        [_actionSheet addButtonWithTitle:@"E-Mail"];
        [_actionSheet addButtonWithTitle:@"Print"];
        [_actionSheet setDelegate:self];
        [_actionSheet showFromBarButtonItem:sender animated:YES];
    }
}

- (void)email:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        
        AmeriPrideSalesforcePresentationManager *presentationManager = [AmeriPrideSalesforcePresentationManager defaultManager];
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        [mailViewController setMailComposeDelegate:self];
        [mailViewController setSubject:[presentationManager titleForPresentation]];
        [mailViewController addAttachmentData:[presentationManager PDFDataForPresentation] mimeType:@"application/pdf" fileName:[[presentationManager titleForPresentation] stringByAppendingPathExtension:@"pdf"]];
        
        [self presentModalViewController:mailViewController animated:YES];
    }
}

- (void)print:(id)sender {
    if (_printInteractionController) {
        [_printInteractionController dismissAnimated:YES];
        _printInteractionController = nil;
        return;
    } else {
        _printInteractionController = [UIPrintInteractionController sharedPrintController];
        _printInteractionController.delegate = self;
        
        AmeriPrideSalesforcePresentationManager *presentationManager = [AmeriPrideSalesforcePresentationManager defaultManager];
        
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        printInfo.outputType = UIPrintInfoOutputGeneral;
        printInfo.jobName = [presentationManager titleForPresentation];
        
        _printInteractionController.printInfo = printInfo;
        _printInteractionController.printingItem = [presentationManager PDFDataForPresentation];
        
        [_printInteractionController presentFromBarButtonItem:_actionButton animated:YES completionHandler:^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
            if (!completed && error) {
                NSLog(@"Printing could not complete because of error: %@", error);
            }
        }];
    }
}

- (void)update:(id)sender {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"editMode"]) {
        [[self navigationItem] setRightBarButtonItem:_editButton animated:NO];
    } else {
        [[self navigationItem] setRightBarButtonItem:nil animated:NO];
    }
    
    AmeriPrideSalesforcePresentationManager *presentationManager = [AmeriPrideSalesforcePresentationManager defaultManager];
    
    [_webView loadHTMLString:[presentationManager HTMLForPresentation] baseURL:[presentationManager baseURLForPresentation]];
}

# pragma mark -
# pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self email:_actionButton];
            break;
        case 1:
            [self print:_actionButton];
            break;
        default:
            break;
    }
}

# pragma mark -
# pragma mark MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissModalViewControllerAnimated:YES];
}

@end
