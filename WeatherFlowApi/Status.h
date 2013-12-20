//
//  Status.h
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 29/11/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import <Foundation/Foundation.h>

#define StatusKey @"status"

@interface Status : NSObject <NSCoding> {
    NSNumber *statusCode__;
    NSString *statusMessage__;
}

- (id)initWithDictionary:(NSDictionary *) dictionary;

@property (readonly) NSInteger statusCode;
@property (readonly) NSString *statusMessage;

@end
