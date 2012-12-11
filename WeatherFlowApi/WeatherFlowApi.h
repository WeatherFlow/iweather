//
//  WeatherFlowApi.h
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 29/11/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Session.h"
#import "SpotSet.h"
#import "Spot.h"
#import "Status.h"
#import "ModelData.h"
#import "ModelDataSet.h"
#import "WeatherFlowMapView.h"
#import "WeatherFlowMapViewController.h"

@class CLLocation;

#define kInvalidInteger -9999
#define kInvalidDouble -9999.9

typedef enum {
    UnitDistanceKm,
    UnitDistanceMi,
    numUnitDistance
} UnitDistance;

typedef enum {
    UnitWindMph,
    UnitWindKts,
    UnitWindKph,
    UnitWindMps,
    numUnitWind
} UnitWind;

typedef enum {
    UnitTempC,
    UnitTempF,
    numUnitTemp
} UnitTemp;

@interface WeatherFlowApi : NSObject

+ (NSString *) apiKey;
+ (void) setApiKey:(NSString *) key;

+ (NSInteger) distance;
+ (void) setDistance:(NSInteger) distance;

+ (UnitDistance) unitDistance;
+ (void) setUnitDistance:(UnitDistance) unitDistance;

+ (UnitTemp) unitTemp;
+ (void) setUnitTemp:(UnitTemp) unitTemp;

+ (UnitWind) unitWind;
+ (void) setUnitWind:(UnitWind) unitWind;

+ (BOOL) includeWindSpeedOnArrows;
+ (void) setIncludeWindSpeedOnArrows:(BOOL) include;

+ (Session *) session;

+ (NSString *) stringForUnitDistance:(UnitDistance) unit;
+ (NSString *) stringForUnitWind:(UnitWind) unit;
+ (NSString *) stringForUnitTemp:(UnitTemp) unit;


+ (Session *) getToken;
+ (SpotSet *) getSpotSetBySearch:(NSString *) search;
+ (SpotSet *) getSpotSetByLocation:(CLLocation *) location;
+ (SpotSet *) getSpotSetByZoomLevel:(NSInteger) zoomLevel lat_min:(CGFloat) latMin lon_min:(CGFloat) lonMin lat_max:(CGFloat) latMax lon_max:(CGFloat) lonMax;
+ (Spot *) getClosestSpotByLocation:(CLLocation *) location;

+ (ModelDataSet *) getModelDataBySpot:(Spot *) spot;

#pragma mark - Helper
+ (UIImage *)windArrowWithText:(NSString *) text degrees:(CGFloat)degrees;

@end
