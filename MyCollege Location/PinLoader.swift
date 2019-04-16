//
// PinLoader.swift
// MyCollege Location
//
// Created by Zachary Denny on 3/5/19.
// Updated by Zachary Denny on 3/08/19.
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

import Foundation
import CoreLocation
import MapKit

var pins:[PinStruct] = []

public class LoadPins {
    
    //static let shared = LoadPins()
    
    //Map Kit pin array to hold all the final mapkit pins
    var mkPinsArray: [MKPointAnnotation] = []
    
    
    
    //Loads all the pins from the passed university id
    func load( passedPinArray:[PinStruct] ){
        
        pins = passedPinArray
        
        //makes the number of pins passed to it
        for i in 0 ..< passedPinArray.count
        {
            let pointAnnotation = MKPointAnnotation() // First create an annotation.
            
            let pinLong = Double(passedPinArray[i].Pin_Long)
            let pinLat = Double(passedPinArray[i].Pin_Lat)
            let pinDescription = passedPinArray[i].Description
            
            //setting all the pins values
            pointAnnotation.title = passedPinArray[i].Name
            pointAnnotation.coordinate = CLLocationCoordinate2D( latitude: pinLat ?? 0 , longitude: pinLong ?? 0)
            pointAnnotation.subtitle = pinDescription
            
            mkPinsArray.append(pointAnnotation) // Now append this newly created annotation to array.
            
            //display output of pin to developer
            print(mkPinsArray[i].title as Any)
        }
        
        ViewController.hanlderBlock(true, mkPinsArray)
        
    }
    
    //set pins
    public func setUniversityPins(passedPinArray:[PinStruct]) {
        
        load(passedPinArray: passedPinArray)
        
        
    }
    
    //get pins
    public func getUniversityPins() -> [ MKPointAnnotation ] {
        return mkPinsArray
    }
    
    

    
    
    
    
    
    
    
    
    
}


