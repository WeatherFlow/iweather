//
//  WeatherFlowApi.m
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 29/11/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import "WeatherFlowApi.h"
#import <CoreLocation/CoreLocation.h>

static NSString *wfApiKey__;    // API Training API Key

#define api @"http://api.weatherflow.com"
#define format @"json"
#define DistanceKey @"WeatherFlowApiDistanceKey"
#define UnitDistanceKey @"WeatherFlowApiUnitDistanceKey"
#define UnitWindKey @"WeatherFlowApiUnitWindKey"
#define UnitTempKey @"WeatherFlowApiUnitTempKey"
#define IncludeWindSpeedOnArrowsKey @"IncludeWindSpeedOnArrowsKey"
#define IncludeVirtualWeatherStationsKey @"IncludeVirtualWeatherStationsKey"

#define NameKey @"Name"
#define ValueKey @"Value"

static Session *session__;
#define getTokenURL @"/wxengine/rest/session/getToken"
#define getSpotSetBySearchURL @"/wxengine/rest/spot/getSpotSetBySearch"
#define getSpotSetByLatLonURL @"/wxengine/rest/spot/getSpotSetByLatLon"
#define getModelDataBySpotURL @"/wxengine/rest/model/getModelDataBySpot"
#define getSpotSetByZoomLevelURL @"/wxengine/rest/spot/getSpotSetByZoomLevel"

static NSMutableArray *arrowCache__;
#define kArrowFillColor @"kArrowFillColor"
#define kArrowStrokeColor @"kArrowStrokeColor"
#define kArrowImage @"kArrowImage"
#define kArrowSize @"kArrowSize"


@implementation WeatherFlowApi


#pragma mark - Setter and Getter
+ (NSString *) apiKey {
    return wfApiKey__;
}

+ (void) setApiKey:(NSString *) key {
    wfApiKey__ = key;
}

+ (WFUnitDistance) unitDistance {
    NSNumber *value = [[NSUserDefaults standardUserDefaults] objectForKey:UnitDistanceKey];
    if (!value) {
        return WFUnitDistanceKm;
    }
    return value.integerValue;
}

+ (void) setUnitDistance:(WFUnitDistance) unitDistance {
    [[NSUserDefaults standardUserDefaults] setInteger:unitDistance forKey:UnitDistanceKey];
}

+ (WFUnitTemp) unitTemp  {
    NSNumber *value = [[NSUserDefaults standardUserDefaults] objectForKey:UnitTempKey];
    if (!value) {
        return WFUnitTempC;
    }
    return value.integerValue;
}
+ (void) setUnitTemp:(WFUnitTemp) unitTemp {
    [[NSUserDefaults standardUserDefaults] setInteger:unitTemp forKey:UnitTempKey];
}

+ (WFUnitWind) unitWind  {
    NSNumber *value = [[NSUserDefaults standardUserDefaults] objectForKey:UnitWindKey];
    if (!value) {
        return WFUnitWindKts;
    }
    return value.integerValue;
}

+ (void) setUnitWind:(WFUnitWind) unitWind {
    [[NSUserDefaults standardUserDefaults] setInteger:unitWind forKey:UnitWindKey];
}

+ (BOOL)includeWindSpeedOnArrows {
    NSNumber *value = [[NSUserDefaults standardUserDefaults] objectForKey:IncludeWindSpeedOnArrowsKey];
    if (!value) {
        return TRUE;
    }
    return value.boolValue;
}

+ (void)setIncludeWindSpeedOnArrows:(BOOL)include {
    [[NSUserDefaults standardUserDefaults] setBool:include forKey:IncludeWindSpeedOnArrowsKey];
}

+ (BOOL)includeVirtualWeatherStations {
    NSNumber *value = [[NSUserDefaults standardUserDefaults] objectForKey:IncludeVirtualWeatherStationsKey];
    if (!value) {
        return FALSE;
    }
    return value.boolValue;
}

+ (void)setIncludeVirtualWeatherStations:(BOOL)include {
    [[NSUserDefaults standardUserDefaults] setBool:include forKey:IncludeVirtualWeatherStationsKey];
}

+ (Session *) session {
    if (!session__) {
        [self getToken];
    }
    return session__;
}

+ (NSString *) stringForUnitDistance:(WFUnitDistance) unit {
    switch (unit) {
        case WFUnitDistanceKm:
            return @"Klm";
            break;
        case WFUnitDistanceMi:
            return @"Miles";
            break;
        default:
            break;
      }
    return nil;
}

+ (NSString *) stringForUnitWind:(WFUnitWind) unit {
    switch (unit) {
        case WFUnitWindKph:
            return @"Kph";
            break;
        case WFUnitWindKts:
            return @"Kts";
            break;
        case WFUnitWindMph:
            return @"Mph";
            break;
        case WFUnitWindMps:
            return @"Mps";
            break;
            
        default:
            break;
    }
    return nil;
}

+ (NSString *) stringForUnitTemp:(WFUnitTemp) unit {
    switch (unit) {
        case WFUnitTempF:
            return @"F\xC2\xB0";
            break;
        case WFUnitTempC:
            return @"C\xC2\xB0";
            break;
        default:
            break;
    }
    return nil;
}

+ (NSString *) paramForUnitDistance:(WFUnitDistance) unit {
    switch (unit) {
        case WFUnitDistanceKm:
            return @"km";
            break;
        case WFUnitDistanceMi:
            return @"mi";
            break;
        default:
            break;
    }
    return nil;
}

+ (NSString *) paramForUnitWind:(WFUnitWind) unit {
    switch (unit) {
        case WFUnitWindKph:
            return @"kph";
            break;
        case WFUnitWindKts:
            return @"kts";
            break;
        case WFUnitWindMph:
            return @"mph";
            break;
        case WFUnitWindMps:
            return @"mps";
            break;
            
        default:
            break;
    }
    return nil;
}

+ (NSString *) paramForUnitTemp:(WFUnitTemp) unit {
    switch (unit) {
        case WFUnitTempF:
            return @"f";
            break;
        case WFUnitTempC:
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

+ (NSDictionary *) distanceDictionaryWithValue:(NSInteger) value {
    return [self dictionaryWithParameter:@"search_dist" value:[NSString stringWithFormat:@"%i", value]];
}

+ (NSArray *) locationArray:(CLLocationCoordinate2D) location {
    NSString *lat = [NSString stringWithFormat:@"%0.5f", location.latitude];
    NSString *lon = [NSString stringWithFormat:@"%0.5f", location.longitude];
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
    if (self.includeVirtualWeatherStations) {
        return [NSArray arrayWithObjects:
                [self dictionaryWithParameter:@"spot_types" value:@"1,100,101"],
                nil];        
    } else {
        return [NSArray arrayWithObjects:
                [self dictionaryWithParameter:@"spot_types" value:@"1"],
                nil];
    }
}

+ (NSMutableArray *) arrowCache {
    if (!arrowCache__) {
        arrowCache__ = [[NSMutableArray alloc] init];
    }
    return arrowCache__;
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

+ (SpotSet *) getSpotSetBySearch:(NSString *) search distance:(NSInteger)distance error:(NSError **) error {
    NSMutableArray *parameters = [[NSMutableArray alloc] init];
    [parameters addObject:[self searchDictionaryWithValue:search]];
    [parameters addObjectsFromArray:self.unitsArray];
    [parameters addObjectsFromArray:self.searchArray];
    [parameters addObject:self.formatDictionary];
    [parameters addObject:[self distanceDictionaryWithValue:distance]];
    NSString *urlString = [self urlForService:getSpotSetBySearchURL andParameters:parameters];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    NSURLResponse* response;
    NSData* result = [NSURLConnection sendSynchronousRequest:request  returningResponse:&response error:error];
    if (!result) {
        return nil;
    }
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:result options:0 error:error];
    
    SpotSet *spotSet = [[SpotSet alloc] initWithDictionary:responseDictionary];
    
    return spotSet;
}

+ (SpotSet *) getSpotSetByLocationCoordinate:(CLLocationCoordinate2D)location distance:(NSInteger)distance error:(NSError **) error {
    NSMutableArray *parameters = [[NSMutableArray alloc] init];
    [parameters addObjectsFromArray:[self locationArray:location]];
    [parameters addObjectsFromArray:self.unitsArray];
    [parameters addObjectsFromArray:self.searchArray];
    [parameters addObject:[self distanceDictionaryWithValue:distance]];
    [parameters addObject:self.formatDictionary];
    
    NSString *urlString = [self urlForService:getSpotSetByLatLonURL andParameters:parameters];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    NSURLResponse* response;
    NSData* result = [NSURLConnection sendSynchronousRequest:request  returningResponse:&response error:error];
    if (!result) {
        return nil;
    }
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:result options:0 error:error];
    
    SpotSet *spotSet = [[SpotSet alloc] initWithDictionary:responseDictionary];
    
    return spotSet;
}


+ (SpotSet *) getSpotSetByLocation:(CLLocationCoordinate2D) location distance:(NSInteger)distance error:(NSError **) error {
    return [WeatherFlowApi getSpotSetByLocationCoordinate:location distance:distance error:error];
}

+ (SpotSet *) getSpotSetByZoomLevel:(NSInteger) zoomLevel lat_min:(float) latMin lon_min:(float) lonMin lat_max:(float) latMax lon_max:(float) lonMax error:(NSError **) error {
    NSMutableArray *parameters = [[NSMutableArray alloc] init];
    [parameters addObject:[self dictionaryWithParameter:@"lat_min" value:[NSString stringWithFormat:@"%0.5f", latMin]]];
    [parameters addObject:[self dictionaryWithParameter:@"lon_min" value:[NSString stringWithFormat:@"%0.5f", lonMin]]];
    [parameters addObject:[self dictionaryWithParameter:@"lat_max" value:[NSString stringWithFormat:@"%0.5f", latMax]]];
    [parameters addObject:[self dictionaryWithParameter:@"lon_max" value:[NSString stringWithFormat:@"%0.5f", lonMax]]];
    [parameters addObject:[self dictionaryWithParameter:@"zoom" value:[NSString stringWithFormat:@"%i", zoomLevel]]];
    [parameters addObjectsFromArray:self.unitsArray];
    [parameters addObjectsFromArray:self.searchArray];
    [parameters addObject:self.formatDictionary];
    
    NSString *urlString = [self urlForService:getSpotSetByZoomLevelURL andParameters:parameters];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    NSURLResponse* response;
    NSData* result = [NSURLConnection sendSynchronousRequest:request  returningResponse:&response error:error];
    if (!result) {
        return nil;
    }
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:result options:0 error:error];
    
    SpotSet *spotSet = [[SpotSet alloc] initWithDictionary:responseDictionary];
    
    return spotSet;
}

+ (Spot *) getClosestSpotByLocation:(CLLocationCoordinate2D) location distance:(float)distance error:(NSError **) error {
    SpotSet *set = [self getSpotSetByLocation:location distance:distance error:error];
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

+ (ModelDataSet *) getModelDataBySpot:(Spot *)spot  error:(NSError **) error{
    NSMutableArray *parameters = [[NSMutableArray alloc] init];
    [parameters addObject:[self spotIDDictionary:spot.spot_id]];
    [parameters addObjectsFromArray:self.unitsArray];
    [parameters addObject:self.formatDictionary];
    
    NSString *urlString = [self urlForService:getModelDataBySpotURL andParameters:parameters];

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    NSURLResponse* response;
    NSData* result = [NSURLConnection sendSynchronousRequest:request  returningResponse:&response error:error];
    if (!result) {
        return nil;
    }
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:result options:0 error:error];
    ModelDataSet *modelDataSet = [[ModelDataSet alloc] initWithDictionary:responseDictionary andSpot:spot];
    return modelDataSet;
}

+ (ModelDataSet *) getModelDataBySpotID:(NSInteger)spotID error:(NSError **) error {
    NSMutableArray *parameters = [[NSMutableArray alloc] init];
    [parameters addObject:[self spotIDDictionary:spotID]];
    [parameters addObjectsFromArray:self.unitsArray];
    [parameters addObject:self.formatDictionary];
    
    NSString *urlString = [self urlForService:getModelDataBySpotURL andParameters:parameters];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    NSURLResponse* response;
    NSData* result = [NSURLConnection sendSynchronousRequest:request  returningResponse:&response error:error];
    if (!result) {
        return nil;
    }
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:result options:0 error:error];
    ModelDataSet *modelDataSet = [[ModelDataSet alloc] initWithDictionary:responseDictionary];
    return modelDataSet;
}

#pragma mark - Helper
#if TARGET_OS_IPHONE
+ (UIImage *)windArrowWithSize:(float)size {
    UIImage *arrow = [self windArrowWithSize: size fillColor:[UIColor grayColor] strokeColor:[UIColor grayColor]];
    return arrow;
}

+ (UIImage *) windArrowWithSize:(float) size fillColor:(UIColor *) fillColor strokeColor:(UIColor *) strokeColor{
    //Check for ready image in cache
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@ AND %K == %@ AND %K == %f", kArrowFillColor, fillColor, kArrowStrokeColor, strokeColor, kArrowSize, size];
    NSArray *cache = [self.arrowCache filteredArrayUsingPredicate:predicate];
    if (cache.count != 0) {
        UIImage *image = [[cache objectAtIndex:0] objectForKey:kArrowImage];
        return [image copy];
    }
    NSLog(@"No cahce for size %f", size);
    // Get a bigger image for quality reasons
    float width = size;
    float height = size;
    // Prepare Points
    float arrowWidth = 0.5 * width;
    CGPoint buttonLeftPoint = CGPointMake((width - arrowWidth) / 2.0, height * 0.9);
    CGPoint buttonRightPoint = CGPointMake(buttonLeftPoint.x + arrowWidth, height * 0.9);
    CGPoint topArrowPoint = CGPointMake(width / 2.0, 0.0);
    CGPoint buttomMiddlePoint = CGPointMake(width / 2.0, 0.7 * height);
    
    // Start Context
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Prepare context parameters
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    CGPathMoveToPoint(pathRef, NULL, topArrowPoint.x, topArrowPoint.y);
    CGPathAddLineToPoint(pathRef, NULL, buttonLeftPoint.x, buttonLeftPoint.y);
    CGPathAddLineToPoint(pathRef, NULL, buttomMiddlePoint.x, buttomMiddlePoint.y);
    CGPathAddLineToPoint(pathRef, NULL, buttonRightPoint.x, buttonRightPoint.y);
    CGPathAddLineToPoint(pathRef, NULL, topArrowPoint.x, topArrowPoint.y);
    
    CGPathCloseSubpath(pathRef);
    
    CGContextAddPath(context, pathRef);
    CGContextFillPath(context);
    
    CGContextAddPath(context, pathRef);
    CGContextStrokePath(context);
    
    UIImage *i = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // Resize image.
    [self.arrowCache addObject:[NSDictionary dictionaryWithObjectsAndKeys:fillColor, kArrowFillColor, strokeColor, kArrowStrokeColor, [NSNumber numberWithFloat:size], kArrowSize, [i copy], kArrowImage, nil]];
    return i;//[self resizeImage:i to:CGSizeMake(size, size)];
}

+ (UIImage *) resizeImage:(UIImage *) image to:(CGSize) size {
    if (CGSizeEqualToSize(image.size, size)) {
        return image;
    }
    NSLog(@"Resize");
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, 0.0);
    // Set the quality level to use when rescaling
    //CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *) windArrowWithSize:(float) size degrees:(float) degrees fillColor:(UIColor *) fillColor strokeColor:(UIColor *) strokeColor text:(NSString *) text {
    UIImage *image = [self windArrowWithSize:size fillColor:fillColor strokeColor:strokeColor];
    UIImage *i = [self rotatedImage:image degrees:degrees];
    // Resize
    //i = [self resizeImage:i to:CGSizeMake(size, size)];
    // Add Text
    return [self addText:text toImage:i];
}
+ (UIImage *)windArrowWithText:(NSString *) text degrees:(float)degrees  {
    UIImage *image = [self windArrowWithSize:30.0];
    UIImage *i = [self rotatedImage:image degrees:degrees];
    // Add Text
    return [self addText:text toImage:i];
}

+ (UIImage *)waveArrowWithText:(NSString *) text degrees:(float)degrees  {
    UIImage *image = [self windArrowWithSize:30 fillColor:[UIColor blueColor] strokeColor:[UIColor blueColor]];
    // Create image
    UIImage *i = [self rotatedImage:image degrees:degrees];
    return [self addText:text toImage:i];
}

+ (UIImage *) addText:(NSString *) text toImage:(UIImage *) image {
    if (!text || text.length == 0) {
        return image;
    }
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

+ (UIImage *) rotatedImage:(UIImage *) image degrees:(float) degrees {
    // We add 180 to callibrate the arrow and then conver to radians.
    float rads = degrees * (M_PI / 180.0);
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
    return i;
}

#endif

@end
