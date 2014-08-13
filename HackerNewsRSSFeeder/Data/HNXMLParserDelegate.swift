//
//  HNXMLParserDelegate.swift
//  HackerNewsRSSFeeder
//
//  Created by boland on 8/10/14.
//  Copyright (c) 2014 Prolific Interactive. All rights reserved.
//

import UIKit

class HNXMLParserDelegate: NSObject, NSXMLParserDelegate {
    
    var xmlDict:NSMutableDictionary! = nil;
    var storageArray:NSMutableArray! = nil;
    //
    var elementName:NSString! = nil;
    var elementString:String! = "";
    var elementDict:NSDictionary! = nil;
    var successBlock:((NSArray!) -> Void)!;
    
    override init() {
        super.init()
        self.storageArray = NSMutableArray()
    }
    
    func parserDidStartDocument(parser: NSXMLParser!) {
        println("starting docs")
        self.xmlDict = NSMutableDictionary()
    }
    
    func parserDidEndDocument(parser: NSXMLParser!) {
        self.successBlock(self.storageArray)
    }
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
       println("STARTING PARSER " + elementName)
        self.elementName = qName;
        
        if (self.elementName == "item") {
            // TODO: go back and account for the other elements.  This will make a dict for everything, but we want to separate out non-item things
            self.elementDict = NSMutableDictionary()
        }
        self.elementString = "";
        
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        if (!self.elementName) {
            return
        }
        println("Found these chars " + string)

        self.elementString! += string
        
    }

    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        println("END OF ELEMTNS " + elementName + " " + self.elementString)
        
        if (qName == "item") {
            //this is the container for the json so put it in the array
             self.storageArray.addObject(self.elementDict)
            println("items in array \(self.storageArray)")
        } else if (qName == "channel" || qName == "rss") {
            //hmm end of the channel which means end of the line so what do i do here?
        } else {
            //NOTE:if the xml crawler is inside an item node it will place the stuff in this dict
            if (self.elementDict) {
                self.elementDict.setValue(self.elementString, forKey: self.elementName)
            }else {
                self.xmlDict.setValue(self.elementString, forKey: self.elementName)
            }
        }
        println("XML DICT \(xmlDict)");
        self.elementName = nil;
        

    }
}