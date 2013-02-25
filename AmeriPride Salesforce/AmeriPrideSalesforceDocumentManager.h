//
//  AmeriPrideSalesforceDocumentManager.h
//  AmeriPride Salesforce
//
//  Created by Aaron Wright on 2/15/13.
//  Copyright (c) 2013 Aaron C Wright. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AmeriPrideSalesforceNotifications.h"
#import "AmeriPrideSalesforceDocument.h"

@interface AmeriPrideSalesforceDocumentManager : NSObject

@property (nonatomic, strong) NSArray *documents;
@property (nonatomic, strong) AmeriPrideSalesforceDocument *document;

+ (AmeriPrideSalesforceDocumentManager *)defaultManager;

- (void)initialize;
- (void)openDocumentURL:(NSURL *)url;
- (NSString *)titleForDocument;
- (NSURL *)URLForDocument;

@end
