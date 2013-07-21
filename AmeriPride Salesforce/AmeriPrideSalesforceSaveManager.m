//
//  AmeriPrideSalesforceSaveManager.m
//  AmeriPride Salesforce
//
//  Created by Aaron Wright on 2/15/13.
//  Copyright (c) 2013 Aaron C Wright. All rights reserved.
//

#import "AmeriPrideSalesforceSaveManager.h"

static AmeriPrideSalesforceSaveManager *_defaultManager = nil;

@implementation AmeriPrideSalesforceSaveManager

@synthesize saves = _saves;
@synthesize save = _save;

# pragma mark -
# pragma mark init

+ (AmeriPrideSalesforceSaveManager *)defaultManager {
    @synchronized(self) {
        if (_defaultManager == nil) {
            _defaultManager = [[AmeriPrideSalesforceSaveManager alloc] init];
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
    NSMutableArray *saves = [NSMutableArray array];
    [self setSaves:saves];
    
    NSArray *archivedSaves = [NSKeyedUnarchiver unarchiveObjectWithFile:[self pathForSave]];
    
    if ([archivedSaves count] > 0) {
        [self setSaves:[archivedSaves mutableCopy]];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:AmeriPrideSalesforceSavesDidInitializeNotification object:self];
}

# pragma mark -
# pragma mark write

- (void)writeSave:(AmeriPrideSalesforceSave *)save {
    [_saves addObject:save];
    
    [NSKeyedArchiver archiveRootObject:_saves toFile:[self pathForSave]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:AmeriPrideSalesforceSavesDidChangeNotification object:self];
}

# pragma mark -
# pragma mark saves

- (NSString *)pathForSave {
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = [docsPath stringByAppendingPathComponent:@"Saves"];
    return filename;
}

- (NSString *)titleForSave {
    return [_save title];
}

- (NSURL *)URLForSave {
    return [_save url];
}

@end
