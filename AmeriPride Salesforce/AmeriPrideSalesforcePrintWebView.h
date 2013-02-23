//
//  AmeriPrideSalesforcePrintWebView.h
//  AmeriPride Salesforce
//
//  Created by Aaron Wright on 2/22/13.
//  Copyright (c) 2013 Aaron C Wright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface AmeriPrideSalesforcePrintWebView : UIWebView <UIWebViewDelegate>

- (NSData *)pdfData;

@end
