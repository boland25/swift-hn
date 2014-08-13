//
//  HNModel.swift
//  HackerNewsRSSFeeder
//
//  Created by boland on 8/10/14.
//  Copyright (c) 2014 Prolific Interactive. All rights reserved.
//

import Foundation

class HNModel: MTLModel {
    
    
    class func JSONKeyPathsByPropertyKey() -> NSDictionary!  {
        return NSDictionary()
    }
    
    class func modelFromDictionary(JSONDictionary:NSDictionary) -> AnyObject? {
        var error:NSError?
        return MTLJSONAdapter.modelOfClass(HNModel.self, fromJSONDictionary: JSONDictionary, error: &error)
    }
    
    class func modelFromJSONDictionary(JSONDictionary:NSDictionary) -> AnyObject {
        var error:NSError?
        return MTLJSONAdapter.modelOfClass(HNModel.self, fromJSONDictionary: JSONDictionary, error: &error)
    }

    
    @objc class func arrayFromJSONArray(array:NSArray)->NSArray? {
        var valueTransformer = NSValueTransformer.mtl_JSONArrayTransformerWithModelClass(self);
        var objects:NSArray = valueTransformer.transformedValue(array) as NSArray;
        
        return objects;
    }
}