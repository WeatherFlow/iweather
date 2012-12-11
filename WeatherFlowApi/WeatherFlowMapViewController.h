//
//  WeatherFlowMapViewController.h
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 05/12/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeatherFlowMapView;

@interface WeatherFlowMapViewController : UIViewController {
    WeatherFlowMapView *mapView__;
}

@property (readonly) WeatherFlowMapView *mapView;

@end
