//
//  AmeriPrideSalesforceWebViewController.m
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 11/25/12.
//  Copyright (c) 2012 Aaron C Wright. All rights reserved.
//

#import "AmeriPrideSalesforceWebViewController.h"
#import "AmeriPrideSalesforceAppDelegate.h"

@implementation AmeriPrideSalesforceWebViewController

@synthesize webView = _webView;
@synthesize toggleButton = _toggleButton;
@synthesize actionButton = _actionButton;
@synthesize actionSheet = _actionSheet;
@synthesize printInteractionController = _printInteractionController;
@synthesize masterVisible = _masterVisible;

# pragma mark -
# pragma mark init

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setMasterVisible:NO];
        [self setEditing:NO];
    }
    return self;
}

# pragma mark -
# pragma mark awake

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(presentationChanged:)
                                                 name:AmeriPrideSalesforcePresentationChangedNotification
                                               object:nil];
}

# pragma mark -
# pragma mark view

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == (UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight));
}

# pragma mark -
# pragma mark notifications

- (void)preferencesChanged:(NSNotification *)notification {
    [self load:self];
}

- (void)presentationChanged:(NSNotification *)notification {
    [self load:self];
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
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"editMode"]) {
            [_actionSheet addButtonWithTitle:@"Toggle Editing"];
            [_actionSheet addButtonWithTitle:@"Reset Editing"];
        }
        
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

- (void)edit:(id)sender {
    if (_editing) {
        [self setEditing:NO];
         NSLog(@"Editing... %@", [_webView stringByEvaluatingJavaScriptFromString:@"presentation.edit('false');"]);
    } else {
        [self setEditing:YES];
         NSLog(@"Editing... %@", [_webView stringByEvaluatingJavaScriptFromString:@"presentation.edit('true');"]);
    }
}

- (void)clear:(id)sender {
    NSLog(@"Clearing... %@", [_webView stringByEvaluatingJavaScriptFromString:@"presentation.clear();"]);
}

- (void)load:(id)sender {
    AmeriPrideSalesforcePresentationManager *presentationManager = [AmeriPrideSalesforcePresentationManager defaultManager];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[presentationManager URLForPresentation]]];
}

- (void)toggle:(id)sender {
    UISplitViewController *splitViewController = (UISplitViewController *)[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    _masterVisible = !_masterVisible;
    
    [splitViewController willRotateToInterfaceOrientation:splitViewController.interfaceOrientation duration:0];
    [splitViewController.view setNeedsLayout];
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
        case 2:
            [self edit:_actionButton];
            break;
        case 3:
            [self clear:_actionButton];
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

# pragma mark -
# pragma mark UISplitViewDelegate

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation {
    if (_masterVisible) {
        return NO;
    } else {
        return YES;
    }
}

@end
