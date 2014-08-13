//
//  RSSItemTC.swift
//  HackerNewsRSSFeeder
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Prolific Interactive. All rights reserved.
//

import UIKit

class RSSItemTC: UITableViewCell {
    
    @IBOutlet var titleLabel:UILabel!
    
    func layoutWithItem(item:RSSItem) {
        //todo: layout the title, and description of the post in the cell
        self.titleLabel.text =  item.title
    }

}
