//
//  AmeriPrideSalesforceWebView.m
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 11/25/12.
//  Copyright (c) 2012 Aaron C Wright. All rights reserved.
//

#import "AmeriPrideSalesforceWebView.h"

@implementation AmeriPrideSalesforceWebView

# pragma mark -
# pragma mark init

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setBackgroundColor:[UIColor underPageBackgroundColor]];
        [self loadDefaultRequest:self];
    }
    return self;
}

# pragma mark -
# pragma mark actions

- (void)loadDefaultRequest:(id)sender {
    NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"default" ofType:@"html"];
    NSURL *defaultURL = [NSURL fileURLWithPath:defaultPath];
    [self loadRequest:[NSURLRequest requestWithURL:defaultURL]];
}

@end
