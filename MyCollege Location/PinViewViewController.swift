//
// PinViewViewController.swift
// MyCollege Location
//
// Created by Zachary Denny on 3/8/19.
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

import Foundation
import FirebaseStorage
import Firebase
import UIKit
import MapKit

public var pinTitle:String = "Error"
public var pinDescription:String = "Error getting description"
public var pinImage: UIImage = UIImage()
public var pinIndex: Int = -1
public var publicPinURL:String = ""


protocol PinViewViewControllerDelegate{
    
    
    //func didSelectColor(controller:PinViewViewController,text:String)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}





class PinViewViewController: UIViewController, MKMapViewDelegate{

    
    static let shared = PinViewViewController()
    
    public static let pictureHanlderBlock: (Bool, String) -> Void = { doneWork, passed  in
        if doneWork {
            publicPinURL = passed
            //PinViewViewController.shared.setpicture(passedURL: passed)
            
            print("picture url ready to use")
            //PinViewViewController.shared.setpicture(passedURL: passed)
        }
    }
   
    @IBOutlet weak var lblPinTitle: UILabel!
    @IBOutlet weak var imagePinImage: UIImageView!
    @IBOutlet weak var txtPinDescription: UITextView!
    
    
    
    
    
    var PinURL:String = ""
    
    var filename = ""
    
    var imageReference: StorageReference {
        return Storage.storage().reference().child("images/")
    }
    
    
    var delegate:PinViewViewControllerDelegate! = nil
    
    //var viaSegue = MKAnnotationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Make image view have rounded corners
        self.imagePinImage.layer.masksToBounds = true;
        self.imagePinImage.layer.cornerRadius = 8;
       
        usleep(useconds_t(100000.1)) //will sleep for database to load
        
        print(publicPinURL)
        
        
        
        
        self.filename = publicPinURL//"17ADE8B4-6CA8-4B6F-AE34-37E17541E781.jpg"//self.txtImageID.text!
            let downloadImageRef = self.imageReference.child(self.filename)
//        Storage.storage().reference(forURL: filename)
        let downloadtask = downloadImageRef.getData(maxSize: 1024 * 1024 * 12) { (data, error) in
            if let error = error {
                // Handle any errors
                print(error ?? "NO ERROR")
            } else if let data = data {
                // Get the download URL for 'images/stars.jpg'
                let image = UIImage(data: data)
                self.imagePinImage?.image = image
            }
            
            }
//            if let data = data {
//
//                let image = UIImage(data: data)
//                self.imagePinImage?.image = image
//
//            }
//            print(error ?? "NO ERROR")


       
        downloadtask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "NO MORE PROGRESS")

        }

        downloadtask.resume()

        
        //URL for the image retreavied from the image array
        let url = URL(string: publicPinURL)!
        
//        //download image as data and then return as converted UIImage. if error, return empty image
//        print("Download Started")
//        let data = try? Data(contentsOf: url)
//        print("Download Finished")
//        let testimage = UIImage(data: data!)
//
//
//
//        imagePinImage.image = testimage
        
        
        //set all UI Values
        lblPinTitle.text = pinTitle
        //imagePinImage.image = pinImage
        txtPinDescription.text = pinDescription
        
       
    }
    
    //method to transfer the selected pins details
    func transferPinData(passedTitle: String, passedDescription: String, passedImage: UIImage, passedIndex: Int)  {
        
        //set the local variables values
        pinTitle = passedTitle
        pinDescription = passedDescription
        pinImage = passedImage
        pinIndex = passedIndex
        
    }
    
    
    
//    public func prepare(segue: UIStoryboardSegue, sender: Any?){
//        
//        
//        
//        
//    }

    
    @IBAction func BackButton_Click(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func setpicture(passedURL: String){
        
        //URL for the image retreavied from the image array
        let url = URL(string: "http://www.denny-homes-server.com/MyCollegeApp/DBPinImages/Tests/OUClockSpring.jpg")!
        
        //download image as data and then return as converted UIImage. if error, return empty image
        print("Download Started")
        let data = try? Data(contentsOf: url)
        print("Download Finished")
        let testimage = UIImage(data: data!)
        
        //viewDidLoad()
        
        //imagePinImage.image! = testimage!
       
        
    }
    
    
    
    



}
