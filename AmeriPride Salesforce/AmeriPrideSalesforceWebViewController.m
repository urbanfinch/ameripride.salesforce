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
@synthesize printWebView = _printWebView;
@synthesize toggleButton = _toggleButton;
@synthesize actionButton = _actionButton;
@synthesize actionSheet = _actionSheet;
@synthesize editPopoverController = _editPopoverController;
@synthesize selectedURL = _selectedURL;
@synthesize printInteractionController = _printInteractionController;
@synthesize masterVisible = _masterVisible;

# pragma mark -
# pragma mark init

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setMasterVisible:NO];
        [self setEditing:NO];
        
        AmeriPrideSalesforcePrintWebView *pwv = [[AmeriPrideSalesforcePrintWebView alloc] initWithFrame:CGRectMake(0, 0, 612, 792)];
        [self setPrintWebView:pwv];
    }
    return self;
}

- (void)initButtons {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"editMode"]) {
        UIImage *editButtonImage = [UIImage imageNamed:@"Pencil"];
        UIBarButtonItem *editButtonItem = [[UIBarButtonItem alloc] initWithImage:editButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(showEditPopover:)];
        self.navigationItem.rightBarButtonItem = editButtonItem;
    } else {
        self.navigationItem.rightBarButtonItem = _actionButton;
    }
}

# pragma mark -
# pragma mark awake

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initButtons];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(defaultsChanged:)
                                                 name:NSUserDefaultsDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(presentationChanged:)
                                                 name:AmeriPrideSalesforcePresentationChangedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(documentChanged:)
                                                 name:AmeriPrideSalesforceDocumentChangedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(edit:)
                                                 name:AmeriPrideSalesforceDidToggleEditNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reset:)
                                                 name:AmeriPrideSalesforceDidRequestEditResetNotification
                                               object:nil];
}

# pragma mark -
# pragma mark view

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == (UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight));
}

# pragma mark -
# pragma mark notifications

- (void)defaultsChanged:(NSNotification *)notification {
    AmeriPrideSalesforcePresentationManager *presentationManager = [AmeriPrideSalesforcePresentationManager defaultManager];
    AmeriPrideSalesforceDocumentManager *documentManager = [AmeriPrideSalesforceDocumentManager defaultManager];
    
    if ([_editPopoverController isPopoverVisible]) {
        [_editPopoverController dismissPopoverAnimated:NO];
    }
    if (_actionSheet) {
        [_actionSheet dismissWithClickedButtonIndex:[_actionSheet cancelButtonIndex] animated:NO];
        _actionSheet = nil;
    }
    if ([_selectedURL isEqual:[presentationManager URLForPresentation]]) {
        [self loadPresentation:self];
    }
    if ([_selectedURL isEqual:[documentManager URLForDocument]]) {
        [self loadDocument:self];
    }
    
    [self initButtons];
}

- (void)presentationChanged:(NSNotification *)notification {
    [self loadPresentation:self];
}

- (void)documentChanged:(NSNotification *)notification {
    [self loadDocument:self];
}

# pragma mark -
# pragma mark popover

- (void)showEditPopover:(id)sender {
    if ([_editPopoverController isPopoverVisible]) {
        [_editPopoverController dismissPopoverAnimated:YES];
    } else {
        if (!_editPopoverController) {
            UIViewController *viewControllerForPopover = [self.storyboard instantiateViewControllerWithIdentifier:@"editPopover"];
            _editPopoverController = [[UIPopoverController alloc] initWithContentViewController:viewControllerForPopover];
        }
        [_editPopoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
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
        AmeriPrideSalesforceDocumentManager *documentManager = [AmeriPrideSalesforceDocumentManager defaultManager];
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        [mailViewController setMailComposeDelegate:self];
        
        if ([_selectedURL isEqual:[presentationManager URLForPresentation]]) {
            [mailViewController setSubject:[presentationManager titleForPresentation]];
            [mailViewController addAttachmentData:[_printWebView pdfData] mimeType:@"application/pdf" fileName:[[presentationManager titleForPresentation] stringByAppendingPathExtension:@"pdf"]];
        }
        if ([_selectedURL isEqual:[documentManager URLForDocument]]) {
            [mailViewController setSubject:[documentManager titleForDocument]];
            [mailViewController addAttachmentData:[NSData dataWithContentsOfFile:[[documentManager URLForDocument] path]] mimeType:@"application/pdf" fileName:[documentManager titleForDocument]];
        }
        
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
        AmeriPrideSalesforceDocumentManager *documentManager = [AmeriPrideSalesforceDocumentManager defaultManager];

        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        printInfo.outputType = UIPrintInfoOutputGeneral;
        printInfo.jobName = [presentationManager titleForPresentation];
        printInfo.duplex = UIPrintInfoDuplexLongEdge;
        
        _printInteractionController.showsPageRange = YES;
        _printInteractionController.printInfo = printInfo;
        
        if ([_selectedURL isEqual:[presentationManager URLForPresentation]]) {
            _printInteractionController.printingItem = [_printWebView pdfData];
        }
        if ([_selectedURL isEqual:[documentManager URLForDocument]]) {
            _printInteractionController.printingItem = [NSData dataWithContentsOfFile:[[documentManager URLForDocument] path]];
        }
        
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

- (void)reset:(id)sender {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Are you sure?"
                                                      message:@"This will reset all editing for this presentation."
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"OK", nil];
    [message show];
}

- (void)loadPresentation:(id)sender {
    AmeriPrideSalesforcePresentationManager *presentationManager = [AmeriPrideSalesforcePresentationManager defaultManager];
    
    [_printWebView loadRequest:[NSURLRequest requestWithURL:[presentationManager URLForPresentation]]];
    [_webView loadRequest:[NSURLRequest requestWithURL:[presentationManager URLForPresentation]]];
    
    [self setSelectedURL:[presentationManager URLForPresentation]];
}

- (void)loadDocument:(id)sender {
    AmeriPrideSalesforceDocumentManager *documentManager = [AmeriPrideSalesforceDocumentManager defaultManager];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[documentManager URLForDocument]]];
    
    [self setSelectedURL:[documentManager URLForDocument]];
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
        default:
            break;
    }
}

# pragma mark -
# pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0) {
        NSLog(@"Resetting... %@", [_webView stringByEvaluatingJavaScriptFromString:@"presentation.clear();"]);
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
