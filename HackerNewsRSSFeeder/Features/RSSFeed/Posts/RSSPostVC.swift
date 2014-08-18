//
//  RSSPostVC.swift
//  HackerNewsRSSFeeder
//
//  Created by boland on 8/9/14.
//  Copyright (c) 2014 Prolific Interactive. All rights reserved.
//

import UIKit

class RSSPostVC: UIViewController {

    var detailItem: RSSItem = RSSItem() {
        didSet {
            // TODO: add anything in here that would need to happen when data is set.  NOTE: can't load anything view related because the view does not yet exist, ask me how i realized that one?
        }
    }
    @IBOutlet weak var linkURL: UILabel!;
    @IBOutlet weak var commentView: UIWebView!;

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()

    }
    
    func configureView() {
        self.layoutDetails()
    }

    func layoutDetails() {
       self.title =  self.detailItem.title
        println("\(self.linkURL) detail item \(self.detailItem)")
        self.linkURL.text = self.detailItem.link
        self.setCommentsWithLink(self.detailItem.comments!)
    }
    
    func setCommentsWithLink(linkURL:String)->Void {
        Data.shared().getComments(linkURL, success: { (htmlString) -> Void in
            //HTML turned into string
            }, failure: {(error:Error )->Void in
                
        })
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
