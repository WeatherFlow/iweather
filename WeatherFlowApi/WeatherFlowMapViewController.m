//
//  WeatherFlowMapViewController.m
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 05/12/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import "WeatherFlowMapViewController.h"
#import "WeatherFlowMapView.h"

@interface WeatherFlowMapViewController ()

@end

@implementation WeatherFlowMapViewController

- (id)init {
    self = [super init];
    if (self) {
        [self.view addSubview:self.mapView];
    }
    return self;
}

#pragma mark - Setter and Getter
- (WeatherFlowMapView *)mapView {
    if (!mapView__) {
        mapView__ = [[WeatherFlowMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return mapView__;
}

@end
