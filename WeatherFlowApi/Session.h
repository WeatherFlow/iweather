//
//  Session.h
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 29/11/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User, Status;

#define TokenKey @"wf_token"

@interface Session : NSObject {
    Status *status__;
    NSString *token__;
    User *user__;
}

- (id)initWithDictionary:(NSDictionary *) dictionary;

@property (readonly) Status *status;
@property (readonly) NSString *token;
@property (readonly) User *user;

@end
