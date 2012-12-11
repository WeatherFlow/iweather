//
//  ModelDataSet.h
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 03/12/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Status;

@interface ModelDataSet : NSObject {
    NSString *model_name__;
    NSString *units_wind__;
    NSString *units_temp__;
    NSString *units_distance__;
    NSArray *model_data__;
    Status *status__;
    CGFloat max_wind__;
    NSString *max_wind_dir_txt__;
    NSString *max_wind_time_local__;
    NSString *model_color__;
}

- (id)initWithDictionary:(NSDictionary *) dictionary;

@property (readonly) NSString *model_name;
@property (readonly) NSString *units_wind;
@property (readonly) NSString *units_temp;
@property (readonly) NSString *units_distance;
@property (readonly) NSArray *model_data;
@property (readonly) Status *status;
@property (readonly) CGFloat max_wind;
@property (readonly) NSString *max_wind_dir_txt;
@property (readonly) NSString *max_wind_time_local;
@property (readonly) NSString *model_color;

@end
