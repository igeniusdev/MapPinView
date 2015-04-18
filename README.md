{\rtf1\ansi\ansicpg1252\cocoartf1343\cocoasubrtf160
{\fonttbl\f0\fnil\fcharset0 Cambria;\f1\froman\fcharset0 TimesNewRomanPSMT;\f2\fnil\fcharset0 Menlo-Regular;
}
{\colortbl;\red255\green255\blue255;\red100\green56\blue32;\red196\green26\blue22;\red170\green13\blue145;
\red92\green38\blue153;\red63\green110\blue116;\red46\green13\blue110;\red28\green0\blue207;\red0\green116\blue0;
\red38\green71\blue75;}
{\*\listtable{\list\listtemplateid1\listhybrid{\listlevel\levelnfc23\levelnfcn23\leveljc0\leveljcn0\levelfollow0\levelstartat0\levelspace360\levelindent0{\*\levelmarker \{disc\}}{\leveltext\leveltemplateid1\'01\uc0\u8226 ;}{\levelnumbers;}\fi-360\li720\lin720 }{\listname ;}\listid1}
{\list\listtemplateid2\listhybrid{\listlevel\levelnfc23\levelnfcn23\leveljc0\leveljcn0\levelfollow0\levelstartat0\levelspace360\levelindent0{\*\levelmarker \{disc\}}{\leveltext\leveltemplateid101\'01\uc0\u8226 ;}{\levelnumbers;}\fi-360\li720\lin720 }{\listname ;}\listid2}}
{\*\listoverridetable{\listoverride\listid1\listoverridecount0\ls1}{\listoverride\listid2\listoverridecount0\ls2}}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\ri-810\qc

\f0\b\fs28 \cf0 \ul \ulc0 Get User\'92s Current Location On Map
\f1\b0 \ulnone \
\
\pard\pardeftab720\ri-810
\cf0 	
\f0 The main purpose of this tutorial is to describe how to find user\'92s current location and locate it on the map with pin. Apple provides MapKit API to deal with built-in maps and pin a location.\
\
Lets understand this by creating a simple demo:\
\
\pard\pardeftab720\ri-810

\b \cf0 \ul \ulc0 Step 1:
\f1\b0 \ulnone \
\pard\pardeftab720\ri-810

\f0 \cf0 Create a new xcode project named \'93MapDemo\'94. It will contain a ViewController.h and ViewController.m files.\
\
\pard\pardeftab720\ri-810

\b \cf0 \ul \ulc0 Step 2:
\f1\b0 \ulnone \
\pard\pardeftab720\ri-810

\f0 \cf0 Now add MapKit framework before proceeding further.	 It is necessary to display built-in maps in your viewcontroller. To add this framework you can follow these steps :\
\pard\pardeftab720\li720\fi-360\ri-810
\ls1\ilvl0\cf0 -	go to project target\
-	click on build phases tab\
-	expand \'93Link Binary with Libraries\'94 tab\
-	click on \'93+\'94 and you will get the list of all available libraries.\
-	Find MapKit library and click on \'93Add\'94 button. That\'92s it.  Now you can access MapKit framework in your app.
\f1 \
\pard\pardeftab720\ri-810

\f0\b \cf0 \ul \ulc0 Step 3:
\f1 \
\pard\pardeftab720\ri-810

\f0\b0 \cf0 \ulnone Open ViewController.h file and import MapKit framework as below:\
\
\pard\pardeftab720\ri-810

\f2 \cf2 #import \cf3 <MapKit/MapKit.h>\
\
\pard\pardeftab720\ri-810

\f0\b \cf0 \ul \ulc0 Step 4:\
\pard\pardeftab720\ri-810

\b0 \cf0 \ulnone Now replace the interface declaration with below code:\
\
\pard\tx866\pardeftab720\ri-810

\f2 \cf4 @interface\cf0  ViewController : \cf5 UIViewController\cf0 <\cf5 CLLocationManagerDelegate\cf0 ,\cf5 MKMapViewDelegate\cf0 > \{\
    \cf5 MKMapView\cf0  *mapView;\
    \cf5 CLLocationManager\cf0  *locationManager;\
\pard\pardeftab720\ri-810
\cf0 \}\
\
\pard\pardeftab720\ri-810

\f0 \cf0 Here we have declared objects 2 objects :\
\pard\pardeftab720\li720\fi-360\ri-810
\ls2\ilvl0\cf0 -	MKMapView : it provides an embeddable map interface.\
-	CLLocationManager : it provides support for location related activities like tracking large or small changes in user location.\
\pard\pardeftab720\ri-810

\f1 \cf0 \
\pard\pardeftab720\ri-810

\f0\b \cf0 \ul \ulc0 Step 5:\
\pard\pardeftab720\ri-810

\b0 \cf0 \ulnone Open ViewController.m file. Go to viewDidLoad method and add below code:\
\
\
\pard\tx866\pardeftab720\ri-810

\f2 \cf6 mapView\cf0  = [[\cf5 MKMapView\cf0  \cf7 alloc\cf0 ] \cf7 initWithFrame\cf0 :\cf4 self\cf0 .\cf5 view\cf0 .\cf5 frame\cf0 ];\
\cf6 mapView\cf0 .\cf5 delegate\cf0  = \cf4 self\cf0 ;\
\pard\pardeftab720\ri-810
\cf0 [\cf4 self\cf0 .\cf5 view\cf0  \cf7 addSubview\cf0 :\cf6 mapView\cf0 ];\
\
\pard\pardeftab720\ri-810

\f0 \cf0 Here we create mapView, set its delegate and add it to current view controller.\
\
\pard\pardeftab720\ri-810

\b \cf0 \ul \ulc0 Step 6:
\f1 \
\pard\pardeftab720\ri-810

\f0\b0 \cf0 \ulnone Now we will initialize CLLocationManager object to get user\'92s current location. Create a method called findLocation as given below:\
\
\pard\tx866\pardeftab720\ri-810

\f2 \cf0 -(\cf4 void\cf0 )findLocation \{\
\pard\tx866\pardeftab720\ri-810
\cf6 locationManager\cf0  = [[\cf5 CLLocationManager\cf0  \cf7 alloc\cf0 ] \cf7 init\cf0 ];\
\cf6 locationManager\cf0 .\cf5 delegate\cf0  = \cf4 self\cf0 ;\
    \
\pard\tx866\pardeftab720\ri-810
\cf2 #ifdef __IPHONE_8_0\
\pard\tx866\pardeftab720\ri-810
\cf0     \cf4 if\cf0 ([[[\cf5 UIDevice\cf0  \cf7 currentDevice\cf0 ] \cf7 systemVersion\cf0 ] \cf7 floatValue\cf0 ] >= \cf8 8.0\cf0 ) \{\
        \cf9 // Use one or the other, not both. Depending on what you put in info.plist\cf0 \
        [\cf6 locationManager\cf0  \cf7 requestWhenInUseAuthorization\cf0 ];\
        [\cf6 locationManager\cf0  \cf7 requestAlwaysAuthorization\cf0 ];\
    \}\
\pard\tx866\pardeftab720\ri-810
\cf2 #endif\
\pard\tx866\pardeftab720\ri-810
\cf0     \
    [\cf6 locationManager\cf0  \cf7 startUpdatingLocation\cf0 ];\
\pard\pardeftab720\ri-810
\cf0 \}\
\
\pard\pardeftab720\ri-810

\f0 \cf0 Here we have initialized
\f2  
\f0 CLLocationManager object and set its delegate to self so the delegate method that updates user\'92s location can be called.\
\
\pard\pardeftab720\ri-810

\b \cf0 NOTE : 
\b0 Before iOS 8, we don\'92t have to ask for user permission manually by code to access their location. But from iOS 8, it is compulsory to put the below code for user permission:\
\
\pard\tx866\pardeftab720\ri-810

\f2 \cf2 #ifdef __IPHONE_8_0\
\pard\tx866\pardeftab720\ri-810
\cf0     \cf4 if\cf0 ([[[\cf5 UIDevice\cf0  \cf7 currentDevice\cf0 ] \cf7 systemVersion\cf0 ] \cf7 floatValue\cf0 ] >= \cf8 8.0\cf0 ) \{\
        \cf9 // Use one or the other, not both. Depending on what you put in info.plist\cf0 \
        [\cf6 locationManager\cf0  \cf7 requestWhenInUseAuthorization\cf0 ];\
        [\cf6 locationManager\cf0  \cf7 requestAlwaysAuthorization\cf0 ];\
    \}\
\pard\tx866\pardeftab720\ri-810
\cf2 #endif\
\pard\pardeftab720\ri-810

\f1 \cf0 \

\f0 You must have to include either of the following key-value pair in you .plist file to get this code work:\
\
\pard\pardeftab720\li360\fi720\ri-810
\cf0 key : NSLocationWhenInUseUsageDescription
\f1 \
\pard\pardeftab720\li360\fi720\ri-810\qc

\f0 \cf0 or\
\pard\pardeftab720\li360\fi720\ri-810
\cf0 key : NSLocationAlwaysUsageDescription\
\pard\pardeftab720\li1080\ri-810
\cf0 type : String\
value : Allow <your app name> to access your location\
\pard\pardeftab720\ri-810

\f1 \cf0 \
\
\pard\pardeftab720\ri-810

\f0\b \cf0 \ul \ulc0 Step 7:
\f1 \
\pard\pardeftab720\ri-810

\f0\b0 \cf0 \ulnone Now implement delegate method didUpdateLocations of CLLocationManager which is called when user\'92s location is updated.\
\
\pard\tx866\pardeftab720\ri-810

\f2 \cf0 -(\cf4 void\cf0 )locationManager:(\cf5 CLLocationManager\cf0  *)manager didUpdateLocations:(\cf5 NSArray\cf0  *)locations \{\
    \cf5 CLLocation\cf0  *newLocation = [locations \cf7 lastObject\cf0 ];\
    [\cf4 self\cf0  \cf10 addPinAnnotation\cf0 :newLocation];\
\
    \cf9 // Turn off the location manager to save power.\cf0 \
    [manager \cf7 stopUpdatingLocation\cf0 ];\
\pard\pardeftab720\ri-810
\cf0 \}\
\
\pard\pardeftab720\ri-810

\f0\b \cf0 \ul \ulc0 Step 8:
\f1 \
\pard\pardeftab720\ri-810

\f0\b0 \cf0 \ulnone Create a method to add pin on map at user\'92s current location.\
\
\pard\tx866\pardeftab720\ri-810

\f2 \cf0 - (\cf4 void\cf0 ) addPinAnnotation:(\cf5 CLLocation\cf0 *)location \{\
    \cf5 MKPointAnnotation\cf0  * placemarkAnnotation = [[\cf5 MKPointAnnotation\cf0  \cf7 alloc\cf0 ] \cf7 init\cf0 ];\
    placemarkAnnotation.\cf5 coordinate\cf0  = \cf7 CLLocationCoordinate2DMake\cf0 (location.\cf5 coordinate\cf0 .\cf5 latitude\cf0 , location.\cf5 coordinate\cf0 .\cf5 longitude\cf0 );\
    placemarkAnnotation.\cf5 title\cf0  = \cf3 @"My Current Location"\cf0 ;\
    [\cf6 mapView\cf0  \cf7 addAnnotation\cf0 :placemarkAnnotation];\
    [\cf4 self\cf0  \cf10 zoomMapToLocation\cf0 :location];\
\pard\pardeftab720\ri-810
\cf0 \}\
\
\pard\pardeftab720\ri-810

\f0\b \cf0 \ul \ulc0 Step 9:\
\pard\pardeftab720\ri-810

\b0 \cf0 \ulnone Create a method that zoom the map to user\'92s location.\
\
\pard\tx866\pardeftab720\ri-810

\f2 \cf0 -(\cf4 void\cf0 )zoomMapToLocation:(\cf5 CLLocation\cf0 *)location \{\
    \cf5 CLLocationCoordinate2D\cf0  track;\
    track.\cf5 latitude\cf0  = location.\cf5 coordinate\cf0 .\cf5 latitude\cf0 ;\
    track.\cf5 longitude\cf0  = location.\cf5 coordinate\cf0 .\cf5 longitude\cf0 ;\
    \
    \cf5 MKCoordinateRegion\cf0  region;\
    \cf5 MKCoordinateSpan\cf0  span;\
    span.\cf5 latitudeDelta\cf0  = \cf8 0.8\cf0 ;\
    span.\cf5 longitudeDelta\cf0  = \cf8 0.8\cf0 ;\
    region.\cf5 span\cf0  = span;\
    region.\cf5 center\cf0  = track;\
    [\cf6 mapView\cf0  \cf7 setRegion\cf0 :region \cf7 animated\cf0 :\cf4 TRUE\cf0 ];\
    [\cf6 mapView\cf0  \cf7 regionThatFits\cf0 :region];\
\pard\pardeftab720\ri-810
\cf0 \}\
\
\pard\pardeftab720\ri-810

\f0\b \cf0 \ul \ulc0 Step 10:
\f1 \
\pard\pardeftab720\ri-810

\f0\b0 \cf0 \ulnone To customize pin view, you can implement delegate method of MKMapView as below:\
\pard\tx866\pardeftab720\ri-810

\f2 \cf0 - (\cf5 MKAnnotationView\cf0 *) mapView:(\cf5 MKMapView\cf0  *)map viewForAnnotation:(\cf4 id\cf0 <\cf5 MKAnnotation\cf0 >)annotation \{\
    \cf4 static\cf0  \cf5 NSString\cf0  * \cf4 const\cf0  kPinIdentifier = \cf3 @"Pin"\cf0 ;\
    \
    \cf5 MKPinAnnotationView\cf0  *pin = [[\cf5 MKPinAnnotationView\cf0  \cf7 alloc\cf0 ] \cf7 initWithAnnotation\cf0 :annotation \cf7 reuseIdentifier\cf0 :kPinIdentifier];\
    \cf4 if\cf0  (!pin)\
        pin = [[\cf5 MKPinAnnotationView\cf0  \cf7 alloc\cf0 ] \cf7 initWithAnnotation\cf0 :annotation \cf7 reuseIdentifier\cf0 :kPinIdentifier];\
\
    \cf5 UILabel\cf0  *lbl = [[\cf5 UILabel\cf0  \cf7 alloc\cf0 ] \cf7 init\cf0 ];\
    [lbl \cf7 setFont\cf0 :[\cf5 UIFont\cf0  \cf7 fontWithName\cf0 :\cf3 @"Helvetica"\cf0  \cf7 size\cf0 :\cf8 10\cf0 ]];\
    \cf5 CGSize\cf0  textsize = [[annotation \cf7 title\cf0 ] \cf7 sizeWithAttributes\cf0 :\cf8 @\{\cf5 NSFontAttributeName\cf0 :[\cf5 UIFont\cf0  \cf7 fontWithName\cf0 :\cf3 @"Helvetica"\cf0  \cf7 size\cf0 :\cf8 10\cf0 ]\cf8 \}\cf0 ];\
    \cf4 float\cf0  wd = textsize.\cf5 width\cf0  + \cf8 10\cf0 ;\
    lbl.\cf5 backgroundColor\cf0  = [\cf5 UIColor\cf0  \cf7 blackColor\cf0 ];\
    lbl.\cf5 textColor\cf0  = [\cf5 UIColor\cf0  \cf7 whiteColor\cf0 ];\
    lbl.\cf5 alpha\cf0  = \cf8 0.8\cf0 ;\
    lbl.\cf5 tag\cf0  = \cf8 42\cf0 ;\
    lbl.\cf5 frame\cf0  = \cf7 CGRectMake\cf0 ((pin.\cf5 frame\cf0 .\cf5 size\cf0 .\cf5 width\cf0  - wd) / \cf8 2\cf0  , pin.\cf5 frame\cf0 .\cf5 origin\cf0 .\cf5 y\cf0  - \cf8 5\cf0 , wd, \cf8 20\cf0 );\
    lbl.\cf5 lineBreakMode\cf0  = \cf7 NSLineBreakByWordWrapping\cf0 ;\
    lbl.\cf5 numberOfLines\cf0  = \cf8 0\cf0 ;\
    lbl.\cf5 textAlignment\cf0  = \cf7 NSTextAlignmentCenter\cf0 ;\
    \
    [pin \cf7 addSubview\cf0 :lbl];\
    pin.\cf5 annotation\cf0  = annotation;\
    pin.\cf5 animatesDrop\cf0  = \cf4 NO\cf0 ;\
    pin.\cf5 pinColor\cf0  = \cf7 MKPinAnnotationColorGreen\cf0 ;\
    \
    \cf5 UILabel\cf0  *lbl1 = (\cf5 UILabel\cf0  *)[pin \cf7 viewWithTag\cf0 :\cf8 42\cf0 ];\
    lbl1.\cf5 text\cf0  = annotation.\cf5 title\cf0 ;\
\
    \cf4 return\cf0  pin;\
\pard\pardeftab720\ri-810
\cf0 \}
\f1 \
}