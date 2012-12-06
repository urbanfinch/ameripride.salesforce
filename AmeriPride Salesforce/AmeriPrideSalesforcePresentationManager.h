//
//  AmeriPrideSalesforcePresentationManager.h
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 11/26/12.
//  Copyright (c) 2012 Aaron C Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AmeriPrideSalesforcePresentationManager : NSObject

+ (AmeriPrideSalesforcePresentationManager *)defaultManager;

- (NSString *)titleForPresentation;
- (NSString *)HTMLForPresentation;
- (NSURL *)baseURLForPresentation;
- (NSData *)PDFDataForPresentation;

- (void)updatePresentation;

@end
