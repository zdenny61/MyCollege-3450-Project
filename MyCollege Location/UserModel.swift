//
// UserModel.swift
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

class UserModel: NSObject {
    
    //properties of a user
    var User_ID: String?
    var Username:String?
    var Password: String?
    var User_Email: String?
    var First_Name: String?
    var Last_Name: String?
    var University_Name: String?
    var University_ID: String?
    
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with user parameters
    
    init(User_ID: String, Username: String, Password: String, User_Email: String, First_Name: String, Last_Name: String, University_Name: String, University_ID:String) {
        
        self.User_ID = User_ID
        self.Username = Username
        self.Password = Password
        self.User_Email = User_Email
        self.First_Name = First_Name
        self.Last_Name = Last_Name
        self.University_Name = University_Name
        self.University_ID = University_ID
    }
    
    
    //prints the user properties
    
    override var description: String {
        return "User_ID: \(String(describing: User_ID)), Username: \(String(describing: Username)), Password: \(String(describing: Password)), User_Email: \(String(describing: User_Email)), First_Name: \(String(describing: First_Name)), Last_Name: \(String(describing: Last_Name)), University_Name: \(String(describing: University_Name)), University_ID: \(String(describing: University_ID))"
        
    }
    
}
