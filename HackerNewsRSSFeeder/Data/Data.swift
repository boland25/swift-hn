//
//  Data.swift
//  HackerNewsRSSFeeder
//
//  Created by boland on 8/9/14.
//  Copyright (c) 2014 Prolific Interactive. All rights reserved.
//

import UIKit

class Data: NSObject {
 
    let GET = "GET"
    let POST = "POST"
    let PUT = "PUT"
    let DELETE = "DELETE"
    
    var xmlParserDelegate:HNXMLParserDelegate!;
    
    class func shared()->Data {
        struct Static{
            static let s_data = Data()
        }
        return Static.s_data;
    }
    
    func getFeeds(success: ((NSArray!) -> Void)!, failure: ((Error!) -> Void)!) {
        
        Networking.shared().apiRequest(HackerConstants.shared().pathFeeds,
            params: nil,
            method: GET,
            success: {(response: AnyObject!) -> Void in
                
                var xmlParser:NSXMLParser = response as NSXMLParser;
                xmlParser.shouldProcessNamespaces = true;
                
                xmlParser.delegate = self.getXmlParser();
                self.xmlParserDelegate.successBlock = success
                
                xmlParser.parse();
            
            }, failure: {(error: Error!) -> Void in
                failure(error)
        })
    }
    
    func getDetails(rssItem:RSSItem, success:  ((NSArray!) -> Void)!, failure: ((Error!) -> Void)! ) {
        Networking.shared().apiRequest(rssItem.link,
            params:nil,
            method: GET,
            success: {(response: AnyObject!) -> Void in
                println("response \(response)")
                
            }, failure: {(error:Error!) -> Void in
                failure(error)
        })
    }
    
    func getXmlParser()->HNXMLParserDelegate {
        if (!self.xmlParserDelegate) {
            self.xmlParserDelegate = HNXMLParserDelegate()
        }
        return self.xmlParserDelegate;
    }

    

}
