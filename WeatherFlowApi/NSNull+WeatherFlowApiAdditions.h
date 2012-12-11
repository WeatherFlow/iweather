//
//  NSNull+WeatherFlowApiAdditions.h
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 30/11/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNull (WeatherFlowApiAdditions)

- (BOOL) boolValue;
- (NSInteger) integerValue;
- (double) doubleValue;

@end
