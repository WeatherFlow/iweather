//
//  WeatherFlowApi.h
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 29/11/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//
#if TARGET_OS_IPHONE
    #import "WeatherFlowMapView.h"
    #import "WeatherFlowMapViewController.h"
    #import <UIKit/UIKit.h>
#else
    #import <AppKit/AppKit.h>
#endif
#import "Session.h"
#import "SpotSet.h"
#import "Spot.h"
#import "Status.h"
#import "ModelData.h"
#import "ModelDataSet.h"

#define kInvalidInteger -9999
#define kInvalidDouble -9999.9

typedef enum {
    WFUnitDistanceKm,
    WFUnitDistanceMi,
    numWFUnitDistance
} WFUnitDistance;

typedef enum {
    WFUnitWindMph,
    WFUnitWindKts,
    WFUnitWindKph,
    WFUnitWindMps,
    numWFUnitWind
} WFUnitWind;

typedef enum {
    WFUnitTempC,
    WFUnitTempF,
    numWFUnitTemp
} WFUnitTemp;

@interface WeatherFlowApi : NSObject

+ (NSString *) apiKey;
+ (void) setApiKey:(NSString *) key;

+ (WFUnitDistance) unitDistance;
+ (void) setUnitDistance:(WFUnitDistance) unitDistance;

+ (WFUnitTemp) unitTemp;
+ (void) setUnitTemp:(WFUnitTemp) unitTemp;

+ (WFUnitWind) unitWind;
+ (void) setUnitWind:(WFUnitWind) unitWind;

+ (BOOL) includeWindSpeedOnArrows;
+ (void) setIncludeWindSpeedOnArrows:(BOOL) include;

+ (BOOL) includeVirtualWeatherStations;
+ (void) setIncludeVirtualWeatherStations:(BOOL) include;

+ (Session *) session;

+ (NSString *) stringForUnitDistance:(WFUnitDistance) unit;
+ (NSString *) stringForUnitWind:(WFUnitWind) unit;
+ (NSString *) stringForUnitTemp:(WFUnitTemp) unit;


+ (Session *) getToken;
+ (SpotSet *) getSpotSetBySearch:(NSString *) search distance:(NSInteger) distance error:(NSError **) error;
+ (SpotSet *) getSpotSetByLocation:(CLLocationCoordinate2D) location distance:(NSInteger) distance  error:(NSError **) error;
+ (SpotSet *) getSpotSetByLocationCoordinate:(CLLocationCoordinate2D) location distance:(NSInteger) distance error:(NSError **) error;
+ (SpotSet *) getSpotSetByZoomLevel:(NSInteger) zoomLevel lat_min:(float) latMin lon_min:(float) lonMin lat_max:(float) latMax lon_max:(float) lonMax error:(NSError **) error;

+ (Spot *) getClosestSpotByLocation:(CLLocationCoordinate2D) location distance:(float) distance error:(NSError **) error;

+ (ModelDataSet *) getModelDataBySpot:(Spot *) spot error:(NSError **) error;
+ (ModelDataSet *) getModelDataBySpotID:(NSInteger) spotID error:(NSError **) error;

#pragma mark - Helper

#if TARGET_OS_IPHONE
+ (UIImage *) windArrowWithSize:(float) size;
+ (UIImage *) windArrowWithText:(NSString *) text degrees:(float)degrees;
+ (UIImage *) windArrowWithSize:(float) size degrees:(float) degrees fillColor:(UIColor *) fillColor strokeColor:(UIColor *) strokeColor text:(NSString *) text;
+ (UIImage *) waveArrowWithText:(NSString *) text degrees:(float)degrees;
#endif

@end
