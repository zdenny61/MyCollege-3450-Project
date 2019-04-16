//
// UserModel.swift
// MyCollege Location
//
// Created by Zachary Denny on 3/6/19.
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

class PinModel: NSObject {
    
    //properties of a pins
    var Pin_ID :String?
    var University_Ref_ID :String?
    var Pin_Long :String?
    var Pin_Lat :String?
    var Name :String?
    var Description :String?
    var Picture_Summer_ID :String?
    var Picture_Winter_ID :String?
    var Picture_Spring_ID :String?
    
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with pin parameters
    
    init(Pin_ID: String, University_Ref_ID: String, Pin_Long: String, Pin_Lat: String, Name: String, password: String, Description: String, Picture_Summer_ID: String, Picture_Winter_ID: String, Picture_Spring_ID: String) {
        
        self.Pin_ID = Pin_ID
        self.University_Ref_ID = University_Ref_ID
        self.Pin_Long = Pin_Long
        self.Pin_Lat = Pin_Lat
        self.Name = Name
        self.Description = Description
        self.Picture_Summer_ID = Picture_Summer_ID
        self.Picture_Winter_ID = Picture_Winter_ID
        self.Picture_Spring_ID = Picture_Spring_ID
        
        
    }
    
    
    //prints the pins properties
    
    override var description: String {
        return "Pin_ID: \(String(describing: Pin_ID)), University_Ref_ID: \(String(describing: University_Ref_ID)), Pin_Long: \(String(describing: Pin_Long)), Pin_Lat: \(String(describing: Pin_Lat)), Name: \(String(describing: Name)), Description: \(String(describing: Description)), Picture_Summer_ID: \(String(describing: Picture_Summer_ID)), Picture_Winter_ID: \(String(describing: Picture_Winter_ID)), Picture_Spring_ID: \(String(describing: Picture_Spring_ID))"
        
    }
    
}
