//
//  WeatherFlowApi.m
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 29/11/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import "WeatherFlowApi.h"
#import <CoreLocation/CoreLocation.h>

static NSString *api = @"http://api.weatherflow.com";
static NSString *wfApiKey__;    // API Training API Key
static NSString *format = @"json";
static NSString *DistanceKey = @"WeatherFlowApiDistanceKey";
static NSString *UnitDistanceKey = @"WeatherFlowApiUnitDistanceKey";
static NSString *UnitWindKey = @"WeatherFlowApiUnitWindKey";
static NSString *UnitTempKey = @"WeatherFlowApiUnitTempKey";
static NSString *IncludeWindSppedOnArrowsKey = @"IncludeWindSppedOnArrowsKey";

static NSString *NameKey = @"Name";
static NSString *ValueKey = @"Value";

static Session *session__;
static NSString *getTokenURL = @"/wxengine/rest/session/getToken";
static NSString *getSpotSetBySearchURL = @"/wxengine/rest/spot/getSpotSetBySearch";
static NSString *getSpotSetByLatLonURL = @"/wxengine/rest/spot/getSpotSetByLatLon";
static NSString *getModelDataBySpotURL = @"/wxengine/rest/model/getModelDataBySpot";
static NSString *getSpotSetByZoomLevelURL = @"/wxengine/rest/spot/getSpotSetByZoomLevel";

@implementation WeatherFlowApi


#pragma mark - Setter and Getter
+ (NSString *) apiKey {
    return wfApiKey__;
}

+ (void) setApiKey:(NSString *) key {
    wfApiKey__ = key;
}

+ (NSInteger) distance {
    NSNumber *value = [[NSUserDefaults standardUserDefaults] objectForKey:DistanceKey];
    if (!value) {
        return 15.0;
    }
    return value.integerValue;
}
+ (void) setDistance:(NSInteger) distance {
    [[NSUserDefaults standardUserDefaults] setInteger:distance forKey:DistanceKey];
}

+ (UnitDistance) unitDistance {
    NSNumber *value = [[NSUserDefaults standardUserDefaults] objectForKey:UnitDistanceKey];
    if (!value) {
        return UnitDistanceKm;
    }
    return value.integerValue;
}

+ (void) setUnitDistance:(UnitDistance) unitDistance {
    [[NSUserDefaults standardUserDefaults] setInteger:unitDistance forKey:UnitDistanceKey];
}

+ (UnitTemp) unitTemp  {
    NSNumber *value = [[NSUserDefaults standardUserDefaults] objectForKey:UnitTempKey];
    if (!value) {
        return UnitTempC;
    }
    return value.integerValue;
}
+ (void) setUnitTemp:(UnitTemp) unitTemp {
    [[NSUserDefaults standardUserDefaults] setInteger:unitTemp forKey:UnitTempKey];
}

+ (UnitWind) unitWind  {
    NSNumber *value = [[NSUserDefaults standardUserDefaults] objectForKey:UnitWindKey];
    if (!value) {
        return UnitWindKts;
    }
    return value.integerValue;
}

+ (void) setUnitWind:(UnitWind) unitWind {
    [[NSUserDefaults standardUserDefaults] setInteger:unitWind forKey:UnitWindKey];
}

+ (BOOL)includeWindSpeedOnArrows {
    NSNumber *value = [[NSUserDefaults standardUserDefaults] objectForKey:IncludeWindSppedOnArrowsKey];
    if (!value) {
        return TRUE;
    }
    return value.boolValue;
}

+ (void)setIncludeWindSpeedOnArrows:(BOOL)include {
    [[NSUserDefaults standardUserDefaults] setBool:include forKey:IncludeWindSppedOnArrowsKey];
}

+ (Session *) session {
    if (!session__) {
        [self getToken];
    }
    return session__;
}

+ (NSString *) stringForUnitDistance:(UnitDistance) unit {
    switch (unit) {
        case UnitDistanceKm:
            return @"Klm";
            break;
        case UnitDistanceMi:
            return @"Miles";
            break;
        default:
            break;
      }
    return nil;
}

+ (NSString *) stringForUnitWind:(UnitWind) unit {
    switch (unit) {
        case UnitWindKph:
            return @"Kph";
            break;
        case UnitWindKts:
            return @"Kts";
            break;
        case UnitWindMph:
            return @"Mph";
            break;
        case UnitWindMps:
            return @"Mps";
            break;
            
        default:
            break;
    }
    return nil;
}

+ (NSString *) stringForUnitTemp:(UnitTemp) unit {
    switch (unit) {
        case UnitTempF:
            return @"F'\xC2\xB0'";
            break;
        case UnitTempC:
            return @"C'\xC2\xB0'";
            break;
        default:
            break;
    }
    return nil;
}

+ (NSString *) paramForUnitDistance:(UnitDistance) unit {
    switch (unit) {
        case UnitDistanceKm:
            return @"km";
            break;
        case UnitDistanceMi:
            return @"mi";
            break;
        default:
            break;
    }
    return nil;
}

+ (NSString *) paramForUnitWind:(UnitWind) unit {
    switch (unit) {
        case UnitWindKph:
            return @"kph";
            break;
        case UnitWindKts:
            return @"kts";
            break;
        case UnitWindMph:
            return @"mph";
            break;
        case UnitWindMps:
            return @"mps";
            break;
            
        default:
            break;
    }
    return nil;
}

+ (NSString *) paramForUnitTemp:(UnitTemp) unit {
    switch (unit) {
        case UnitTempF:
            return @"f";
            break;
        case UnitTempC:
            return @"c";
            break;
        default:
            break;
    }
    return nil;
}

+ (NSDictionary *) dictionaryWithParameter:(NSString *) name value:(NSString *) value {
    return [NSDictionary dictionaryWithObjectsAndKeys:name, NameKey, value, ValueKey, nil];
}

+ (NSDictionary *) unitWindDictionary {
    return [self dictionaryWithParameter:@"units_wind" value:[self paramForUnitWind:self.unitWind]];
}

+ (NSDictionary *) unitTempDictionary {
    return [self dictionaryWithParameter:@"units_temp" value:[self paramForUnitTemp:self.unitTemp]];
}

+ (NSDictionary *) unitDistanceDictionary {
    return [self dictionaryWithParameter:@"units_distance" value:[self paramForUnitDistance:self.unitDistance]];
}

+ (NSDictionary *) formatDictionary {
    return [self dictionaryWithParameter:@"format" value:format];
}

+ (NSDictionary *) searchDictionaryWithValue:(NSString *) value {
    return [self dictionaryWithParameter:@"search" value:value];
}

+ (NSDictionary *) spotIDDictionary:(NSInteger) spot_id {
    return [self dictionaryWithParameter:@"spot_id" value:[NSString stringWithFormat:@"%i", spot_id]];
}

+ (NSArray *) locationArray:(CLLocation *) location {
    NSString *lat = [NSString stringWithFormat:@"%0.5f", location.coordinate.latitude];
    NSString *lon = [NSString stringWithFormat:@"%0.5f", location.coordinate.longitude];
    return [NSArray arrayWithObjects:
            [self dictionaryWithParameter:@"lat" value:lat],
            [self dictionaryWithParameter:@"lon" value:lon],
            nil];
}

+ (NSString *) urlForService:(NSString *) service andParameters:(NSArray *) parameters {
    NSMutableString *string = [[NSMutableString alloc] init];
    NSString *urlPrefix = [NSString stringWithFormat:@"%@%@?wf_apikey=%@&wf_token=%@", api, service, self.apiKey, self.session.token];
    [string appendString:urlPrefix];
    for (NSDictionary *dictionary in parameters) {
        [string appendFormat:@"&%@=%@", [dictionary objectForKey:NameKey], [dictionary objectForKey:ValueKey]];
    }
    return string;
}

+ (NSArray *) unitsArray {
    NSArray *array = [NSArray arrayWithObjects:[self unitWindDictionary], [self unitDistanceDictionary], [self unitTempDictionary], nil];
    return array;
}

+ (NSArray *) searchArray {
    return [NSArray arrayWithObjects:
            [self dictionaryWithParameter:@"spot_types" value:@"1"],
            [self dictionaryWithParameter:@"search_dist" value:[NSString stringWithFormat:@"%0.1d", self.distance]]
            , nil];
}

#pragma mark - Weather Engine API
+ (Session *)getToken {    // Print Sample Request
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@", api, getTokenURL, @"?wf_apikey=", self.apiKey, @"&format=", format];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    NSURLResponse* response;
    NSError* error = nil;
    NSData* result = [NSURLConnection sendSynchronousRequest:request  returningResponse:&response error:&error];
    if (!result) {
        return nil;
    }
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:result options:0 error:&error];
    
    session__ = [[Session alloc] initWithDictionary:responseDictionary];
    return session__;
}

+ (SpotSet *) getSpotSetBySearch:(NSString *) search {
    NSMutableArray *parameters = [[NSMutableArray alloc] init];
    [parameters addObject:[self searchDictionaryWithValue:search]];
    [parameters addObjectsFromArray:self.unitsArray];
    [parameters addObjectsFromArray:self.searchArray];
    [parameters addObject:self.formatDictionary];
    
    NSString *urlString = [self urlForService:getSpotSetBySearchURL andParameters:parameters];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    NSURLResponse* response;
    NSError* error = nil;
    NSData* result = [NSURLConnection sendSynchronousRequest:request  returningResponse:&response error:&error];
    if (!result) {
        return nil;
    }
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:result options:0 error:&error];
    
    SpotSet *spotSet = [[SpotSet alloc] initWithDictionary:responseDictionary];
    
    return spotSet;
}

+ (SpotSet *) getSpotSetByLocation:(CLLocation *) location {
    NSMutableArray *parameters = [[NSMutableArray alloc] init];
    [parameters addObjectsFromArray:[self locationArray:location]];
    [parameters addObjectsFromArray:self.unitsArray];
    [parameters addObjectsFromArray:self.searchArray];
    [parameters addObject:self.formatDictionary];
    
    NSString *urlString = [self urlForService:getSpotSetByLatLonURL andParameters:parameters];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    NSURLResponse* response;
    NSError* error = nil;
    NSData* result = [NSURLConnection sendSynchronousRequest:request  returningResponse:&response error:&error];
    if (!result) {
        return nil;
    }
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:result options:0 error:&error];
    
    SpotSet *spotSet = [[SpotSet alloc] initWithDictionary:responseDictionary];
    
    return spotSet;
}

+ (SpotSet *) getSpotSetByZoomLevel:(NSInteger) zoomLevel lat_min:(CGFloat) latMin lon_min:(CGFloat) lonMin lat_max:(CGFloat) latMax lon_max:(CGFloat) lonMax {
    NSMutableArray *parameters = [[NSMutableArray alloc] init];
    [parameters addObject:[self dictionaryWithParameter:@"lat_min" value:[NSString stringWithFormat:@"%0.5f", latMin]]];
    [parameters addObject:[self dictionaryWithParameter:@"lon_min" value:[NSString stringWithFormat:@"%0.5f", lonMin]]];
    [parameters addObject:[self dictionaryWithParameter:@"lat_max" value:[NSString stringWithFormat:@"%0.5f", latMax]]];
    [parameters addObject:[self dictionaryWithParameter:@"lon_max" value:[NSString stringWithFormat:@"%0.5f", lonMax]]];
    [parameters addObject:[self dictionaryWithParameter:@"zoom" value:[NSString stringWithFormat:@"%i", zoomLevel]]];
    [parameters addObjectsFromArray:self.unitsArray];
    [parameters addObject:self.formatDictionary];
    
    NSString *urlString = [self urlForService:getSpotSetByZoomLevelURL andParameters:parameters];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    NSURLResponse* response;
    NSError* error = nil;
    NSData* result = [NSURLConnection sendSynchronousRequest:request  returningResponse:&response error:&error];
    if (!result) {
        return nil;
    }
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:result options:0 error:&error];
    
    SpotSet *spotSet = [[SpotSet alloc] initWithDictionary:responseDictionary];
    
    return spotSet;
}

+ (Spot *) getClosestSpotByLocation:(CLLocation *) location {
    SpotSet *set = [self getSpotSetByLocation:location];
    if (set.status.statusCode != 0) {
        return nil;
    }
    for (Spot *spot in set.spots) {
        if (spot.status.statusCode == 0 && spot.avg != kInvalidDouble) {
            return spot;
        }
    }
    return nil;
}

+ (ModelDataSet *) getModelDataBySpot:(Spot *)spot {
    NSMutableArray *parameters = [[NSMutableArray alloc] init];
    [parameters addObject:[self spotIDDictionary:spot.spot_id]];
    [parameters addObjectsFromArray:self.unitsArray];
    [parameters addObject:self.formatDictionary];
    
    NSString *urlString = [self urlForService:getModelDataBySpotURL andParameters:parameters];

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    NSURLResponse* response;
    NSError* error = nil;
    NSData* result = [NSURLConnection sendSynchronousRequest:request  returningResponse:&response error:&error];
    if (!result) {
        return nil;
    }
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:result options:0 error:&error];
    ModelDataSet *modelDataSet = [[ModelDataSet alloc] initWithDictionary:responseDictionary];
    return modelDataSet;
}

#pragma mark - Helper
+ (UIImage *)windArrowWithText:(NSString *) text degrees:(CGFloat)degrees  {
    UIImage *image = [UIImage imageNamed:@"mapwindarrow.png"];
    CGFloat rads = (degrees / 360) * M_PI;
    float newSide = MAX([image size].width, [image size].height);
    // Start Context
    CGSize size = CGSizeMake(newSide, newSide);
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, newSide/2, newSide/2);
    CGContextRotateCTM(ctx, rads);
    CGContextDrawImage(UIGraphicsGetCurrentContext(),CGRectMake(-[image size].width/2,-[image size].height/2,size.width, size.height),image.CGImage);
     // Create image
    UIImage *i = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // Add Text
    return [self addText:text toImage:i];
}

+ (UIImage *) addText:(NSString *) text toImage:(UIImage *) image {
    UIFont *font = [UIFont boldSystemFontOfSize:14.0];
    CGSize constrainSize = CGSizeMake(30, image.size.height);
    CGSize stringSize = [text sizeWithFont:font
                         constrainedToSize:constrainSize
                             lineBreakMode:NSLineBreakByCharWrapping];
    CGSize size =  CGSizeMake(image.size.width + stringSize.width, MAX(image.size.height, stringSize.height));
    UIGraphicsBeginImageContext(size);
    // Draw image
    CGContextDrawImage(UIGraphicsGetCurrentContext(),CGRectMake(0, 0, image.size.width, image.size.height),image.CGImage);
    // Draw Text
    CGContextSetRGBFillColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
    CGRect renderingRect = CGRectMake(image.size.width, 0, stringSize.width, stringSize.height);
    [text drawInRect:renderingRect
            withFont:font
       lineBreakMode:NSLineBreakByCharWrapping
           alignment:NSTextAlignmentLeft];
    UIImage *i = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return i;    
}

@end
