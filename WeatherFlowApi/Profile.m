//
//  Profile.m
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 30/11/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import "Profile.h"
#import "NSNull+WeatherFlowApiAdditions.h"

@implementation Profile

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        profile_id__ = [[dictionary objectForKey:@"profile_id"] integerValue];
        name__ = [dictionary objectForKey:@"name"];
        master__ = [[dictionary objectForKey:@"master"] boolValue];
        alerts_enabled__ = [[dictionary objectForKey:@"alerts_enabled"] boolValue];
        created_by__ = [dictionary objectForKey:@"created_by"];
        date_created__ = [dictionary objectForKey:@"date_created"];
        lat_center__ = [[dictionary objectForKey:@"lat_center"] boolValue];
        lon_center__ = [[dictionary objectForKey:@"lon_center"] boolValue];
        lat_max__ = [[dictionary objectForKey:@"lat_max"] boolValue];
        lat_min__ = [[dictionary objectForKey:@"lat_min"] boolValue];
        lon_max__ = [[dictionary objectForKey:@"lon_max"] boolValue];
        lon_min__ = [[dictionary objectForKey:@"lon_min"] boolValue];
        views__ = [[dictionary objectForKey:@"views"] integerValue];
        activity__ = [dictionary objectForKey:@"activity"];
        my_profile__ = [[dictionary objectForKey:@"my_profile"] boolValue];
        follower_count__ = [[dictionary objectForKey:@"follower_count"] integerValue];
        spot_count__ = [[dictionary objectForKey:@"spot_count"] integerValue];
        current_cond_count__ = [[dictionary objectForKey:@"current_cond_count"] integerValue];
        model_table_count__ = [[dictionary objectForKey:@"model_table_count"] integerValue];
        stats_count__ = [[dictionary objectForKey:@"stats_count"] integerValue];
        archive_count__ = [[dictionary objectForKey:@"archive_count"] integerValue];
        map_count__ = [[dictionary objectForKey:@"map_count"] integerValue];
        description__ = [dictionary objectForKey:@"description"];
    }
    return self;
}

//===========================================================
//  profile_id
//===========================================================
- (NSInteger)profile_id
{
    return profile_id__;
}
//===========================================================
//  name
//===========================================================
- (NSString *)name
{
    return name__;
}
//===========================================================
//  master
//===========================================================
- (BOOL)master
{
    return master__;
}
//===========================================================
//  alerts_enabled
//===========================================================
- (BOOL)alerts_enabled
{
    return alerts_enabled__;
}
//===========================================================
//  created_by
//===========================================================
- (NSString *)created_by
{
    return created_by__;
}
//===========================================================
//  date_created
//===========================================================
- (NSString *)date_created
{
    return date_created__;
}
//===========================================================
//  lat_center
//===========================================================
- (double)lat_center
{
    return lat_center__;
}
//===========================================================
//  lon_center
//===========================================================
- (double)lon_center
{
    return lon_center__;
}
//===========================================================
//  lat_max
//===========================================================
- (double)lat_max
{
    return lat_max__;
}
//===========================================================
//  lat_min
//===========================================================
- (double)lat_min
{
    return lat_min__;
}
//===========================================================
//  lon_max
//===========================================================
- (double)lon_max
{
    return lon_max__;
}
//===========================================================
//  lon_min
//===========================================================
- (double)lon_min
{
    return lon_min__;
}
//===========================================================
//  views
//===========================================================
- (NSInteger)views
{
    return views__;
}
//===========================================================
//  activity
//===========================================================
- (NSString *)activity
{
    return activity__;
}
//===========================================================
//  my_profile
//===========================================================
- (BOOL)my_profile
{
    return my_profile__;
}
//===========================================================
//  follower_count
//===========================================================
- (NSInteger)follower_count
{
    return follower_count__;
}
//===========================================================
//  spot_count
//===========================================================
- (NSInteger)spot_count
{
    return spot_count__;
}
//===========================================================
//  current_cond_count
//===========================================================
- (NSInteger)current_cond_count
{
    return current_cond_count__;
}
//===========================================================
//  model_table_count
//===========================================================
- (NSInteger)model_table_count
{
    return model_table_count__;
}
//===========================================================
//  stats_count
//===========================================================
- (NSInteger)stats_count
{
    return stats_count__;
}
//===========================================================
//  archive_count
//===========================================================
- (NSInteger)archive_count
{
    return archive_count__;
}
//===========================================================
//  map_count
//===========================================================
- (NSInteger)map_count
{
    return map_count__;
}
//===========================================================
//  description
//===========================================================
- (NSString *)description
{
    return description__;
}


@end
