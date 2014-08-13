//
//  HNViewController.swift
//  HackerNewsRSSFeeder
//
//  Created by boland on 8/11/14.
//  Copyright (c) 2014 Prolific Interactive. All rights reserved.
//

import UIKit

class HNViewController: UIViewController {

    func showError(error : Error!) {
        var alertView = UIAlertView()
        alertView.title = "Error"
        alertView.message = "\(error.message). Please re-enter your credentials and try again."
        alertView.addButtonWithTitle("Okay")
        alertView.show()
    }

}
