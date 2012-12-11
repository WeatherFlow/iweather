//
//  Profile.h
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 30/11/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Profile : NSObject {
    NSInteger profile_id__;
    NSString *name__;
    BOOL master__;
    BOOL alerts_enabled__;
    NSString *created_by__;
    NSString *date_created__;
    double lat_center__;
    double lon_center__;
    double lat_max__;
    double lat_min__;
    double lon_max__;
    double lon_min__;
    NSInteger views__;
    NSString *activity__;
    BOOL my_profile__;
    NSInteger follower_count__;
    NSInteger spot_count__;
    NSInteger current_cond_count__;
    NSInteger model_table_count__;
    NSInteger stats_count__;
    NSInteger archive_count__;
    NSInteger map_count__;
    NSString *description__;
}

- (id)initWithDictionary:(NSDictionary *) dictionary;

@property (readonly) NSInteger profile_id;
@property (readonly) NSString *name;
@property (readonly) BOOL master;
@property (readonly) BOOL alerts_enabled;
@property (readonly) NSString *created_by;
@property (readonly) NSString *date_created;
@property (readonly) double lat_center;
@property (readonly) double lon_center;
@property (readonly) double lat_max;
@property (readonly) double lat_min;
@property (readonly) double lon_max;
@property (readonly) double lon_min;
@property (readonly) NSInteger views;
@property (readonly) NSString *activity;
@property (readonly) BOOL my_profile;
@property (readonly) NSInteger follower_count;
@property (readonly) NSInteger spot_count;
@property (readonly) NSInteger current_cond_count;
@property (readonly) NSInteger model_table_count;
@property (readonly) NSInteger stats_count;
@property (readonly) NSInteger archive_count;
@property (readonly) NSInteger map_count;
@property (readonly) NSString *description;

@end
