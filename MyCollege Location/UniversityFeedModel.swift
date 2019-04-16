//
// UniversityFeedModel.swift
// MyCollege Location
//
// Created by Zachary Denny on 3/18/19.
// Updated by Zachary Denny on 3/18/19.
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


protocol UniversityFeedModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}

public var arrayAllUniversitys: [UniversityStruct] = []


class UniversityFeedModel: NSObject, URLSessionDataDelegate {
    
    static let shared = UniversityFeedModel()
    
    
    weak var delegate: UniversityFeedModelProtocol!
    
    //url path of php script
    let urlPath = "http://www.denny-homes-server.com/MyCollegeApp/GetUniversity.php" //Change to the web address of your stock_service.php file
    
    //Call to download pins from database
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Error")
            }else {
                print("University downloaded")
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
    }
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        
        //Make array of UniversityStructs to pass around to other methods
        var UniversityArray: [UniversityStruct] = []
        
        //Cycle though all the json results to get all Universitys
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            
            
            
            let Universitys = NSMutableArray()
            let University = UniversityModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let University_ID = jsonElement["University_ID"] as? String,
                let Name = jsonElement["Name"] as? String,
                let Location_Long = jsonElement["Location_Long"] as? String,
                let Location_Lat = jsonElement["Location_Lat"] as? String
                
            {
                //Print University layout for developer
                print(" \(University_ID) \(Name) \(Location_Long) \(Location_Lat) ")
                
                
                //Puts the new pin from the database into the model
                University.University_ID = University_ID
                University.Name = Name
                University.Location_Long = Location_Long
                University.Location_Long = Location_Long
                University.Location_Lat = Location_Lat
                
                //Appends the new pin from the database into the pin array
                UniversityArray.append(UniversityStruct(University_ID: University_ID, Name: Name, Location_Long: Location_Long, Location_Lat: Location_Lat))
                
                //                PinArray[i].Pin_ID = "test"
                //                PinArray[i].University_Ref_ID = University_Ref_ID
                //                PinArray[i].Pin_Long = Pin_Long
                //                PinArray[i].Pin_Lat = Pin_Lat
                //                PinArray[i].Name = Name
                //                PinArray[i].Description = Description
                //                PinArray[i].Picture_Summer_ID = Picture_Summer_ID
                //                PinArray[i].Picture_Winter_ID = Picture_Winter_ID
                //                PinArray[i].Picture_Spring_ID = Picture_Spring_ID
                
                
                
            }
            
            Universitys.add(University)
            
            
            
        }
        
        //After all pins are loaded from database, pass to the pin loader to load pins
        //LoadPins().setUniversityPins(passedPinArray: PinArray)
        arrayAllUniversitys = UniversityArray
        
       
    }
}
