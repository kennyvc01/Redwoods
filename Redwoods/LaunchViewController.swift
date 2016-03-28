//
//  LaunchViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 2/18/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import Alamofire

class LaunchViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageViewController:  UIPageViewController!
    let pages = ["LaunchViewControllerOne","LaunchViewControllerTwo","LaunchViewControllerThree"]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        
        if (KeychainWrapper.stringForKey("username") != nil){
            let user: String = KeychainWrapper.stringForKey("username")!
            let password: String = KeychainWrapper.stringForKey("password")!
            //Credentials for basic authentication using text fields for username and password
            let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
            let base64Credentials = credentialData.base64EncodedStringWithOptions([])
            let headers = ["Authorization": "Basic \(base64Credentials)"]
            //GET Method for api/profile.  If successful, open FeedViewController.  If unsuccessful, alert to reset password.
            Alamofire.request(.GET, "https://redwoods-engine-test.herokuapp.com/api/profile", headers: headers)
                .responseJSON { response in
                    
                    if let _ = response.result.error {
                        
                        //Add child view controller to parent page view controller
                        
                        if let vc = self.storyboard?.instantiateViewControllerWithIdentifier("LaunchPageViewController"){
                            self.addChildViewController(vc)
                            self.view.addSubview(vc.view)
                            
                            self.pageViewController = vc as! UIPageViewController
                            
                            //configure data source and delegate
                            
                            self.pageViewController.dataSource = self
                            self.pageViewController.delegate = self
                            
                            //set at index 0 of pages array - uses viewcontrollerAtIndex method below
                            self.pageViewController.setViewControllers([self.viewcontrollerAtIndex(0)!], direction: .Forward, animated: true, completion: nil)
                            self.pageViewController.didMoveToParentViewController(self)
                            
                            
                        }
                        
                    } else { //user is authenticated
                        let statusCode = (response.response?.statusCode)!
                        print(statusCode)
                        
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FeedViewController") as UIViewController
                        self.presentViewController(viewController, animated: false, completion: nil)
                        
                        
                        
                    }
                    
            }

        }
        else{
           
                        
                        //Add child view controller to parent page view controller
                        
                        if let vc = self.storyboard?.instantiateViewControllerWithIdentifier("LaunchPageViewController"){
                            self.addChildViewController(vc)
                            self.view.addSubview(vc.view)
                            
                            self.pageViewController = vc as! UIPageViewController
                            
                            //configure data source and delegate
                            
                            self.pageViewController.dataSource = self
                            self.pageViewController.delegate = self
                            
                            //set at index 0 of pages array - uses viewcontrollerAtIndex method below
                            self.pageViewController.setViewControllers([self.viewcontrollerAtIndex(0)!], direction: .Forward, animated: true, completion: nil)
                            self.pageViewController.didMoveToParentViewController(self)
                    
                
                
            }
        
        }
        

        
    
    }
    
    //Method for swiping left
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let index = pages.indexOf(viewController.restorationIdentifier!) {
            if index > 0 {
                return viewcontrollerAtIndex(index - 1)
            }
        }
        return nil
    }
    
    
    //method for swiping right
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let index = pages.indexOf(viewController.restorationIdentifier!) {
            if index < pages.count - 1 {
                return viewcontrollerAtIndex(index + 1)
            }
        }
        return nil
    }
    
    
    //gets the pages array index of the current view controller
    func viewcontrollerAtIndex(index: Int) -> UIViewController?{
        let vc = storyboard?.instantiateViewControllerWithIdentifier(pages[index])
        return vc
    }
    
    
    
    //total count of view controllers - used for scroll dots at the bottom of the screen
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
        
    {
        
        return self.pages.count
        
        
    }
    
    
    //index of current view controllers - used for scroll dots at the bottom of the screen
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
        
    {
        
        return 0
        
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

    


