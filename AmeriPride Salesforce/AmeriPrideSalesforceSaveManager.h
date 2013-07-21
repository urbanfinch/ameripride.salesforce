//
//  AmeriPrideSalesforceSaveManager.h
//  AmeriPride Salesforce
//
//  Created by Aaron Wright on 2/15/13.
//  Copyright (c) 2013 Aaron C Wright. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AmeriPrideSalesforceNotifications.h"
#import "AmeriPrideSalesforceSave.h"

@interface AmeriPrideSalesforceSaveManager : NSObject

@property (nonatomic, strong) NSMutableArray *saves;
@property (nonatomic, strong) AmeriPrideSalesforceSave *save;

+ (AmeriPrideSalesforceSaveManager *)defaultManager;

- (void)initialize;
- (void)writeSave:(AmeriPrideSalesforceSave *)save;
- (NSString *)pathForSave;
- (NSString *)titleForSave;
- (NSURL *)URLForSave;

@end
