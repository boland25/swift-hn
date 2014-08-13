//
//  RSSPostVC.swift
//  HackerNewsRSSFeeder
//
//  Created by boland on 8/9/14.
//  Copyright (c) 2014 Prolific Interactive. All rights reserved.
//

import UIKit

class RSSPostVC: UIViewController {

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
        NSLog("heeey it loaded")
        self.getDetails()
    }

    func getDetails() {
        Data.shared().getDetails(self.detailItem, success: { (<#NSArray!#>) -> Void in
            println("success")
        }) { (Error!) -> Void in
            println("")
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

 // MARK: - Error Handling
    
    //TODO: consolidate the error methods into an extension or base class
    func showError(error : Error!) {
        var alertView = UIAlertView()
        alertView.title = "Error"
        alertView.message = "\(error.message). There was a problem connecting with Hacker News.  Please try again."
        alertView.addButtonWithTitle("Okay")
        alertView.show()
    }

}
