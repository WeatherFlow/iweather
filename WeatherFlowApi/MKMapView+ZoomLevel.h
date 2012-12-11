//
//  MKMapView+ZoomLevel.h
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 05/12/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

- (CLLocationCoordinate2D) minCoordinate;
- (CLLocationCoordinate2D) maxCoordinate;


@end
