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

@protocol WeatherFlowMapViewDelegate <NSObject>

@optional
- (void) weatherFlowMapView:(WeatherFlowMapView *)weatherFlowMapView didSelectSpot:(Spot *) spot;
- (void) weatherFlowMapView:(WeatherFlowMapView *)weatherFlowMapView spot:(Spot *) spot calloutAccessoryTapped:(UIControl *) control;
- (void) weatherFlowMapView:(WeatherFlowMapView *)weatherFlowMapView didDeselectSpot:(Spot *) spot;

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
    BOOL displayCallout__;
}

@property (readonly) MKMapView *mapView;
@property BOOL showUserLocation;
@property CLLocation *centerLocation;
@property (readonly) SpotSet *visibleSpotSet;
@property (weak) id<WeatherFlowMapViewDelegate> delegate;
@property NSArray *selectedSpots;
@property BOOL displayCallout;

@end
