//
//  RSSTableViewController.swift
//  HackerNewsRSSFeeder
//
//  Created by boland on 8/9/14.
//  Copyright (c) 2014 Prolific Interactive. All rights reserved.
//

import UIKit
import Foundation

class RSSTableVC: UITableViewController {

    var feeds:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.title = "Hacker News Feed";
        self.tableView.estimatedRowHeight = 70.0;
        getFeeds()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }

    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> RSSItemTC! {
        let cell = tableView.dequeueReusableCellWithIdentifier("RSSItemCell", forIndexPath: indexPath) as RSSItemTC

        cell.layoutWithItem(feeds[indexPath.row] as RSSItem)
        return cell
    }
    
    func getFeeds () {
        
        Data.shared().getFeeds(
            {(feeds : NSArray!) in
                self.feeds = RSSItem.arrayFromJSONArray(feeds)!;
                self.tableView.reloadData()
                
            }, failure: {(error : Error!) in
                self.showError(error)
        })
    }

 // MARK: - View Segue Methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPostDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow()
            let object = self.feeds[indexPath.row] as RSSItem
            (segue.destinationViewController as RSSPostVC).detailItem = object
        }
    }

 // MARK: - Error Handling
    
    func showError(error : Error!) {
        var alertView = UIAlertView()
        alertView.title = "Error"
        alertView.message = "\(error.message). There was a problem connecting with Hacker News.  Please try again."
        alertView.addButtonWithTitle("Okay")
        alertView.show()
    }


}
