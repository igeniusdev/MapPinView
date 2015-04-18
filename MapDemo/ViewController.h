//
//  ViewController.h
//  MapDemo
//
//  Created by ShriHari on 4/15/15.
//  Copyright (c) 2015 iGeniusDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate> {
    MKMapView *mapView;
    CLLocationManager *locationManager;
}

@end

