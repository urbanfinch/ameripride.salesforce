//
//  AmeriPrideSalesforcePresentation.h
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 12/11/12.
//  Copyright (c) 2012 Aaron C Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AmeriPrideSalesforcePresentation : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSData *pdf;
@property (nonatomic, strong) NSURL *url;

@end
