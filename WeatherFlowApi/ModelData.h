//
//  ModelData.h
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 03/12/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelData : NSObject <NSCoding> {
    float cloud_cover__;
    float lat__;
    float lon__;
    float max_wind_speed__;
    float max_wind_speed_distance__;
    NSInteger model_id__;
    NSInteger model_run_id__;
    NSString *model_run_name__;
    NSString *model_run_time_utc__;
    NSString *model_time_local__;
    NSString *model_time_utc__;
    NSString *precip_type__;
    float pres__;
    float prob_precip__;
    float temp__;
    float total_precip__;
    float vis__;
    NSInteger wave_direction__;
    float wave_height__;
    float wave_period__;
    NSInteger wind_dir__;
    NSString *wind_dir_txt__;
    float wind_speed__;
}

- (id)initWithDictionary:(NSDictionary *) dictionary;

@property (readonly) float cloud_cover;
@property (readonly) float lat;
@property (readonly) float lon;
@property (readonly) float max_wind_speed;
@property (readonly) float max_wind_speed_distance;
@property (readonly) NSInteger model_id;
@property (readonly) NSInteger model_run_id;
@property (readonly) NSString *model_run_name;
@property (readonly) NSString *model_run_time_utc;
@property (readonly) NSString *model_time_local;
@property (readonly) NSString *model_time_utc;
@property (readonly) NSDate *modelTime;
@property (readonly) NSString *precip_type;
@property (readonly) float pres;
@property (readonly) float prob_precip;
@property (readonly) float temp;
@property (readonly) float total_precip;
@property (readonly) float vis;
@property (readonly) NSInteger wave_direction;
@property (readonly) float wave_height;
@property (readonly) float wave_period;
@property (readonly) NSInteger wind_dir;
@property (readonly) NSString *wind_dir_txt;
@property (readonly) float wind_speed;

@end