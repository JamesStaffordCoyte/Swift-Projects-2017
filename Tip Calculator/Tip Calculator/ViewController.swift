//
//  ViewController.swift
//  Calculator2
//
//  Created by James Stafford on 2017-06-01.
//  Copyright © 2017 James Stafford-Coyte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Outlet
    @IBOutlet weak var display: UILabel!
    //Boolean to make sure when a value is tapped the calculator display is updated accordingly
    var userIsTyping: Bool = false
    //Method for when the digits are tapped
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        let textInDisplay = display.text!
        if userIsTyping {
            display.text! = textInDisplay + digit
            if textInDisplay.contains(".") && digit.contains(".")  {
                display.text = textInDisplay
            }
        } else {
            if digit.contains(".") {
                display.text = "0."
            } else {
                display.text = digit
            }
            userIsTyping = true
        }
    }
    // display is returned as a double and set as a string
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text! = String(newValue)
            if display.text!.contains(".0") {
                display.text!.append("0")
            }
        }
    }
    //Instance of CalculatorBrain
    private var brain = ComputerBrain()
    //Operation button is tapped
    @IBAction func performAction(_ sender: UIButton) {
        if userIsTyping {
            brain.setOperand(displayValue)//operand is set to the display value as a double
            userIsTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)//the symbol tapped is passed to the model
        }
        if let result = brain.result {
            displayValue = result//the display value is set to the result calculated in the model and set to a string by the computed property display Value
        }
    }
}

