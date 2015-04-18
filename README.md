Get User’s Current Location On Map
====================================
	The main purpose of this tutorial is to describe how to find user’s current location and locate it on the map with pin. Apple provides MapKit API to deal with built-in maps and pin a location.

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
