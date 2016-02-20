//
//  LaunchViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 2/18/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageViewController:  UIPageViewController!
    let pages = ["LaunchViewControllerOne","LaunchViewControllerTwo","LaunchViewControllerThree"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add child view controller to parent page view controller
        
        if let vc = storyboard?.instantiateViewControllerWithIdentifier("LaunchPageViewController"){
            self.addChildViewController(vc)
            self.view.addSubview(vc.view)
            
            pageViewController = vc as! UIPageViewController
            
            //configure data source and delegate
            
            pageViewController.dataSource = self
            pageViewController.delegate = self
            
            //set at index 0 of pages array - uses viewcontrollerAtIndex method below
            pageViewController.setViewControllers([viewcontrollerAtIndex(0)!], direction: .Forward, animated: true, completion: nil)
            pageViewController.didMoveToParentViewController(self)
            
            
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

    

