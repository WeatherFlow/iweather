//
//  NSNull+WeatherFlowApiAdditions.m
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 30/11/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import "NSNull+WeatherFlowApiAdditions.h"
#import "WeatherFlowApi.h"

@implementation NSNull (WeatherFlowApiAdditions)

- (BOOL)boolValue {
    return FALSE;
}

- (NSInteger)integerValue {
    return kInvalidInteger;
}

- (double)doubleValue {
    return kInvalidDouble;
}

@end
