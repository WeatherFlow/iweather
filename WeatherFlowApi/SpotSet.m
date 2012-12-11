//
//  SpotSet.m
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 30/11/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import "SpotSet.h"
#import "Status.h"
#import "Profile.h"
#import "Spot.h"
#import "NSNull+WeatherFlowApiAdditions.h"

@implementation SpotSet

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        NSArray *data_names = [dictionary objectForKey:@"data_names"];
        NSArray *data_values = [dictionary objectForKey:@"data_values"];
        [self setSpotsWithNames:data_names values:data_values];
        status__ = [[Status alloc] initWithDictionary:[dictionary objectForKey:@"status"]];
        search_lat__ = [[dictionary objectForKey:@"search_lat"] doubleValue];
        search_lon__ = [[dictionary objectForKey:@"search_lon"] doubleValue];
        search_dist__ = [[dictionary objectForKey:@"search_dist"] integerValue];
        spot_count__ = [[dictionary objectForKey:@"spot_count"] integerValue];
        num_per_page__ = [[dictionary objectForKey:@"num_per_page"] integerValue];
        page__ = [[dictionary objectForKey:@"page"] integerValue];
        units_temp__ = [dictionary objectForKey:@"units_temp"];
        units_wind__ = [dictionary objectForKey:@"units_wind"];
        profile_name__ = [dictionary objectForKey:@"profile_name"];
        profile_id__ = [[dictionary objectForKey:@"profile_id"] integerValue];
        units_distance__ = [dictionary objectForKey:@"units_distance"];
        profile_alerts_enabled__ = [[dictionary objectForKey:@"profile_alerts_enabled"] boolValue];
        accuracy__ = [[dictionary objectForKey:@"accuracy"] integerValue];
        current_time_utc__ = [dictionary objectForKey:@"current_time_utc"];
        current_time_local__ = [dictionary objectForKey:@"current_time_local"];
        center_lat__ = [[dictionary objectForKey:@"center_lat"] doubleValue];
        center_lon__ = [[dictionary objectForKey:@"center_lon"] doubleValue];
        profile__ = [[Profile alloc] initWithDictionary:[dictionary objectForKey:@"profile"]];
    }
    return self;
}

- (NSString *)description {
    NSString *description = [NSString stringWithFormat:@"%0.4f %0.4f\n%@", self.search_lat, self.search_lon, self.spots];
    return [NSString stringWithFormat:@"<%@: %p, %@>",
            NSStringFromClass([self class]), self, description];
}

//===========================================================
//  spots
//===========================================================
- (NSArray *)spots
{
    return spots__;
}
- (void) setSpotsWithNames:(NSArray *) data_names values:(NSArray *) data_values {
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:data_values.count];
    for (NSArray *values in data_values) {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        NSInteger index = 0;
        for (NSString *key in data_names) {
            id value = [values objectAtIndex:index];
            [dictionary setObject:value forKey:key];
            index++;
        }
        Spot *spot = [[Spot alloc] initWithDictionary:dictionary];
        [array addObject:spot];
    }
    spots__ = array;
}

//===========================================================
//  status
//===========================================================
- (Status *)status
{
    return status__;
}
//===========================================================
//  search_lat
//===========================================================
- (double)search_lat
{
    return search_lat__;
}
//===========================================================
//  search_lon
//===========================================================
- (double)search_lon
{
    return search_lon__;
}
//===========================================================
//  search_dist
//===========================================================
- (NSInteger)search_dist
{
    return search_dist__;
}
//===========================================================
//  spot_count
//===========================================================
- (NSInteger)spot_count
{
    return spot_count__;
}
//===========================================================
//  num_per_page
//===========================================================
- (NSInteger)num_per_page
{
    return num_per_page__;
}
//===========================================================
//  page
//===========================================================
- (NSInteger)page
{
    return page__;
}
//===========================================================
//  units_temp
//===========================================================
- (NSString *)units_temp
{
    return units_temp__;
}
//===========================================================
//  units_wind
//===========================================================
- (NSString *)units_wind
{
    return units_wind__;
}
//===========================================================
//  profile_name
//===========================================================
- (NSString *)profile_name
{
    return profile_name__;
}
//===========================================================
//  profile_id
//===========================================================
- (NSInteger)profile_id
{
    return profile_id__;
}
//===========================================================
//  units_distance
//===========================================================
- (NSString *)units_distance
{
    return units_distance__;
}
//===========================================================
//  profile_alerts_enabled
//===========================================================
- (BOOL)profile_alerts_enabled
{
    return profile_alerts_enabled__;
}
//===========================================================
//  accuracy
//===========================================================
- (NSInteger)accuracy
{
    return accuracy__;
}
//===========================================================
//  current_time_utc
//===========================================================
- (NSString *)current_time_utc
{
    return current_time_utc__;
}
//===========================================================
//  current_time_local
//===========================================================
- (NSString *)current_time_local
{
    return current_time_local__;
}
//===========================================================
//  center_lat
//===========================================================
- (double)center_lat
{
    return center_lat__;
}
//===========================================================
//  center_lon
//===========================================================
- (double)center_lon
{
    return center_lon__;
}
//===========================================================
//  profile
//===========================================================
- (Profile *)profile
{
    return profile__;
}

@end