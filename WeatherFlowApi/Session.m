//
//  Session.m
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 29/11/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import "Session.h"
#import "Status.h"
#import "User.h"

@implementation Session

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (!self) {
        return nil;
    }
    status__ = [[Status alloc] initWithDictionary:[dictionary objectForKey:StatusKey]];
    token__ = [dictionary objectForKey:TokenKey];
    user__ = [[User alloc] initWithDictionary:[dictionary objectForKey:UserKey]];
    return self;
}

- (NSString *)description {
    NSString *description = [NSString stringWithFormat:@"%@ %@ %@", self.status, self.token, self.user];
    return [NSString stringWithFormat:@"<%@: %p, %@>",
            NSStringFromClass([self class]), self, description];
}

- (Status *)status {
    return status__;
}

- (NSString *)token {
    return token__;
}

- (User *)user {
    return user__;
}

@end
