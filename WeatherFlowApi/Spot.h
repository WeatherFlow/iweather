//
//  Spot.h
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 30/11/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class Status, ModelDataSet;

@interface Spot : NSObject <MKAnnotation> {
    NSInteger spot_id__;
    NSString *name__;
    NSInteger type__;
    double distance__;
    double lat__;
    double lon__;
    NSInteger provider__;
    NSInteger region_id__;
    BOOL is_favorite__;
    BOOL wind_alert_exists__;
    BOOL wind_alert_active__;
    BOOL upgrade_available__;
    //NSDate timestamp__;
    NSString *timestamp__;
    double avg__;
    double lull__;
    double gust__;
    NSInteger dir__;
    NSString *dir_text__;
    double atemp__;
    double wtemp__;
    Status *status__;
    NSString *spot_message__;
    NSString *source_message__;
    double rank__;
    NSInteger fav_sort_order__;
    double wave_height__;
    double wave_period__;
    NSString *current_time_local__;
    double pres__;
    NSString *timezone__;
    NSString *favorite_lists__;
    NSInteger fav_spot_id__;
    NSString *wind_desc__;
    MKAnnotationView *annotationView__;
}

- (id)initWithDictionary:(NSDictionary *) dictionary;

@property (readonly) NSInteger spot_id;
@property (readonly) NSString *name;
@property (readonly) NSInteger type;
@property (readonly) double distance;
@property (readonly) double lat;
@property (readonly) double lon;
@property (readonly) NSInteger provider;
@property (readonly) NSInteger region_id;
@property (readonly) BOOL is_favorite;
@property (readonly) BOOL wind_alert_exists;
@property (readonly) BOOL wind_alert_active;
@property (readonly) BOOL upgrade_available;
//@property (readonly) NSDate timestamp;
@property (readonly) NSString *timestamp;
@property (readonly) double avg;
@property (readonly) double lull;
@property (readonly) double gust;
@property (readonly) NSInteger dir;
@property (readonly) NSString *dir_text;
@property (readonly) double atemp;
@property (readonly) double wtemp;
@property (readonly) Status *status;
@property (readonly) NSString *spot_message;
@property (readonly) NSString *source_message;
@property (readonly) double rank;
@property (readonly) NSInteger fav_sort_order;
@property (readonly) double wave_height;
@property (readonly) double wave_period;
@property (readonly) NSString *current_time_local;
@property (readonly) double pres;
@property (readonly) NSString *timezone;
@property (readonly) NSString *favorite_lists;
@property (readonly) NSInteger fav_spot_id;
@property (readonly) NSString *wind_desc;

#pragma mark - MKAnnotation
- (CLLocationCoordinate2D)coordinate;
- (NSString *)title;
- (NSString *)subtitle;

#pragma mark - Annotation View
#if TARGET_OS_IPHONE
- (MKAnnotationView *) annotationView;
#endif

#pragma mark - Helper
- (BOOL)isEqual:(id)object;
- (CLLocationDistance) distanceFrom:(CLLocation *) location;
- (ModelDataSet *) getModelData;
- (ModelDataSet *)getModelDataError:(NSError **) error;

@end
