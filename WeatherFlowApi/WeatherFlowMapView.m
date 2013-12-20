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

- (id)init {
    self = [super init];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void) baseInit {
    self.mapView.delegate = self;
    self.reloadData = TRUE;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.mapView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

#pragma mark - Setter and Getter
- (MKMapView *)mapView {
    if (!mapView__) {
        mapView__ = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        mapView__.mapType = MKMapTypeStandard;
        [mapView__ setCenterCoordinate:self.centerLocation.coordinate zoomLevel:DefaultZoomLevel animated:NO];
        mapView__.showsUserLocation = self.showUserLocation;
        [self addSubview:mapView__];
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
    [self.mapView setCenterCoordinate:centerLocation.coordinate zoomLevel:self.mapView.zoomLevel animated:YES];
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
            NSLog(@"%0.1f", self.mapView.zoomLevel);
            SpotSet *spotSet = [WeatherFlowApi getSpotSetByZoomLevel:self.mapView.zoomLevel lat_min:min.latitude lon_min:min.longitude lat_max:max.latitude lon_max:max.longitude error:nil];
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
    NSArray *new = visibleSpotSet.spots;
    NSArray *current = visibleSpotSet__.spots;
    
    NSMutableSet* newSet = [NSMutableSet setWithArray:new];
    NSMutableSet* currentSet = [NSMutableSet setWithArray:current];
    [newSet intersectSet:currentSet]; //this will give you only the obejcts that are in both sets
    NSArray *common = [newSet allObjects];

    NSMutableArray *annotationsToRemove = current.mutableCopy;
    NSMutableArray *annotationsToAdd = new.mutableCopy;
    for (Spot *spot in common) {
        spot.annotationView.canShowCallout = self.displayCallout;
        [annotationsToRemove removeObject:spot];
        [annotationsToAdd removeObject:spot];
    }
    
    [self.mapView removeAnnotations:annotationsToRemove];
    [self.mapView addAnnotations:annotationsToAdd];
    visibleSpotSet__ = visibleSpotSet;
    // TODO: can be doen with a more efficient way.
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        if ([annotation isKindOfClass:[Spot class]]) {
            Spot *spot = annotation;
            [spot.annotationView setCanShowCallout:self.displayCallout];
        }
    }
    NSLog(@"%@", visibleSpotSet);
}

- (NSArray *)selectedSpots {
    return self.mapView.selectedAnnotations;
}

- (void)setSelectedSpots:(NSArray *)selectedSpots {
    self.mapView.selectedAnnotations = selectedSpots;
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

- (BOOL)displayCallout {
    return displayCallout__;
}

- (void)setDisplayCallout:(BOOL)displayCallout {
    if (displayCallout == displayCallout__) {
        return;
    }
    displayCallout__ = displayCallout;
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        if ([annotation isKindOfClass:[Spot class]]) {
            Spot *spot = annotation;
            [spot.annotationView setCanShowCallout:self.displayCallout];
        }
    }
}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSDate *date = [NSDate date];
    lastRegionChange = date;
    [self performSelector:@selector(regionDidChange:) withObject:date afterDelay:1.0];
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view.annotation isKindOfClass:[Spot class]]) {
        if ([self.delegate respondsToSelector:@selector(weatherFlowMapView:didSelectSpot:)]) {
            [self.delegate weatherFlowMapView:self didSelectSpot:view.annotation];
        }
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([view.annotation isKindOfClass:[Spot class]]) {
        if ([self.delegate respondsToSelector:@selector(weatherFlowMapView:didDeselectSpot:)]) {
            [self.delegate weatherFlowMapView:self didDeselectSpot:view.annotation];
        }
    }
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[Spot class]]) {
        return ((Spot *)annotation).annotationView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    if ([view.annotation isKindOfClass:[Spot class]]) {
        if ([self.delegate respondsToSelector:@selector(weatherFlowMapView:spot:calloutAccessoryTapped:)]) {
            [self.delegate weatherFlowMapView:self spot:view.annotation calloutAccessoryTapped:control];
        }
    }
}

@end
