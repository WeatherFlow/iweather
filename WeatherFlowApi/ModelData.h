//
//  ModelData.h
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 03/12/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ModelData : NSObject {
    CGFloat cloud_cover__;
    CGFloat lat__;
    CGFloat lon__;
    CGFloat max_wind_speed__;
    CGFloat max_wind_speed_distance__;
    NSInteger model_id__;
    NSInteger model_run_id__;
    NSString *model_run_name__;
    NSString *model_run_time_utc__;
    NSString *model_time_local__;
    NSString *model_time_utc__;
    NSString *precip_type__;
    CGFloat pres__;
    CGFloat prob_precip__;
    CGFloat temp__;
    CGFloat total_precip__;
    CGFloat vis__;
    NSInteger wave_direction__;
    CGFloat wave_height__;
    CGFloat wave_period__;
    NSInteger wind_dir__;
    NSString *wind_dir_txt__;
    CGFloat wind_speed__;
}

- (id)initWithDictionary:(NSDictionary *) dictionary;

@property (readonly) CGFloat cloud_cover;
@property (readonly) CGFloat lat;
@property (readonly) CGFloat lon;
@property (readonly) CGFloat max_wind_speed;
@property (readonly) CGFloat max_wind_speed_distance;
@property (readonly) NSInteger model_id;
@property (readonly) NSInteger model_run_id;
@property (readonly) NSString *model_run_name;
@property (readonly) NSString *model_run_time_utc;
@property (readonly) NSString *model_time_local;
@property (readonly) NSString *model_time_utc;
@property (readonly) NSDate *modelTime;
@property (readonly) NSString *precip_type;
@property (readonly) CGFloat pres;
@property (readonly) CGFloat prob_precip;
@property (readonly) CGFloat temp;
@property (readonly) CGFloat total_precip;
@property (readonly) CGFloat vis;
@property (readonly) NSInteger wave_direction;
@property (readonly) CGFloat wave_height;
@property (readonly) CGFloat wave_period;
@property (readonly) NSInteger wind_dir;
@property (readonly) NSString *wind_dir_txt;
@property (readonly) CGFloat wind_speed;


@end
