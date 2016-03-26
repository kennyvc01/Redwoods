//
//  Register3ViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 3/25/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit

class Register3ViewController: UIViewController {

    @IBAction func btnSkip(sender: AnyObject) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FeedViewController") as UIViewController
        self.presentViewController(viewController, animated: false, completion: nil)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
