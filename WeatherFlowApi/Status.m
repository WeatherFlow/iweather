//
//  Status.m
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 29/11/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import "Status.h"

static NSString *StatusCodeKey = @"status_code";
static NSString *StatusMessageKey = @"status_message";

@implementation Status

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (!self || ![dictionary objectForKey:StatusCodeKey] || ![dictionary objectForKey:StatusMessageKey]) {
        return nil;
    }
    statusCode__ = [dictionary objectForKey:StatusCodeKey];
    statusMessage__ = [dictionary objectForKey:StatusMessageKey];
    return self;
}

- (NSString *)description {
    NSString *description = [NSString stringWithFormat:@"%i %@", self.statusCode, self.statusMessage];
    return [NSString stringWithFormat:@"<%@: %p, %@>",
            NSStringFromClass([self class]), self, description];
}

//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInteger:self.statusCode forKey:@"statusCode"];
    [encoder encodeObject:self.statusMessage forKey:@"statusMessage"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        statusCode__ = [NSNumber numberWithInteger:[decoder decodeIntegerForKey:@"statusCode"]];
        statusMessage__ = [decoder decodeObjectForKey:@"statusMessage"];
    }
    return self;
}

- (NSInteger)statusCode {
    if (!statusCode__) {
        return -1;
    }
    return [statusCode__ integerValue];
}

- (NSString *)statusMessage {
    return statusMessage__;
}

@end
