//
//  TransactionViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 2/16/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {
    
    var TransactionLabel1 = ""
    var TransactionLabel2 = ""
    var TransactionLabel3 = ""

    @IBOutlet weak var LblTransactionLabel1: UILabel!
    @IBOutlet weak var LblTransactionLabel2: UILabel!
    @IBOutlet weak var LblTransactionLabel3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.LblTransactionLabel1.text = TransactionLabel1
        self.LblTransactionLabel2.text = TransactionLabel2
        self.LblTransactionLabel3.text = TransactionLabel3
        
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
