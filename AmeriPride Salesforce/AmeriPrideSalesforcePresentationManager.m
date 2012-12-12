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

@synthesize presentations = _presentations;
@synthesize presentation = _presentation;

# pragma mark -
# pragma mark init

+ (AmeriPrideSalesforcePresentationManager *)defaultManager {
    @synchronized(self) {
        if (_defaultManager == nil) {
            _defaultManager = [[AmeriPrideSalesforcePresentationManager alloc] init];
            
            [_defaultManager initialize];
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

- (void)initialize {
    NSString *packagePath = [[NSBundle mainBundle] pathForResource:@"Demo" ofType:@"apppkg"];
    NSString *packagePlistPath = [packagePath stringByAppendingPathComponent:@"/Package.plist"];
    NSDictionary *packageDict = [[NSDictionary alloc] initWithContentsOfFile:packagePlistPath];
    NSArray *packagePresentations = [packageDict valueForKey:@"presentations"];
    
    NSMutableArray *presentations = [NSMutableArray array];
    
    for (NSDictionary *packagePresentationDict in packagePresentations) {
        AmeriPrideSalesforcePresentation *presentation = [[AmeriPrideSalesforcePresentation alloc] init];
        [presentation setTitle:[packagePresentationDict valueForKey:@"title"]];
        
        NSURL *baseURL = [NSURL URLWithString:[packagePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURL *URL = [[baseURL URLByAppendingPathComponent:[presentation title]] URLByAppendingPathExtension:@"html"];
        NSURL *PDFURL = [[baseURL URLByAppendingPathComponent:[packagePresentationDict valueForKey:@"pdf"]] URLByAppendingPathExtension:@"pdf"];
        
        [presentation setUrl:URL];
        [presentation setPdf:[NSData dataWithContentsOfFile:[PDFURL path]]];
        
        [presentations addObject:presentation];
    }
    
    if ([presentations count] > 0) {
        [self setPresentations:[presentations copy]];
        [self setPresentation:[presentations objectAtIndex:0]];
    }
}

# pragma mark -
# pragma mark presentations

- (NSString *)titleForPresentation {
    return [_presentation title];
}

- (NSURL *)URLForPresentation {
    return [_presentation url];
}

- (NSData *)PDFDataForPresentation {
    return [_presentation pdf];
}

# pragma mark -
# pragma mark update

- (void)updatePresentations:(id)sender
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