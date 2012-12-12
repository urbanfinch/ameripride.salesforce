//
//  AmeriPrideSalesforcePresentationManager.h
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 11/26/12.
//  Copyright (c) 2012 Aaron C Wright. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AmeriPrideSalesforcePresentation.h"

@interface AmeriPrideSalesforcePresentationManager : NSObject

@property (nonatomic, strong) NSArray *presentations;
@property (nonatomic, strong) AmeriPrideSalesforcePresentation *presentation;

+ (AmeriPrideSalesforcePresentationManager *)defaultManager;

- (NSString *)titleForPresentation;
- (NSURL *)URLForPresentation;
- (NSData *)PDFDataForPresentation;

- (void)initialize;
- (IBAction)updatePresentations:(id)sender;

@end
