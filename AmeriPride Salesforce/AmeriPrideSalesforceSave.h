//
//  AmeriPrideSalesforceSave.h
//  AmeriPride Salesforce
//
//  Created by Aaron C Wright on 7/21/13.
//  Copyright (c) 2013 Aaron C Wright. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AmeriPrideSalesforceSave : NSObject <NSCoding>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *presentation;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *data;
@property (nonatomic, strong) NSURL *url;

@end
