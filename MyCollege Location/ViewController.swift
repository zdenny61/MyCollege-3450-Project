//
//  ViewController.swift
//  MyCollege Location
//
// Created by Zachary Denny on 2/28/19.
// Updated by Zachary Denny on 4/11/19.
// Copyright © 2019 Denny Homes. All rights reserved.
//
//
// ================================================================
//  MyCollege Location License
// ================================================================
// Copyright © 2019 Denny Homes. All rights reserved.
//
// Permission is hereby granted, free of charge,
// to any person obtaining a copy
// of this software and associated documentation files (the "Software"),
// to use the Software with restriction. Restrictions including
// the rights to use, copy, modify, merge, publish, distribute,
// sublicense, and/or sell
// copies of the Software. If you wish to use this software,
// the following //conditions must be met:
//
// The above copyright notice and this permission notice shall
// be included //in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF
// ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE,
// AND NON-INFRINGEMENT. IN NO EVENT
// SHALL THE AUTHORS OR COPYRIGHT HOLDERS
// BE LIABLE FOR ANY CLAIM, DAMAGES, OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF, OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//
// THE SOFTWARE PROVIDED IS TO BE USED FOR LEARNING
// PURPOSES OR FOR A PERSONS OWN SELF USE. NO PERSON MAY SELL,
// PUBLISH, OR DISTRIBUTE
// ANY PARTS OF THE CODE IN ITS ENTIRETY OR THE APPLICATION ITSELF.
// ALL CODE AND
// THE APPLICATION ITSELF IS THE PROPERTY OF ZACHARY TAYLOR Denny
// (THE ORIGINAL WRTIER OF THIS CODE)
// OWNER OF DENNY HOMES AND ANY ORGANIZATION THAT
// ZACHARY TAYLOR DENNY (THE ORIGINAL WRTIER OF THIS CODE) OR DENNY HOMES // IS WORKING WITH.
//

import UIKit
import LocalAuthentication
import CoreLocation
import MapKit
import FirebaseStorage






class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, PinViewViewControllerDelegate, UITabBarControllerDelegate, UITabBarDelegate{
    
    
    
    //testing
   
    
    //static let shared = ViewController()
    
    let date = Date()
    let formatter = DateFormatter()
    
    enum seasons {
        case Summer
        case Winter
        case Spring
    }
    
    var filename = ""
    
    var imageReference: StorageReference {
        return Storage.storage().reference().child("images")
    }
    
    
    //testing
    
    
    
    
    
    @IBOutlet weak var MainMapView: MKMapView!
    
    
    //Used when transfering pins data to pinViewer
    var selectedPinTitle:String = "Error"
    var selectedPinDescription = "Error getting description"
    var selectedPinImage: UIImage = UIImage()
    var selectedPinIndex: Int = -1
    
    //Used for managing location
    let locationManager = CLLocationManager()
    
    //For Downloading all the pins from database
    var feedItems: NSArray = NSArray()
    var selectedStock : PinModel = PinModel()
    let feedModel = FeedModel()
    var FirstTimeBanner = true
    let UniversityCoordents = (latitude: 42.6740 , longitude: -83.2150 )
    var CurrentLocation = (latitude: 42.6740 , longitude: -83.2150 )
    
    
    
    public static var mkPinsArrayPassed: [MKPointAnnotation] = []
    public static let hanlderBlock: (Bool, [MKAnnotation]) -> Void = { doneWork, passed  in
        if doneWork {
            mkPinsArrayPassed = passed as! [MKPointAnnotation]
            dbDone()
            print("Pins ready to load into map")
        }
    }
    
    public static let viewPinHanlderBlock: (Bool, String) -> Void = { doneWork, passed  in
        if doneWork {
            let url = passed
            //ViewController.shared.gotoPinViewer()
        }
    }
    
    
  

   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if (FirstTimeBanner){
            
            
            
            //enable location and authorize
            enableLocationServices();
            
            //Download the pins
            feedModel.downloadItems()
            
            //Download universitys
            UniversityFeedModel.shared.downloadItems()
            
            usleep(1000000) //will sleep for .002 seconds
            
            
            //will be location of university selected but now is oakaland
            let University_Location = CLLocation( latitude: UniversityCoordents.latitude , longitude: UniversityCoordents.longitude )
            
            //start updating current location
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
                
                
                
            }else{
                //maybe load pins auto now ??? when coming back to the view
                
            }
            
//            //let center = CLLocationCoordinate2D( latitude: UniversityCoordents.latitude , longitude: UniversityCoordents.longitude )
        
            
           
//            // Make sure the app is authorized.
//            if CLLocationManager.authorizationStatus() == .authorizedAlways {
//                // Make sure region monitoring is supported.
//                if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
//                    // Register the region.
//                    let maxDistance = locationManager.maximumRegionMonitoringDistance
//                    let region = CLCircularRegion(center: center,
//                                                  radius: 5000.0, identifier: "YourRegionID")
//                    region.notifyOnEntry = true
//                    region.notifyOnExit = false
//
//                    locationManager.startMonitoring(for: region)
//                }
//            }
           
        


        }
        
       
        
//
//        let pointAnnotation = MKPointAnnotation() // First create an annotation.
//
//
//        //setting all the pins values
//        //            pointAnnotation.title = Pins[i].title
//        //            pointAnnotation.coordinate = Pins[i].coordinate
//        //            pointAnnotation.subtitle = Pins[i].subtitle
//
//        pointAnnotation.title = "test"
//        pointAnnotation.coordinate = CLLocationCoordinate2D( latitude: 42.6768 , longitude: -83.1397 )
//
//        pointAnnotation.subtitle = "Pins[i].subtitle"
//
//
//        MainMapView.addAnnotation(pointAnnotation)
        
        
    }
    
    
    func continueFunc(){
        
    }
    
    //Hide the status bar so its not in the way of the map
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
    
    
    
    
    //testing
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
        
    }
    
    
   
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        if annotation is MKUserLocation { return nil }
//
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin") as? MKPinAnnotationView
//        if annotationView == nil {
//            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
//            annotationView?.canShowCallout = true
//            annotationView?.rightCalloutAccessoryView = UIButton(type: .infoLight)
//        } else {
//            annotationView?.annotation = annotation
//        }
//
//        return annotationView
//    }
    
    func selectUniversity()  {
        // create an actionSheet
        let actionSheetController: UIAlertController = UIAlertController(title: "Select a University", message: nil, preferredStyle: .actionSheet)
        
        for iUniversity in 0 ..< arrayAllUniversitys.count
        {
            
            // create an action and depending on what university is selected, change stuff
            let firstAction: UIAlertAction = UIAlertAction(title: arrayAllUniversitys[iUniversity].Name, style: .default) { action -> Void in
                
                print("\(arrayAllUniversitys[iUniversity].Name)")
                
                let Pins = ViewController.mkPinsArrayPassed
                
                for i in 0 ..< Pins.count
                {
                    
                    if( pins[i].University_Ref_ID == arrayAllUniversitys[iUniversity].University_ID){
                        
                        let pointAnnotation = MKPointAnnotation() // First create an annotation.
                        
                        //setting all the pins values
                        pointAnnotation.title = Pins[i].title
                        pointAnnotation.coordinate = Pins[i].coordinate
                        pointAnnotation.subtitle = Pins[i].subtitle
                        //pointAnnotation.description = "test"
                        
                        
                        self.MainMapView.addAnnotation(pointAnnotation)
                        
                    }
                }
            }
            
            
            
//            if(iUniversity != 0){
            //adds each action sheet to the controller as long as its active so no filtering needed
                actionSheetController.addAction(firstAction)
            //}
            
            //for testing only!!!!!!!!!!!!!!!!!!!! Shows "other" option
//            if(iUniversity == 0){
//                actionSheetController.addAction(firstAction)
//            }
            
        }
        
//        // create an action and depending on what university is selected, change stuff
//        let firstAction: UIAlertAction = UIAlertAction(title: arrayAllUniversitys[1].Name, style: .default) { action -> Void in
//
//            print("Oakland University")
//
//            let Pins = ViewController.mkPinsArrayPassed
//
//
//
//            for i in 0 ..< Pins.count
//            {
//
//                if( pins[i].University_Ref_ID == arrayAllUniversitys[1].University_ID){
//
//                    let pointAnnotation = MKPointAnnotation() // First create an annotation.
//
//                    //setting all the pins values
//                    pointAnnotation.title = Pins[i].title
//                    pointAnnotation.coordinate = Pins[i].coordinate
//                    pointAnnotation.subtitle = Pins[i].subtitle
//                    //pointAnnotation.description = "test"
//
//
//                    self.MainMapView.addAnnotation(pointAnnotation)
//
//                }
//            }
//        }
//
//        let secondAction: UIAlertAction = UIAlertAction(title: "Oakland Community College", style: .default) { action -> Void in
//
//            print("Oakland Community College")
//        }
//        let thirdAction: UIAlertAction = UIAlertAction(title: "Other", style: .default) { action -> Void in
//
//            print("Other")
//
//            let Pins = ViewController.mkPinsArrayPassed
//
//
//
//            for i in 0 ..< Pins.count
//            {
//
//                if( pins[i].University_Ref_ID == "-1"){
//
//                    let pointAnnotation = MKPointAnnotation() // First create an annotation.
//
//                    //setting all the pins values
//                    pointAnnotation.title = Pins[i].title
//                    pointAnnotation.coordinate = Pins[i].coordinate
//                    pointAnnotation.subtitle = Pins[i].subtitle
//                    //pointAnnotation.description = "test"
//
//
//                    self.MainMapView.addAnnotation(pointAnnotation)
//
//                }
//            }
//
//        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        
        // add actions
//        actionSheetController.addAction(firstAction)
//        actionSheetController.addAction(secondAction)
//        actionSheetController.addAction(thirdAction)
        actionSheetController.addAction(cancelAction)
        
        // present an actionSheet...
        present(actionSheetController, animated: true, completion: nil)
    }
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin") as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.tintColor = .green                // do whatever customization you want
            annotationView?.canShowCallout = true            // but turn off callout
            
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    //When pin is touched, calls method
//    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//
//        var selectedAnnotation: MKPointAnnotation?
//        selectedAnnotation = view.annotation as? MKPointAnnotation
//
//        print(selectedAnnotation?.coordinate)
//
//        // go to pins view and transfer the pins info
//        //performSegue(withIdentifier: "SeguePinView", sender: view)
//        //self.performSegue(withIdentifier: "SeguePinView", sender: self)
//        if let vc = self.storyboard?.instantiateViewController(withIdentifier:"SeguePinView") {
//            vc.modalTransitionStyle   = .crossDissolve;
//            vc.modalPresentationStyle = .overCurrentContext
//            self.present(vc, animated: true, completion: nil)
//        }
//
//
//
//    }
    
//    override func prepareForSegue(for segue: UIStoryboardSegue, sender: AnyObject?) // func for popover
//    {
//        if segue.identifier == "SeguePinView"
//        {
//            let vc = segue.destinationViewController
//
//            vc.preferredContentSize = CGSize(width: 200, height: 300)
//
//            let controller = vc.popoverPresentationController
//
//            controller?.delegate = self
//            //you could set the following in your storyboard
//            controller?.sourceView = self.view
//            controller?.sourceRect = CGRect(x:CGRectGetMidX(self.view.bounds), y: CGRectGetMidY(self.view.bounds),width: 315,height: 230)
//            controller?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
//
//        }
//    }
    
    
    
//
//        //transfers the pins info with the segue change
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //pass title, description, and image of the selected pin to the viewr class
        PinViewViewController().transferPinData(passedTitle: selectedPinTitle, passedDescription: selectedPinDescription, passedImage: selectedPinImage, passedIndex: selectedPinIndex)
    }


    
    
    
    //When pin is tapped, show the callout and then set tap on callout to a gesture
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ViewController().calloutTapped(sender:)))
        view.addGestureRecognizer(gesture)
    }
    
    
    //when callout is tapped
    @objc func calloutTapped(sender:UITapGestureRecognizer) {
        
        guard let selectedAnnotation = (sender.view as? MKAnnotationView)?.annotation as? MKPointAnnotation else { return }
        
        //Get and set selected annotation details to pin viewer
        selectedPinTitle = selectedAnnotation.title ?? "Error"
        selectedPinDescription = selectedAnnotation.subtitle ?? "Error with pin info"
        //some how get the pins image info then retreave image info and last send the image to the viewer
        
        
        //Find out what the selected pins index is
        var tempTitleArray: [String] = []
        //make temp array with all pin titles in it to search
        for i in 0 ..< ViewController.mkPinsArrayPassed.count
        {
            tempTitleArray.insert(ViewController.mkPinsArrayPassed[i].title ?? "Error", at: i)
        }
        
        //search temp array for the pins title and then use that index as the selected pins index
        let selectedIndexOfPin = tempTitleArray.firstIndex(of: selectedAnnotation.title ?? "Error")
        
        //set local selected variable to the new found index of seleceted pin
        selectedPinIndex = selectedIndexOfPin ?? -1
        
        
        
        //Call method to get the selected pins image from servers. Pass the index of the pin's image indexs
        selectedPinImage = getSelectedPinsImage(passedPinIndex: selectedIndexOfPin ?? -1)
        
        
        //perform segue and go to pinView
        performSegue(withIdentifier: "SeguePinView", sender: self)
    }
    
   
    
    //method to get the pins image for the viewer
    func getSelectedPinsImage(passedPinIndex: Int) -> UIImage {
        
        //do stuff with pin index like use it to get the url to the pins real image
        
        
        
        //download picture
        
        formatter.dateFormat = "MM"
        let currentMonth = formatter.string(from: date)
        var currentSeason:seasons = seasons.Winter
        
        
        //check the current month and set the season
        if (currentMonth == "11" || currentMonth == "12" || currentMonth == "01" || currentMonth == "02"){
            //winter
            currentSeason = seasons.Winter
        } else if (currentMonth == "03" || currentMonth == "04" || currentMonth == "05" || currentMonth == "06"){
            //spring
            currentSeason = seasons.Spring
        }
        else if (currentMonth == "07" || currentMonth == "08" || currentMonth == "09" || currentMonth == "10"){
            //summer
            currentSeason = seasons.Summer
        }
        
        
        //switch on season
        switch currentSeason {
        case seasons.Winter:
            _ = PictureFeedModel().downloadItems(passedID: pins[passedPinIndex].Picture_Winter_ID)
            break
        case seasons.Spring:
            _ = PictureFeedModel().downloadItems(passedID: pins[passedPinIndex].Picture_Spring_ID)
            break
        case seasons.Summer:
            _ = PictureFeedModel().downloadItems(passedID: pins[passedPinIndex].Picture_Summer_ID)
            break
        
            
        }
        
        
       // let pictureURL = PictureFeedModel.shared.downloadItems(passedID: pins[0].Picture_Spring_ID)
        //print(pictureURL)
        
        
        
        
       
//        self.filename = publicPinURL//"17ADE8B4-6CA8-4B6F-AE34-37E17541E781.jpg"//self.txtImageID.text!
//        let downloadImageRef = self.imageReference.child(self.filename)
//        //        Storage.storage().reference(forURL: filename)
//        let downloadtask = downloadImageRef.getData(maxSize: 1024 * 1024 * 12) { (data, error) in
//            if let error = error {
//                // Handle any errors
//                print(error ?? "NO ERROR")
//            } else if let data = data {
//                // Get the download URL for 'images/stars.jpg'
//                let image = UIImage(data: data)
//                self.imagePinImage?.image = image
//            }
//
//        }
        
//        //URL for the image retreavied from the image array
//        let url = URL(string: "http://www.denny-homes-server.com/MyCollegeApp/DBPinImages/Tests/OUClockSpring.jpg")!
//
//        //download image as data and then return as converted UIImage. if error, return empty image
//        print("Download Started")
//        let data = try? Data(contentsOf: url)
//        print("Download Finished")
//        let testimage = UIImage(data: data!)
        
        return UIImage()
        
    }
    
    
    
    
    
    
    
    
    //For detecting when other schools is tapped
    public func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
       
        //call select university method that displays UIAlertSheet
        selectUniversity()
      
        
        
    }
    
    

    
    
    
    
    
    
    //testing
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
    
    //update current location and follow on map
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        //Center on current location
        let currentLocation = CLLocation(latitude: locValue.latitude , longitude: locValue.longitude )
        CurrentLocation.latitude = locValue.latitude
        CurrentLocation.longitude = locValue.longitude
        centerMapOnLocation( currentLocation, mapView: MainMapView)
        locationManager.stopUpdatingLocation()
        selectUniversity()
    }
    
    
    public static func dbDone(){
        DispatchQueue.main.async{
            //put your code here
        
        ViewController().addPinsToMap()
        }
    }
    
    func addPinsToMap()  {
        if (FirstTimeBanner){
            FirstTimeBanner = false
            //viewDidLoad()
            
        }
    }
    
    
    
    //Check and enable location services
    func enableLocationServices() {
        locationManager.delegate = self as? CLLocationManagerDelegate
        
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
   
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return
            
       
        case .denied, .restricted:
            let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            break
            
            
            
        }
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    
    }
    
    public func centerMapOnLocation(_ location: CLLocation, mapView: MKMapView) {
        let regionRadius: CLLocationDistance = 800
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        MainMapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    
    
   
  
    
    
    
    
    



}
    
    

