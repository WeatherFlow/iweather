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

- (NSString *)description {
    NSString *description = [NSString stringWithFormat:@"%0.1f %0.1f %@ %0.1f %@", self.lat, self.lon, self.modelTime, self.wind_speed, self.wind_dir_txt];
    return [NSString stringWithFormat:@"<%@: %p, %@>",
            NSStringFromClass([self class]), self, description];
}
//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeFloat:self.cloud_cover forKey:@"cloud_cover"];
    [encoder encodeFloat:self.lat forKey:@"lat"];
    [encoder encodeFloat:self.lon forKey:@"lon"];
    [encoder encodeFloat:self.max_wind_speed forKey:@"max_wind_speed"];
    [encoder encodeFloat:self.max_wind_speed_distance forKey:@"max_wind_speed_distance"];
    [encoder encodeInteger:self.model_id forKey:@"model_id"];
    [encoder encodeInteger:self.model_run_id forKey:@"model_run_id"];
    [encoder encodeObject:self.model_run_name forKey:@"model_run_name"];
    [encoder encodeObject:self.model_run_time_utc forKey:@"model_run_time_utc"];
    [encoder encodeObject:self.model_time_local forKey:@"model_time_local"];
    [encoder encodeObject:self.model_time_utc forKey:@"model_time_utc"];
    [encoder encodeObject:self.modelTime forKey:@"modelTime"];
    [encoder encodeObject:self.precip_type forKey:@"precip_type"];
    [encoder encodeFloat:self.pres forKey:@"pres"];
    [encoder encodeFloat:self.prob_precip forKey:@"prob_precip"];
    [encoder encodeFloat:self.temp forKey:@"temp"];
    [encoder encodeFloat:self.total_precip forKey:@"total_precip"];
    [encoder encodeFloat:self.vis forKey:@"vis"];
    [encoder encodeInteger:self.wave_direction forKey:@"wave_direction"];
    [encoder encodeFloat:self.wave_height forKey:@"wave_height"];
    [encoder encodeFloat:self.wave_period forKey:@"wave_period"];
    [encoder encodeInteger:self.wind_dir forKey:@"wind_dir"];
    [encoder encodeObject:self.wind_dir_txt forKey:@"wind_dir_txt"];
    [encoder encodeFloat:self.wind_speed forKey:@"wind_speed"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        cloud_cover__ = [decoder decodeFloatForKey:@"cloud_cover"];
        lat__ = [decoder decodeFloatForKey:@"lat"];
        lon__ = [decoder decodeFloatForKey:@"lon"];
        max_wind_speed__ = [decoder decodeFloatForKey:@"max_wind_speed"];
        max_wind_speed_distance__ = [decoder decodeFloatForKey:@"max_wind_speed_distance"];
        model_id__ = [decoder decodeIntegerForKey:@"model_id"];
        model_run_id__ = [decoder decodeIntegerForKey:@"model_run_id"];
        model_run_name__ = [decoder decodeObjectForKey:@"model_run_name"];
        model_run_time_utc__ = [decoder decodeObjectForKey:@"model_run_time_utc"];
        model_time_local__ = [decoder decodeObjectForKey:@"model_time_local"];
        model_time_utc__ = [decoder decodeObjectForKey:@"model_time_utc"];
        precip_type__ = [decoder decodeObjectForKey:@"precip_type"];
        pres__ = [decoder decodeFloatForKey:@"pres"];
        prob_precip__ = [decoder decodeFloatForKey:@"prob_precip"];
        temp__ = [decoder decodeFloatForKey:@"temp"];
        total_precip__ = [decoder decodeFloatForKey:@"total_precip"];
        vis__ = [decoder decodeFloatForKey:@"vis"];
        wave_direction__ = [decoder decodeIntegerForKey:@"wave_direction"];
        wave_height__ = [decoder decodeFloatForKey:@"wave_height"];
        wave_period__ = [decoder decodeFloatForKey:@"wave_period"];
        wind_dir__ = [decoder decodeIntegerForKey:@"wind_dir"];
        wind_dir_txt__ = [decoder decodeObjectForKey:@"wind_dir_txt"];
        wind_speed__ = [decoder decodeFloatForKey:@"wind_speed"];
    }
    return self;
}
//===========================================================
//  cloud_cover
//===========================================================
- (float)cloud_cover
{
    return cloud_cover__;
}
//===========================================================
//  lat
//===========================================================
- (float)lat
{
    return lat__;
}
//===========================================================
//  lon
//===========================================================
- (float)lon
{
    return lon__;
}
//===========================================================
//  max_wind_speed
//===========================================================
- (float)max_wind_speed
{
    return max_wind_speed__;
}
//===========================================================
//  max_wind_speed_distance
//===========================================================
- (float)max_wind_speed_distance
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

- (NSDate *)modelTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ssZZZ"];
    
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:self.model_time_utc];
    return date;
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
- (float)pres
{
    return pres__;
}
//===========================================================
//  prob_precip
//===========================================================
- (float)prob_precip
{
    return prob_precip__;
}
//===========================================================
//  temp
//===========================================================
- (float)temp
{
    return temp__;
}
//===========================================================
//  total_precip
//===========================================================
- (float)total_precip
{
    return total_precip__;
}
//===========================================================
//  vis
//===========================================================
- (float)vis
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
- (float)wave_height
{
    return wave_height__;
}
//===========================================================
//  wave_period
//===========================================================
- (float)wave_period
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
- (float)wind_speed
{
    return wind_speed__;
}

@end
