//
//  AmeriPrideSalesforcePrintWebView.m
//  AmeriPride Salesforce
//
//  Created by Aaron Wright on 2/22/13.
//  Copyright (c) 2013 Aaron C Wright. All rights reserved.
//

#import "AmeriPrideSalesforcePrintWebView.h"

@implementation AmeriPrideSalesforcePrintWebView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDelegate:self];
    }
    return self;
}

- (NSData *)pdfData {
    NSMutableData *pdfData = [NSMutableData data];
    
    NSString *heightStr = [self stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];
    int height = [heightStr intValue];
    
    CGFloat maxHeight	= 792;
    int pages = ceil(height / maxHeight);
    
    UIGraphicsBeginPDFContextToData(pdfData, CGRectMake(0, 0, 612, 792), nil);
    
    for ( int i = 0; i < pages; i++)
    {
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        [self.scrollView setContentOffset:CGPointMake(0, maxHeight * i) animated:NO];
        [self.layer renderInContext:currentContext];
    }
    
    UIGraphicsEndPDFContext();

    return [pdfData copy];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self stringByEvaluatingJavaScriptFromString:@"presentation.print();"];
}

@end
