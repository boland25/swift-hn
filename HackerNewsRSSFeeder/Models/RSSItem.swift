//
//  RSSItem.swift
//  HackerNewsRSSFeeder
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Prolific Interactive. All rights reserved.
//

import Foundation

class RSSItem: HNModel {
    var title:String?;
    var link:String?;
    var hnDescription:String?
    var comments:String?;
    

    override class func JSONKeyPathsByPropertyKey() -> NSDictionary!  {
        return ["title":"title",
                "link":"link",
                "comments":"comments",
                "hnDescription":"description"]
    }
}


