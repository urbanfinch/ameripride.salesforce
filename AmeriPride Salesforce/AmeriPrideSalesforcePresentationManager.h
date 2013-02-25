//
//  AmeriPrideSalesforcePresentationManager.h
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 11/26/12.
//  Copyright (c) 2012 Aaron C Wright. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AmeriPrideSalesforceNotifications.h"
#import "AmeriPrideSalesforcePresentation.h"
#import "ZipArchive.h"

@interface AmeriPrideSalesforcePresentationManager : NSObject

@property (nonatomic, strong) NSArray *presentations;
@property (nonatomic, strong) AmeriPrideSalesforcePresentation *presentation;

+ (AmeriPrideSalesforcePresentationManager *)defaultManager;

- (void)initialize;
- (void)openPresentationURL:(NSURL *)url;
- (void)rebuildPresentationCache;
- (NSString *)titleForPresentation;
- (NSURL *)URLForPresentation;

@end
