//
//  LaunchViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 2/18/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import Moya
import Moya_ObjectMapper

class LaunchViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageViewController:  UIPageViewController!
    let pages = ["LaunchViewControllerOne","LaunchViewControllerTwo","LaunchViewControllerThree"]

    
    let provider = MoyaProvider<Redwoods>(plugins: [CredentialsPlugin { _ -> NSURLCredential? in
        return NSURLCredential(
            user: KeychainWrapper.stringForKey("username")!,
            password: KeychainWrapper.stringForKey("password")!,
            persistence: .None
        )
        }])
    var error: ErrorType? {
        didSet {
            print(error)
        }
    }
    var profile: [Profile] = []
    
    var portfolio: [Portfolio] {
        var _Portfolio = [Portfolio]()
        for profile in self.profile {
            _Portfolio.appendContentsOf(profile.portfolio.map({ (_profile) -> Portfolio in
                _profile.profile = profile
                return _profile
            }))
        }
        return _Portfolio
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (KeychainWrapper.stringForKey("username") != nil){
            provider.requestArray(.Profile, succeed: { (profiles: [Profile]) in
                self.profile = profiles
                print("success")
                self.performSegueWithIdentifier("Segue", sender: self)
            }) { (error) in
                self.error = error
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
        } else {  //if keychain is nil
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
    
//    override func viewDidAppear(animated: Bool) {
//  
//    }
//    
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
    func viewcontrollerAtIndex(index: Int) -> UIViewController?
    {
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

    


