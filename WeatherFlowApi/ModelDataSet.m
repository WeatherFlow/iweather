//
//  ModelDataSet.m
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 03/12/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import "ModelDataSet.h"
#import "Status.h"
#import "ModelData.h"

@implementation ModelDataSet

- (id)initWithDictionary:(NSDictionary *)dictionary {
    return [self initWithDictionary:dictionary andSpot:nil];
}

- (id)initWithDictionary:(NSDictionary *)dictionary andSpot:(Spot *)spot {
    self = [super init];
    if (self) {
        spot__ = spot;
        model_name__ = [dictionary objectForKey:@"model_name"];
        units_wind__ = [dictionary objectForKey:@"units_wind"];
        units_temp__ = [dictionary objectForKey:@"units_temp"];
        units_distance__ = [dictionary objectForKey:@"units_distance"];
        status__ = [[Status alloc] initWithDictionary:[dictionary objectForKey:@"status"]];
        max_wind__ = [[dictionary objectForKey:@"max_wind"] floatValue];
        max_wind_dir_txt__ = [dictionary objectForKey:@"max_wind_dir_txt"];
        max_wind_time_local__ = [dictionary objectForKey:@"max_wind_time_local"];
        model_color__ = [dictionary objectForKey:@"model_color"];
        NSArray *modelDataArray = [dictionary objectForKey:@"model_data"];
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:modelDataArray.count];
        for (NSDictionary *dictionary in modelDataArray) {
            ModelData *modelData = [[ModelData alloc] initWithDictionary:dictionary];
            [array addObject:modelData];
        }
        model_data__ = [NSArray arrayWithArray:array];
    }
    return self;    
}

- (NSString *)description {
    NSString *description = [NSString stringWithFormat:@"%@ %@ %@", self.model_name, self.status, self.spot];
    return [NSString stringWithFormat:@"<%@: %p, %@>",
            NSStringFromClass([self class]), self, description];
}

- (Spot *)spot {
    return spot__;
}
    
//===========================================================
//  model_name
//===========================================================
- (NSString *)model_name
{
    return model_name__;
}
//===========================================================
//  units_wind
//===========================================================
- (NSString *)units_wind
{
    return units_wind__;
}
//===========================================================
//  units_temp
//===========================================================
- (NSString *)units_temp
{
    return units_temp__;
}
//===========================================================
//  units_distance
//===========================================================
- (NSString *)units_distance
{
    return units_distance__;
}
//===========================================================
//  model_data
//===========================================================
- (NSArray *)model_data
{
    return model_data__;
}
//===========================================================
//  status
//===========================================================
- (Status *)status
{
    return status__;
}
//===========================================================
//  max_wind
//===========================================================
- (float)max_wind
{
    return max_wind__;
}
//===========================================================
//  max_wind_dir_txt
//===========================================================
- (NSString *)max_wind_dir_txt
{
    return max_wind_dir_txt__;
}
//===========================================================
//  max_wind_time_local
//===========================================================
- (NSString *)max_wind_time_local
{
    return max_wind_time_local__;
}
//===========================================================
//  model_color
//===========================================================
- (NSString *)model_color
{
    return model_color__;
}

//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.units_wind forKey:@"units_wind"];
    [encoder encodeObject:self.units_temp forKey:@"units_temp"];
    [encoder encodeObject:self.units_distance forKey:@"units_distance"];
    [encoder encodeObject:self.model_data forKey:@"model_data"];
    [encoder encodeObject:self.status forKey:@"status"];
    [encoder encodeFloat:self.max_wind forKey:@"max_wind"];
    [encoder encodeObject:self.max_wind_dir_txt forKey:@"max_wind_dir_txt"];
    [encoder encodeObject:self.max_wind_time_local forKey:@"max_wind_time_local"];
    [encoder encodeObject:self.model_color forKey:@"model_color"];
    [encoder encodeObject:self.spot forKey:@"spot"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        units_wind__ = [decoder decodeObjectForKey:@"units_wind"];
        units_temp__ = [decoder decodeObjectForKey:@"units_temp"];
        units_distance__ = [decoder decodeObjectForKey:@"units_distance"];
        model_data__ = [decoder decodeObjectForKey:@"model_data"];
        status__ = [decoder decodeObjectForKey:@"status"];
        max_wind__ = [decoder decodeFloatForKey:@"max_wind"];
        max_wind_dir_txt__ = [decoder decodeObjectForKey:@"max_wind_dir_txt"];
        max_wind_time_local__ = [decoder decodeObjectForKey:@"max_wind_time_local"];
        model_color__ = [decoder decodeObjectForKey:@"model_color"];
        spot__ = [decoder decodeObjectForKey:@"spot"];
    }
    return self;
}

@end
