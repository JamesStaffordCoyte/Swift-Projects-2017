//
//  ViewController.swift
//  Segues, TableViews, and AutoLayout
//
//  Created by James Stafford on 2017-06-16.
//  Copyright © 2017 James Stafford-Coyte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    
    var loginModel: LoginModel = LoginModel()
    
  
    @IBAction func signUpButton(_ sender: UIButton) {
        
        loginModel.username = usernameTF.text!
        let username = loginModel.username!
        print("\(username)")
        
        performSegue(withIdentifier: "welcomeSegue", sender: username)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WelcomeViewController {
            if let username = sender as? String {
                destination.username = username
            }
        }
    }
    
    


}

