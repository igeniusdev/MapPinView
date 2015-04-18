Get User’s Current Location On Map
====================================
---
	The main purpose of this tutorial is to describe how to find user’s current location 
	and locate it on the map with pin. Apple provides MapKit API to deal with built-in 
	maps and pin a location.
---
Lets understand this by creating a simple demo:

**Step 1:**
Create a new xcode project named “MapDemo”. It will contain a ViewController.h and ViewController.m files.

**Step 2:**
Now add MapKit framework before proceeding further.	 It is necessary to display built-in maps in your viewcontroller. To add this framework you can follow these steps :
-	go to project target
-	click on build phases tab
-	expand “Link Binary with Libraries” tab
-	click on “+” and you will get the list of all available libraries.
-	Find MapKit library and click on “Add” button. That’s it.  Now you can access MapKit framework in your app.

**Step 3:**
Open ViewController.h file and import MapKit framework as below:

#import <MapKit/MapKit.h>

**Step 4:**
Now replace the interface declaration with below code:

@interface ViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate> {
    MKMapView *mapView;
    CLLocationManager *locationManager;
}

Here we have declared objects 2 objects :
MKMapView : it provides an embeddable map interface.
CLLocationManager : it provides support for location related activities like tracking large or small changes in user location.

**Step 5:**
Open ViewController.m file. Go to viewDidLoad method and add below code:


mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
mapView.delegate = self;
[self.view addSubview:mapView];

Here we create mapView, set its delegate and add it to current view controller.

**Step 6:**
Now we will initialize CLLocationManager object to get user’s current location. Create a method called findLocation as given below:

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

Here we have initialized CLLocationManager object and set its delegate to self so the delegate method that updates user’s location can be called.

NOTE : Before iOS 8, we don’t have to ask for user permission manually by code to access their location. But from iOS 8, it is compulsory to put the below code for user permission:

#ifdef __IPHONE_8_0
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [locationManager requestWhenInUseAuthorization];
        [locationManager requestAlwaysAuthorization];
    }
#endif

You must have to include either of the following key-value pair in you .plist file to get this code work:

key : NSLocationWhenInUseUsageDescription
or
key : NSLocationAlwaysUsageDescription
type : String
value : Allow <your app name> to access your location


**Step 7:**
Now implement delegate method didUpdateLocations of CLLocationManager which is called when user’s location is updated.

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *newLocation = [locations lastObject];
    [self addPinAnnotation:newLocation];

    // Turn off the location manager to save power.
    [manager stopUpdatingLocation];
}

**Step 8:**
Create a method to add pin on map at user’s current location.

- (void) addPinAnnotation:(CLLocation*)location {
    MKPointAnnotation * placemarkAnnotation = [[MKPointAnnotation alloc] init];
    placemarkAnnotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    placemarkAnnotation.title = @"My Current Location";
    [mapView addAnnotation:placemarkAnnotation];
    [self zoomMapToLocation:location];
}

**Step 9:**
Create a method that zoom the map to user’s location.

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

**Step 10:**
To customize pin view, you can implement delegate method of MKMapView as below:
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
