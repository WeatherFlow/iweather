//
//  WeatherFlowMapView.h
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 05/12/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class WeatherFlowMapView, Spot, SpotSet, CLLocation;

@protocol WeatherFlowMapViewDelegate

- (void) weatherFlowMapView:(WeatherFlowMapView *)weatherFlowMapView didSelectSpot:(Spot *) spot;

@end

@interface WeatherFlowMapView : UIView <MKMapViewDelegate> {
    NSNumber *showCurrentLocation__;
    NSNumber *followCurrentLocation__;
    CLLocation *centerLocation__;
    MKMapView *mapView__;
    NSNumber *zoomLevel__;
    NSNumber *reloadData__;
    SpotSet *visibleSpotSet__;
    NSOperationQueue *queue__;
    NSDate *lastRegionChange;
}

@property (readonly) MKMapView *mapView;
@property BOOL showUserLocation;
@property CLLocation *centerLocation;
@property NSInteger zoomLevel;
@property (readonly) SpotSet *visibleSpotSet;
@property (weak) id<WeatherFlowMapViewDelegate> delegate;


@end
