//
//  ViewController.swift
//  Retro Calculator
//
//  Created by James Stafford on 2017-06-12.
//  Copyright © 2017 James Stafford-Coyte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var display: UILabel!
    
    var userIsTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = "\(sender.tag)"
        if userIsTyping {
            var textInDisplay = display.text!
            display.text = textInDisplay + digit
        } else {
            display.text = digit
            userIsTyping = true
        }
    }
    
    var displayResult: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text! = String(newValue)
        }
    }
    
    var brain: CalculatorBrain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        brain.setOperand(displayResult)
        userIsTyping = false
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            displayResult = result
        }
    }
    


}

