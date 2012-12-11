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
    self = [super init];
    if (self) {
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
- (CGFloat)max_wind
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

@end
