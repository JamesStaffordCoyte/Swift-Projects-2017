//
//  WelcomeViewController.swift
//  Segues, TableViews, and AutoLayout
//
//  Created by James Stafford on 2017-06-18.
//  Copyright © 2017 James Stafford-Coyte. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
  
    @IBOutlet weak var welcomeDisplay: UILabel!
    
    private var _username: String!
    
    var username: String {
        get {
            return _username
        } set {
            _username = newValue
        }
    }
    
    override func viewDidLoad() {
        welcomeDisplay.text = "Welcome \(_username!)"
    }
    
    
    
    
}
