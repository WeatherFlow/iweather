//
//  SpotSet.h
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 30/11/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Status, Profile;

@interface SpotSet : NSObject {
    NSArray *spots__;
    Status *status__;
    double search_lat__;
    double search_lon__;
    NSInteger search_dist__;
    NSInteger spot_count__;
    NSInteger num_per_page__;
    NSInteger page__;
    NSString *units_temp__;
    NSString *units_wind__;
    NSString *profile_name__;
    NSInteger profile_id__;
    NSString *units_distance__;
    BOOL profile_alerts_enabled__;
    NSInteger accuracy__;
    NSString *current_time_utc__;
    NSString *current_time_local__;
    double center_lat__;
    double center_lon__;
    Profile *profile__;
}

- (id)initWithDictionary:(NSDictionary *) dictionary;

@property (readonly) NSArray *spots;
@property (readonly) Status *status;
@property (readonly) double search_lat;
@property (readonly) double search_lon;
@property (readonly) NSInteger search_dist;
@property (readonly) NSInteger spot_count;
@property (readonly) NSInteger num_per_page;
@property (readonly) NSInteger page;
@property (readonly) NSString *units_temp;
@property (readonly) NSString *units_wind;
@property (readonly) NSString *profile_name;
@property (readonly) NSInteger profile_id;
@property (readonly) NSString *units_distance;
@property (readonly) BOOL profile_alerts_enabled;
@property (readonly) NSInteger accuracy;
@property (readonly) NSString *current_time_utc;
@property (readonly) NSString *current_time_local;
@property (readonly) double center_lat;
@property (readonly) double center_lon;
@property (readonly) Profile *profile;

@end