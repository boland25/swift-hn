//
//  HackerConstants.swift
//  HackerNewsRSSFeeder
//
//  Created by boland on 8/9/14.
//  Copyright (c) 2014 Prolific Interactive. All rights reserved.
//

import Foundation

class HackerConstants {
    
    class func shared()->HackerConstants{
        struct Static{
            static let s_constants = HackerConstants();
        }
        return Static.s_constants;
    }
    
    // Base URLs
    let baseURL              = "https://news.ycombinator.com";
    
    // Endpoints
    let pathFeeds               = "/rss";
}
