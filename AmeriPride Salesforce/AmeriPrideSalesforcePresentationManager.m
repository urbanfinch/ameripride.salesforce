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
    NSMutableArray *presentations = [NSMutableArray array];
    
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];

    NSArray *cachesContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cachesDirectory error:NULL];
    for (int count = 0; count < (int)[cachesContent count]; count++)
    {
        NSString *packagePath = [cachesDirectory stringByAppendingPathComponent:[cachesContent objectAtIndex:count]];
        NSString *packagePlistPath = [packagePath stringByAppendingPathComponent:@"/package.plist"];
        NSDictionary *packageDict = [[NSDictionary alloc] initWithContentsOfFile:packagePlistPath];
        NSArray *packagePresentations = [packageDict valueForKey:@"presentations"];
        
        for (NSDictionary *packagePresentationDict in packagePresentations) {
            AmeriPrideSalesforcePresentation *presentation = [[AmeriPrideSalesforcePresentation alloc] init];
            [presentation setTitle:[packagePresentationDict valueForKey:@"title"]];
            [presentation setFilename:[packagePresentationDict valueForKey:@"filename"]];
            
            NSURL *baseURL = [NSURL URLWithString:[packagePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            NSURL *URL = [[baseURL URLByAppendingPathComponent:[presentation filename]] URLByAppendingPathExtension:@"html"];
            NSURL *PDFURL = [[baseURL URLByAppendingPathComponent:[presentation filename]] URLByAppendingPathExtension:@"pdf"];
            
            [presentation setUrl:URL];
            [presentation setPdf:[NSData dataWithContentsOfFile:[PDFURL path]]];
            
            [presentations addObject:presentation];
        }
        
        count++;
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

@end