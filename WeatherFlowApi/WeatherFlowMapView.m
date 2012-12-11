//
//  WeatherFlowMapView.m
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 05/12/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import "WeatherFlowMapView.h"
#import "MKMapView+ZoomLevel.h"
#import "WeatherFlowApi.h"

#define DefaultZoomLevel 10

@interface WeatherFlowMapView (Private)

@property BOOL reloadData;
@property NSOperationQueue *queue;

@end


@implementation WeatherFlowMapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.mapView];
        self.mapView.delegate = self;
        self.reloadData = TRUE;
    }
    return self;
}

#pragma mark - Setter and Getter
- (MKMapView *)mapView {
    if (!mapView__) {
        mapView__ = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        mapView__.mapType = MKMapTypeStandard;
        [mapView__ setCenterCoordinate:self.centerLocation.coordinate zoomLevel:self.zoomLevel animated:NO];
        mapView__.showsUserLocation = self.showUserLocation;
    }
    return mapView__;
}

- (BOOL)showUserLocation {
    if (!showCurrentLocation__) {
        return TRUE;
    }
    return [showCurrentLocation__ boolValue];
}

- (void)setShowUserLocation:(BOOL)showUserLocation {
    showCurrentLocation__ = [NSNumber numberWithBool:showUserLocation];
    self.mapView.showsUserLocation = showUserLocation;
}

- (CLLocation *)centerLocation {
    if (!centerLocation__) {
        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
        centerLocation__ = locationManager.location;
    }
    return centerLocation__;
}

- (void)setCenterLocation:(CLLocation *)centerLocation {
    centerLocation__ = centerLocation;
    [self.mapView setCenterCoordinate:centerLocation.coordinate zoomLevel:self.zoomLevel animated:YES];
}

- (NSInteger)zoomLevel {
    if (!zoomLevel__) {
        return DefaultZoomLevel;
    }
    return [zoomLevel__ integerValue];
}

- (void)setZoomLevel:(NSInteger)zoomLevel {
    zoomLevel__ = [NSNumber numberWithInteger:zoomLevel];
    [self.mapView setCenterCoordinate:self.mapView.centerCoordinate zoomLevel:zoomLevel animated:YES];
}

- (BOOL)reloadData {
    if (!reloadData__) {
        return FALSE;
    }
    return reloadData__.boolValue;
}

- (void)setReloadData:(BOOL)reloadData {
    reloadData__ = [NSNumber numberWithBool:reloadData];
    if (reloadData) {
        CLLocationCoordinate2D min = self.mapView.minCoordinate;
        CLLocationCoordinate2D max = self.mapView.maxCoordinate;
        [self.queue cancelAllOperations];
        NSBlockOperation *theOp = [NSBlockOperation blockOperationWithBlock:^{
            SpotSet *spotSet = [WeatherFlowApi getSpotSetByZoomLevel:30 lat_min:min.latitude lon_min:min.longitude lat_max:max.latitude lon_max:max.longitude];
            self.reloadData = FALSE;
            [self performSelectorOnMainThread:@selector(setVisibleSpotSet:) withObject:spotSet waitUntilDone:NO];
        }];
        [self.queue addOperation:theOp];
    }
}

- (SpotSet *)visibleSpotSet {
    if (!self.reloadData) {
        return nil;
    }
    return visibleSpotSet__;
}

- (void)setVisibleSpotSet:(SpotSet *)visibleSpotSet {
    if (visibleSpotSet__.spots.count !=0) {
        [self.mapView removeAnnotations:visibleSpotSet__.spots];
    }
    visibleSpotSet__ = visibleSpotSet;
    [self.mapView addAnnotations:visibleSpotSet.spots];
    NSLog(@"%@", visibleSpotSet);
}

- (NSOperationQueue *)queue {
    if (!queue__) {
        queue__ = [[NSOperationQueue alloc] init];
    }
    return queue__;
}

- (void) regionDidChange:(NSDate *) date {
    if (![date isEqualToDate:lastRegionChange]) {
        // If the two dates do not match then the user is still changing regions.
        return;
    }
    self.reloadData = TRUE;
}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSDate *date = [NSDate date];
    lastRegionChange = date;
    [self performSelector:@selector(regionDidChange:) withObject:date afterDelay:1.0];
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[Spot class]]) {
        return ((Spot *)annotation).annotationView;        
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    Spot *spot = view.annotation;
    [self.delegate weatherFlowMapView:self didSelectSpot:spot];
}


@end
