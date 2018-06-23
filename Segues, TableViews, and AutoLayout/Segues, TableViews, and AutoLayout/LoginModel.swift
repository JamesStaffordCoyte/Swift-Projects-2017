//
//  LoginModel.swift
//  Segues, TableViews, and AutoLayout
//
//  Created by James Stafford on 2017-06-18.
//  Copyright © 2017 James Stafford-Coyte. All rights reserved.
//

import Foundation

struct LoginModel {
    
    private var _username: String? = ""
    
    var username: String? {
        get {
            return _username
  
        }  set{
            _username = newValue
        }
    }
    
    
    
}
