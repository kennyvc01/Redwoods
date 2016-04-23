//
//  TestViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 4/21/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBAction func btnSubmit(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "RootViewController", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("someViewController") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
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
