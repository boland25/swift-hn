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
                    
                    //NOTE: if there is no internet connection there will be nothing here, so need to fix this as its expecitng a dict to be there
                    var aError:Error?;
                    if (responseObject) {
                        let errorDict: NSDictionary! = responseObject!["error"] as NSDictionary
                        println("errorDict: \(errorDict)")
                        aError = Error.modelWithDictionary(errorDict, error: nil)
                    } else {
                        var emptyDict = NSDictionary();
                         aError = Error.modelWithDictionary(emptyDict, error: nil)
                    }
                    
                    
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
    
    func apiAbsolutePathRequest(fullPath:String, params:NSDictionary?, method:String,  success: ((response:AnyObject) -> Void), failure: ((error:Error) -> Void)) {
        var manager:AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer();
        manager.GET(fullPath, parameters:params, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
            println("getting comments back as html string here")
            if (success != nil) {
                success (response: responseObject)
            }
            }, failure: { (operation :AFHTTPRequestOperation!, error:NSError! )->Void in
                
        })
    }
    

}
