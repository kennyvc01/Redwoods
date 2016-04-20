//
//  PictureViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 4/15/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Alamofire
import SwiftyJSON

class PictureViewController: UIViewController {

    @IBOutlet weak var vwPic: UIImageView!
    @IBOutlet weak var vwPicture: UIView!
    
    var objects = [[String: String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        
        var err: NSError? = nil
        do {
            let asset = AVAsset(URL: NSURL(string: "https://s3.amazonaws.com/redwoods-stories/Running+with+a+Mission+2013.mp4")!)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            let cgImage = try imgGenerator.copyCGImageAtTime(CMTimeMake(0, 1), actualTime: nil)
            let uiImage = UIImage(CGImage: cgImage)

            let imageView = UIImageView(image: uiImage)
            imageView.bounds = self.vwPicture.frame
            self.vwPicture.addSubview(imageView)
            // lay out this image view, or if it already exists, set its image property to uiImage
        } catch let error as NSError {
            print("Error generating thumbnail: \(error)")
        }

    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        self.objects.removeAll()
        //set username and password = key chain
        let user: String = KeychainWrapper.stringForKey("username")!
        let password: String = KeychainWrapper.stringForKey("password")!
        
        //Credentials for basic authentication using text fields for username and password
        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        //GET Method for api/feed
        Alamofire.request(.GET, "https://redwoods-engine-test.herokuapp.com/api/feed", headers: headers)
            .response { (request, response, json, error) in
                //if json api/feed returns results then pars json using the parseJSON function
                if json != nil {
                    let json = JSON(data: json!)
                    self.parseJSON(json)
                }
        }
        

        
        
    }
    
    //function to parse and load JSON results in objects array as ["storyLink","storyTimestamp","description","org"]
    func parseJSON(json: JSON) {
        //loop through json results
        for result1 in json[].arrayValue {
            //loop through json results again to get stories of each org
            for result2 in result1["org"]["stories"].arrayValue{
                let org = result1["org"]["name"].stringValue
                let storyLink  = result2["link"].stringValue
                let storyTimestamp = result2["timestamp"].stringValue
                let description = result2["description"].stringValue
                let amount = result1["amount"].stringValue
                //print(storyLink)
                let obj = ["storyLink": storyLink, "storyTimestamp": storyTimestamp, "description": description, "org": org, "Amount": amount]
                objects.append(obj)
                
                
                
            }
            
            
            
            
            
            
        }
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
