//
//  AmeriPrideSalesforceDocumentManager.h
//  AmeriPride Salesforce
//
//  Created by Aaron Wright on 2/15/13.
//  Copyright (c) 2013 Aaron C Wright. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZipArchive.h"

@interface AmeriPrideSalesforceDocumentManager : NSObject

+ (AmeriPrideSalesforceDocumentManager *)defaultManager;

- (void)openDocumentURL:(NSURL *)url;
- (void)rebuildDocumentCache;

@end
