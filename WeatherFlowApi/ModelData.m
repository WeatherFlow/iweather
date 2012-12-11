//
//  ModelData.m
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 03/12/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import "ModelData.h"

@implementation ModelData

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        cloud_cover__ = [[dictionary objectForKey:@"cloud_cover"] floatValue];
        lat__ = [[dictionary objectForKey:@"lat"] floatValue];
        lon__ = [[dictionary objectForKey:@"lon"] floatValue];
        max_wind_speed__ = [[dictionary objectForKey:@"max_wind_speed"] floatValue];
        max_wind_speed_distance__ = [[dictionary objectForKey:@"max_wind_speed_distance"] floatValue];
        model_id__ = [[dictionary objectForKey:@"model_id"] integerValue];
        model_run_id__ = [[dictionary objectForKey:@"model_run_id"] integerValue];
        model_run_name__ = [dictionary objectForKey:@"model_run_name"];
        model_run_time_utc__ = [dictionary objectForKey:@"model_run_time_utc"];
        model_time_local__ = [dictionary objectForKey:@"model_time_local"];
        model_time_utc__ = [dictionary objectForKey:@"model_time_utc"];
        precip_type__ = [dictionary objectForKey:@"precip_type"];
        pres__ = [[dictionary objectForKey:@"pres"] floatValue];
        prob_precip__ = [[dictionary objectForKey:@"prob_precip"] floatValue];
        temp__ = [[dictionary objectForKey:@"temp"] floatValue];
        total_precip__ = [[dictionary objectForKey:@"total_precip"] floatValue];
        vis__ = [[dictionary objectForKey:@"vis"] floatValue];
        wave_direction__ = [[dictionary objectForKey:@"wave_direction"] integerValue];
        wave_height__ = [[dictionary objectForKey:@"wave_height"] floatValue];
        wave_period__ = [[dictionary objectForKey:@"wave_period"] floatValue];
        wind_dir__ = [[dictionary objectForKey:@"wind_dir"] integerValue];
        wind_dir_txt__ = [dictionary objectForKey:@"wind_dir_txt"];
        wind_speed__ = [[dictionary objectForKey:@"wind_speed"] floatValue];
    }
    return self;
}

//===========================================================
//  cloud_cover
//===========================================================
- (CGFloat)cloud_cover
{
    return cloud_cover__;
}
//===========================================================
//  lat
//===========================================================
- (CGFloat)lat
{
    return lat__;
}
//===========================================================
//  lon
//===========================================================
- (CGFloat)lon
{
    return lon__;
}
//===========================================================
//  max_wind_speed
//===========================================================
- (CGFloat)max_wind_speed
{
    return max_wind_speed__;
}
//===========================================================
//  max_wind_speed_distance
//===========================================================
- (CGFloat)max_wind_speed_distance
{
    return max_wind_speed_distance__;
}
//===========================================================
//  model_id
//===========================================================
- (NSInteger)model_id
{
    return model_id__;
}
//===========================================================
//  model_run_id
//===========================================================
- (NSInteger)model_run_id
{
    return model_run_id__;
}
//===========================================================
//  model_run_name
//===========================================================
- (NSString *)model_run_name
{
    return model_run_name__;
}
//===========================================================
//  model_run_time_utc
//===========================================================
- (NSString *)model_run_time_utc
{
    return model_run_time_utc__;
}
//===========================================================
//  model_time_local
//===========================================================
- (NSString *)model_time_local
{
    return model_time_local__;
}
//===========================================================
//  model_time_utc
//===========================================================
- (NSString *)model_time_utc
{
    return model_time_utc__;
}
//===========================================================
//  precip_type
//===========================================================
- (NSString *)precip_type
{
    return precip_type__;
}
//===========================================================
//  pres
//===========================================================
- (CGFloat)pres
{
    return pres__;
}
//===========================================================
//  prob_precip
//===========================================================
- (CGFloat)prob_precip
{
    return prob_precip__;
}
//===========================================================
//  temp
//===========================================================
- (CGFloat)temp
{
    return temp__;
}
//===========================================================
//  total_precip
//===========================================================
- (CGFloat)total_precip
{
    return total_precip__;
}
//===========================================================
//  vis
//===========================================================
- (CGFloat)vis
{
    return vis__;
}
//===========================================================
//  wave_direction
//===========================================================
- (NSInteger)wave_direction
{
    return wave_direction__;
}
//===========================================================
//  wave_height
//===========================================================
- (CGFloat)wave_height
{
    return wave_height__;
}
//===========================================================
//  wave_period
//===========================================================
- (CGFloat)wave_period
{
    return wave_period__;
}
//===========================================================
//  wind_dir
//===========================================================
- (NSInteger)wind_dir
{
    return wind_dir__;
}
//===========================================================
//  wind_dir_txt
//===========================================================
- (NSString *)wind_dir_txt
{
    return wind_dir_txt__;
}
//===========================================================
//  wind_speed
//===========================================================
- (CGFloat)wind_speed
{
    return wind_speed__;
}

@end
