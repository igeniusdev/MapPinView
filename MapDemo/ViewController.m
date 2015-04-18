//
//  ViewController.m
//  MapDemo
//
//  Created by ShriHari on 4/15/15.
//  Copyright (c) 2015 iGeniusDev. All rights reserved.
//

#import "ViewController.h"

#define iOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //create mapView and add it in viewcontroller...
    mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    mapView.delegate = self;
    [self.view addSubview:mapView];
    
    //find user locaton...
    [self findLocation];
}

-(void)findLocation {
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
#ifdef __IPHONE_8_0
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [locationManager requestWhenInUseAuthorization];
        [locationManager requestAlwaysAuthorization];
    }
#endif
    
    [locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManager delegate methods
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *newLocation = [locations lastObject];
    [self addPinAnnotation:newLocation];

    // Turn off the location manager to save power.
    [manager stopUpdatingLocation];
    
}

#pragma mark - MKMapView Delegate Methods
- (MKAnnotationView*) mapView:(MKMapView *)map viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString * const kPinIdentifier = @"Pin";
    
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kPinIdentifier];
    if (!pin)
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kPinIdentifier];

    UILabel *lbl = [[UILabel alloc] init];
    [lbl setFont:[UIFont fontWithName:@"Helvetica" size:10]];
    CGSize textsize = [[annotation title] sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:10]}];
    float wd = textsize.width + 10;
    lbl.backgroundColor = [UIColor blackColor];
    lbl.textColor = [UIColor whiteColor];
    lbl.alpha = 0.8;
    lbl.tag = 42;
    lbl.frame = CGRectMake((pin.frame.size.width - wd) / 2 , pin.frame.origin.y - 5, wd, 20);
    lbl.lineBreakMode = NSLineBreakByWordWrapping;
    lbl.numberOfLines = 0;
    lbl.textAlignment = NSTextAlignmentCenter;
    
    [pin addSubview:lbl];
    pin.annotation = annotation;
    pin.animatesDrop = NO;
    pin.pinColor = MKPinAnnotationColorGreen;
    
    UILabel *lbl1 = (UILabel *)[pin viewWithTag:42];
    lbl1.text = annotation.title;
    return pin;
}

- (void) addPinAnnotation:(CLLocation*)location {
    MKPointAnnotation * placemarkAnnotation = [[MKPointAnnotation alloc] init];
    placemarkAnnotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    placemarkAnnotation.title = @"My Current Location";
    [mapView addAnnotation:placemarkAnnotation];
    [self zoomMapToLocation:location];
}

-(void)zoomMapToLocation:(CLLocation*)location {
    CLLocationCoordinate2D track;
    track.latitude = location.coordinate.latitude;
    track.longitude = location.coordinate.longitude;
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.8;
    span.longitudeDelta = 0.8;
    region.span = span;
    region.center = track;
    [mapView setRegion:region animated:TRUE];
    [mapView regionThatFits:region];
}

@end
