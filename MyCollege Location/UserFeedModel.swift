//
// UserFeedModel.swift
// MyCollege Pin Tool
//
// Created by Zachary Denny on 3/29/19.
// Updated by Zachary Denny on 3/29/19.
// Copyright © 2019 Denny Homes. All rights reserved.
//
//
// ================================================================
//  MyCollege Pin Tool
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


protocol UserFeedModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}


class UserFeedModel: NSObject, URLSessionDataDelegate {
    
    static let shared = UserFeedModel()
   
    weak var delegate: UserFeedModelProtocol!
    
    
    
    //Call to download pictures from database
    func downloadItems(passedUsername: String, passedPassword: String)  {
        
        //url path of php script
        var urlPath = "http://www.denny-homes-server.com/MyCollegeApp/GetLogin.php?Username="
        
        let group = DispatchGroup()
        group.enter()
        
        var appendString = ("%22\((passedUsername))%22&Password=%22\((passedPassword))%22")
        appendString = appendString.replacingOccurrences(of: " ", with: "")
        
        //append passedID to url
        urlPath.append(appendString)
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        //var returnPictureURL: String = ""
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            
        
            if error != nil {
                print("Error")
            }else {
                print("Users downloaded")
                self.parseJSON(data!)
                
                group.leave()
            }
        
            
        }
        task.resume()
        group.wait()
        
       
    }
    
    func parseJSON(_ data:Data)  {
        
        var jsonResult = NSArray()
        
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        
        //Make var of pictureStruct to pass around to other methods
        var userInfo: UserStruct
        
        
        
        //Cycle though all the json results to get all picures but should only return 1
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            
            
            
            let users = NSMutableArray()
            let user = UserModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let User_ID = jsonElement["User_ID"] as? String,
                let Username = jsonElement["Username"] as? String,
                let Password = jsonElement["Password"] as? String,
                let User_Email = jsonElement["User_Email"] as? String,
                let First_Name = jsonElement["First_Name"] as? String,
                let Last_Name = jsonElement["Last_Name"] as? String,
                let University_Name = jsonElement["Name"] as? String,
                let University_ID = jsonElement["University_ID"] as? String
                
            {
                //Print picture layout for debug
                //print(" \(Picture_ID) \(Picture_Path) \(Picture_Type) ")
                //print(Picture_Path)
                
                //set the picture path url for the pin viewer
//                PinViewViewController.pictureHanlderBlock(true, Picture_Path)
//                ViewController.viewPinHanlderBlock(true, Picture_Path)
//                publicPinURL = Picture_Path
                
                
                //Puts the new picture from the database into the model
                user.User_ID = User_ID
                user.Username = Username
                user.Password = Password
                user.User_Email = User_Email
                user.First_Name = First_Name
                user.Last_Name = Last_Name
                user.University_Name = University_Name
                user.University_ID = University_ID
                
                //Set PictureInfo to data from DB
                userInfo = (UserStruct(User_ID: User_ID, Username: Username, Password: Password, User_Email: User_Email, First_Name: First_Name, Last_Name: Last_Name, University_Name: University_Name, University_ID: University_ID ))
                print(userInfo)
                
                UserManager.shared.CurrentUser =  UserStruct(User_ID: User_ID, Username: Username, Password: Password, User_Email: User_Email, First_Name: First_Name, Last_Name: Last_Name, University_Name: University_Name, University_ID: University_ID)
                print("User Found And Stored")
            }
            
            users.add(user)
            
            
            
            
        }
        
        //After all pictures are loaded from database, pass to the pin loader to load pins
//        LoadPins().setUniversityPins(passedPinArray: PinArray)
        
       
     
    }
}



