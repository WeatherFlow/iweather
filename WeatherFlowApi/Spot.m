//
//  Spot.m
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 30/11/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import "Spot.h"
#import "Status.h"
#import "NSNull+WeatherFlowApiAdditions.h"
#import "WeatherFlowApi.h"

@implementation Spot

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        spot_id__ = [[dictionary objectForKey:@"spot_id"] integerValue];
        name__ = [dictionary objectForKey:@"name"];
        type__ = [[dictionary objectForKey:@"type"] integerValue];
        distance__ = [[dictionary objectForKey:@"distance"] doubleValue];
        lat__ = [[dictionary objectForKey:@"lat"] doubleValue];
        lon__ = [[dictionary objectForKey:@"lon"] doubleValue];
        provider__ = [[dictionary objectForKey:@"provider"] integerValue];
        region_id__ = [[dictionary objectForKey:@"region_id"] integerValue];
        is_favorite__ = [[dictionary objectForKey:@"is_favorite"] boolValue];
        wind_alert_exists__ = [[dictionary objectForKey:@"wind_alert_exists"] boolValue];
        wind_alert_active__ = [[dictionary objectForKey:@"wind_alert_active"] boolValue];
        upgrade_available__ = [[dictionary objectForKey:@"upgrade_available"] boolValue];
        timestamp__ = [dictionary objectForKey:@"timestamp"];
        avg__ = [[dictionary objectForKey:@"avg"] doubleValue];
        lull__ = [[dictionary objectForKey:@"lull"] doubleValue];
        gust__ = [[dictionary objectForKey:@"gust"] doubleValue];
        dir__ = [[dictionary objectForKey:@"dir"] integerValue];
        dir_text__ = [dictionary objectForKey:@"dir_text"];
        atemp__ = [[dictionary objectForKey:@"atemp"] doubleValue];
        wtemp__ = [[dictionary objectForKey:@"wtemp"] doubleValue];
        status__ = [[Status alloc] initWithDictionary:dictionary];
        spot_message__ = [dictionary objectForKey:@"spot_message"];
        source_message__ = [dictionary objectForKey:@"source_message"];
        rank__ = [[dictionary objectForKey:@"rank"] doubleValue];
        fav_sort_order__ = [[dictionary objectForKey:@"fav_sort_order"] integerValue];
        wave_height__ = [[dictionary objectForKey:@"wave_height"] doubleValue];
        wave_period__ = [[dictionary objectForKey:@"wave_period"] doubleValue];
        current_time_local__ = [dictionary objectForKey:@"current_time_local"];
        pres__ = [[dictionary objectForKey:@"pres"] doubleValue];
        timezone__ = [dictionary objectForKey:@"timezone"];
        favorite_lists__ = [dictionary objectForKey:@"favorite_lists"];
        fav_spot_id__ = [[dictionary objectForKey:@"fav_spot_id"] integerValue];
        wind_desc__ = [dictionary objectForKey:@"wind_desc"];
    }
    return self;
}

- (NSString *)description {
    NSString *description = [NSString stringWithFormat:@"%i %@ %0.4f %0.4f", self.spot_id, self.name, self.lat, self.lon];
    return [NSString stringWithFormat:@"<%@: %p, %@>",
            NSStringFromClass([self class]), self, description];
}
/*
public void setWindDescriptionText(String unitsWind){
    
    String windDescription = "";
    String dirTextStr = "";
    String unitsWindStr = "";
    
    // only obs are not null
    //		if(this.type != null && this.type == 1){
    //		if(this.type != null && this.type == 1 || this.type == 101){
    if(this.type != null){   // use this for virtual obs  also remove else below
        if(this.dir_text == null){
            dirTextStr = "";
        }
        else{
            dirTextStr = this.dir_text;
        }
        
        if(unitsWind == null){
            unitsWindStr = "";
        }
        else if(unitsWind.equals("mps")){
            unitsWindStr = "m/s";
        }
        else{
            unitsWindStr = unitsWind;
        }
        
        
        if (this.status_id != null && this.status_id == 4){
            windDescription = "Station is down";
        }
        else if(this.avg == null && this.lull == null && this.gust == null && this.dir == null && this.status_id != 1){
            windDescription = "Station is down";
        }
        else if(this.avg == null && this.lull == null && this.gust == null && this.dir == null && this.status_id == 1){
            windDescription = "No wind data";
        }
        else if(this.avg == null && this.lull == null && this.gust == null && this.dir != null && !this.upgrade_available){
            windDescription = "- "+unitsWindStr + " "+dirTextStr;
        }
        else if(this.avg == null && this.lull == null && this.gust != null && !this.upgrade_available){
            //				windDescription = "- "+unitsWindStr + " (g"+Converter.formatAsInteger.format(this.gust)+") " + dirTextStr;
            windDescription = "- (g"+Math.round(this.gust)+") " +unitsWindStr + dirTextStr;
        }
        //			else if(this.avg != null && this.avg == 0 && this.lull != null && this.lull == 0 && this.gust != null && this.gust == 0 && !this.upgrade_available){
        //windDescription = "CALM"; // deprecated
        //				windDescription = avg+"";
        //			}
        else if(this.upgrade_available){
            if(this.dir_text == null){
                windDescription = "";
            }else{
                windDescription = "" + this.dir_text;
            }
        }else if(this.avg != null && this.avg >= 0 && this.lull != null && this.lull > 0 && this.gust != null && this.gust > 0){
            windDescription = Math.round(this.avg)+ " (" + Math.round(this.lull) + "-" + Math.round(this.gust) + ") " + unitsWindStr + " " + dirTextStr;
        }else if (this.avg != null && this.avg >= 0 && this.gust != null && this.gust > 0){
            windDescription = Math.round(this.avg)+" (g" + Math.round(this.gust) + ") "  +unitsWindStr+" " + dirTextStr;
        }else if(this.avg != null && this.avg >= 0){
            windDescription = Math.round(this.avg)+" "+unitsWindStr+" " + dirTextStr;
        }else{
            //windDescription = GeneralHelper.WindspeedDirectionCondom(_data.avg);
            windDescription = "";
        }
        
        //set windDescription + " " +  _format.format(_data.timeStamp);
        this.wind_desc = windDescription;
        
    }
    else{
        //set windDescription + " " +  _format.format(_data.timeStamp);
        this.wind_desc = null;
    }
    
    
}
 */

//===========================================================
//  spot_id
//===========================================================
- (NSInteger)spot_id
{
    return spot_id__;
}
//===========================================================
//  name
//===========================================================
- (NSString *)name
{
    return name__;
}
//===========================================================
//  type
//===========================================================
- (NSInteger)type
{
    return type__;
}
//===========================================================
//  distance
//===========================================================
- (double)distance
{
    return distance__;
}
//===========================================================
//  lat
//===========================================================
- (double)lat
{
    return lat__;
}
//===========================================================
//  lon
//===========================================================
- (double)lon
{
    return lon__;
}
//===========================================================
//  provider
//===========================================================
- (NSInteger)provider
{
    return provider__;
}
//===========================================================
//  region_id
//===========================================================
- (NSInteger)region_id
{
    return region_id__;
}
//===========================================================
//  is_favorite
//===========================================================
- (BOOL)is_favorite
{
    return is_favorite__;
}
//===========================================================
//  wind_alert_exists
//===========================================================
- (BOOL)wind_alert_exists
{
    return wind_alert_exists__;
}
//===========================================================
//  wind_alert_active
//===========================================================
- (BOOL)wind_alert_active
{
    return wind_alert_active__;
}
//===========================================================
//  upgrade_available
//===========================================================
- (BOOL)upgrade_available
{
    return upgrade_available__;
}
//===========================================================
//  timestamp
//===========================================================
- (NSString *)timestamp
{
    return timestamp__;
}
//===========================================================
//  avg
//===========================================================
- (double)avg
{
    return avg__;
}
//===========================================================
//  lull
//===========================================================
- (double)lull
{
    return lull__;
}
//===========================================================
//  gust
//===========================================================
- (double)gust
{
    return gust__;
}
//===========================================================
//  dir
//===========================================================
- (NSInteger)dir
{
    return dir__;
}
//===========================================================
//  dir_text
//===========================================================
- (NSString *)dir_text
{
    return dir_text__;
}
//===========================================================
//  atemp
//===========================================================
- (double)atemp
{
    return atemp__;
}
//===========================================================
//  wtemp
//===========================================================
- (double)wtemp
{
    return wtemp__;
}
//===========================================================
//  status
//===========================================================
- (Status *)status
{
    return status__;
}
//===========================================================
//  spot_message
//===========================================================
- (NSString *)spot_message
{
    return spot_message__;
}
//===========================================================
//  source_message
//===========================================================
- (NSString *)source_message
{
    return source_message__;
}
//===========================================================
//  rank
//===========================================================
- (double)rank
{
    return rank__;
}
//===========================================================
//  fav_sort_order
//===========================================================
- (NSInteger)fav_sort_order
{
    return fav_sort_order__;
}
//===========================================================
//  wave_height
//===========================================================
- (double)wave_height
{
    return wave_height__;
}
//===========================================================
//  wave_period
//===========================================================
- (double)wave_period
{
    return wave_period__;
}
//===========================================================
//  current_time_local
//===========================================================
- (NSString *)current_time_local
{
    return current_time_local__;
}
//===========================================================
//  pres
//===========================================================
- (double)pres
{
    return pres__;
}
//===========================================================
//  timezone
//===========================================================
- (NSString *)timezone
{
    return timezone__;
}
//===========================================================
//  favorite_lists
//===========================================================
- (NSString *)favorite_lists
{
    return favorite_lists__;
}
//===========================================================
//  fav_spot_id
//===========================================================
- (NSInteger)fav_spot_id
{
    return fav_spot_id__;
}
//===========================================================
//  wind_desc
//===========================================================
- (NSString *)wind_desc
{
    return wind_desc__;
}


#pragma mark - MKAnnotation
- (CLLocationCoordinate2D)coordinate {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.lat, self.lon);
    return coordinate;
}

- (NSString *)title {
    return self.name;
}

- (NSString *)subtitle {
    return self.wind_desc;
}

#pragma mark - Annotation View
- (MKAnnotationView *) annotationView {
    MKAnnotationView *view = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"SpotAnnotation"];
    UIImage *windImage;
    if (self.avg == kInvalidDouble) {
        windImage = [UIImage imageNamed:@"mapnowindinfo.png"];
    } else if (self.avg == 0.0) {
        windImage = [UIImage imageNamed:@"mapnowind.png"];
    } else {
        windImage = [WeatherFlowApi windArrowWithText:[NSString stringWithFormat:@"%0.0f", self.avg] degrees:(CGFloat)self.dir];
    }
    view.image = windImage;
    view.canShowCallout = TRUE;
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    view.rightCalloutAccessoryView = infoButton;
    return view;
}

@end
