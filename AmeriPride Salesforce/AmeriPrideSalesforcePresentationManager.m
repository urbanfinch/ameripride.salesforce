//
//  AmeriPrideSalesforcePresentationManager.m
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 11/26/12.
//  Copyright (c) 2012 Aaron C Wright. All rights reserved.
//

#import "AmeriPrideSalesforcePresentationManager.h"

static AmeriPrideSalesforcePresentationManager *_defaultManager = nil;

@implementation AmeriPrideSalesforcePresentationManager

# pragma mark -
# pragma mark init

+ (AmeriPrideSalesforcePresentationManager *)defaultManager {
    @synchronized(self) {
        if (_defaultManager == nil) {
            _defaultManager = [[AmeriPrideSalesforcePresentationManager alloc] init];
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
# pragma mark presentations

- (NSString *)titleForPresentation {
    return @"";
}

- (NSString *)HTMLForPresentation {
    return @"";
}

- (NSURL *)baseURLForPresentation {
    return [NSURL URLWithString:@"/"];
}

- (NSData *)PDFDataForPresentation {
    return nil;
}

# pragma mark -
# pragma mark update

- (void)updatePresentation
{
    /*NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/~wsc/template.Presentation.zip"];
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     NSURLResponse *response = nil;
     NSError *error = nil;
     NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
     NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
     NSLog(@"%d", [httpResponse statusCode]);
     
     if ([httpResponse statusCode] == 404) // Presentation will be deleted and the default interface will be used ...
     {
     NSString *path = [documentsDirectory stringByAppendingPathComponent:@"template.Presentation"];
     [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
     return;
     }
     else if (error)
     {
     NSLog(@"%@", error);
     }
     
     BOOL didWriteData = [data writeToFile:zipFile atomically:YES];
     if (didWriteData)
     {
     BOOL success = [SSZipArchive unzipFileAtPath:zipFile toDestination:documentsDirectory];
     if (!success)
     {
     NSLog(@"failed to unzip file.");
     }
     }*/
}

@end