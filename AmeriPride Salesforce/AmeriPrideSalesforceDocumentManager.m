//
//  AmeriPrideSalesforceDocumentManager.m
//  AmeriPride Salesforce
//
//  Created by Aaron Wright on 2/15/13.
//  Copyright (c) 2013 Aaron C Wright. All rights reserved.
//

#import "AmeriPrideSalesforceDocumentManager.h"

static AmeriPrideSalesforceDocumentManager *_defaultManager = nil;

@implementation AmeriPrideSalesforceDocumentManager

# pragma mark -
# pragma mark init

+ (AmeriPrideSalesforceDocumentManager *)defaultManager {
    @synchronized(self) {
        if (_defaultManager == nil) {
            _defaultManager = [[AmeriPrideSalesforceDocumentManager alloc] init];
        }
    }
    return _defaultManager;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (_defaultManager == nil) {
            return [super allocWithZone:zone];
        }
    }
    return _defaultManager;
}

+ (id)copyWithZone:(NSZone *)zone {
    return self;
}

# pragma mark -
# pragma mark open

- (void)openDocumentURL:(NSURL *)url {
    NSURL *sourceURL = [NSURL fileURLWithPath:[url path]];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSURL *documentURL = [[NSURL fileURLWithPath:documentsDirectory] URLByAppendingPathComponent:[sourceURL lastPathComponent]];
    NSURL *inboxURL = [NSURL fileURLWithPath:[[[NSURL fileURLWithPath:documentsDirectory] URLByAppendingPathComponent:@"Inbox"] path] isDirectory:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSError *error;
        
        if (![fileManager copyItemAtURL:sourceURL toURL:documentURL error:&error]) {
            if ([fileManager removeItemAtURL:documentURL error:&error]) {
                if (![fileManager copyItemAtURL:sourceURL toURL:documentURL error:&error]) {
                    NSLog(@"Could not copy file at url: %@ to url: %@", url, documentURL);
                }
            }
        }
        
        if (![fileManager removeItemAtURL:inboxURL error:&error]) {
            NSLog(@"Could not remove inbox at url: %@ ", inboxURL);
        }
    });
}

# pragma mark -
# pragma mark notification

- (void)postRebuildDocumentCacheNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:AmeriPrideSalesforceCacheRebuildCompleteNotification object:self];
}

# pragma mark -
# pragma mark rebuild

- (void)rebuildDocumentCache {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSError *error;
        
        NSArray *cachesContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cachesDirectory error:NULL];
        for (int count = 0; count < (int)[cachesContent count]; count++)
        {
            NSURL *contentURL = [NSURL fileURLWithPath:[cachesDirectory stringByAppendingPathComponent:[cachesContent objectAtIndex:count]]];
            if (![fileManager removeItemAtURL:contentURL error:&error]) {
                NSLog(@"Could not remove file at path: %@", contentURL);
            }
        }
        
        ZipArchive *za = [[ZipArchive alloc] init];
        
        NSArray *documentsContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:NULL];
        for (int count = 0; count < (int)[documentsContent count]; count++)
        {
            if ([[[documentsContent objectAtIndex:count] pathExtension] isEqualToString:@"appdz"]) {
                NSString *documentPath = [documentsDirectory stringByAppendingPathComponent:[documentsContent objectAtIndex:count]];
                if ([za UnzipOpenFile:documentPath]) {
                    [za UnzipFileTo:cachesDirectory overWrite:YES];
                    [za UnzipCloseFile];
                }
            }
        }
        
        [self performSelectorOnMainThread:@selector(postRebuildDocumentCacheNotification) withObject:nil waitUntilDone:NO];
    });
}

@end
