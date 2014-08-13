//
//  Networking.swift
//  HackerNewsRSSFeeder
//
//  Created by boland on 8/9/14.
//  Copyright (c) 2014 Prolific Interactive. All rights reserved.
//

import Foundation

class Networking: NSObject {
    
    var manager = AFHTTPSessionManager(baseURL: NSURL(string: HackerConstants.shared().baseURL))

    class func shared()->Networking{
        struct Static {
            static let s_networking = Networking();
        }
        return Static.s_networking;
    }
    
    func apiRequest(path:String!, params:NSDictionary?, method:String!, success: ((AnyObject!) -> Void)!, failure: ((Error!) -> Void)!)
    {
        self.manager.requestSerializer = AFJSONRequestSerializer()
        //self.manager.responseSerializer = AFJSONResponseSerializer()
        self.manager.responseSerializer = AFXMLParserResponseSerializer()
        var rssSet = NSMutableSet()
        rssSet.addObject("application/rss+xml")
        self.manager.responseSerializer.acceptableContentTypes = rssSet
        
        var request : NSMutableURLRequest = manager.requestSerializer.requestWithMethod(method, URLString: NSURL(string: path, relativeToURL: self.manager.baseURL).absoluteString, parameters: params, error: nil)
        
        println("request: \(request)")
        
        manager.dataTaskWithRequest(request, completionHandler: {(response : NSURLResponse!, responseObject : AnyObject!, error : NSError!) -> Void in
            
            if (error != nil) {
                if failure {
                    println("Response(failure): \(responseObject)")
                    
                    let errorDict: NSDictionary! = responseObject!["error"] as NSDictionary
                    println("errorDict: \(errorDict)")
                    var aError : Error? = Error.modelWithDictionary(errorDict, error: nil)
                    failure(aError)
                }
            }
            else {
                if (success != nil) {
                    println("Response(success): \(responseObject)")

                    success (responseObject)
                }
            }
            
            
        }).resume()
    }

}
