//
//  ComputerBrain.swift
//  Calculator2
//
//  Created by James Stafford on 2017-06-01.
//  Copyright © 2017 James Stafford-Coyte. All rights reserved.
//

import Foundation

struct ComputerBrain {
    // Properties
    private var accumulator: Double?
     // Enum containing the types of Operations available
    private enum Operations {
        case unaryOperation((Double) -> Double)
        case allClear
    }
    // Contains all the operations displayed to the user
    private var operations: Dictionary<String,Operations> = [
        "10%" : Operations.unaryOperation({$0 * 0.10}),
        "15%" : Operations.unaryOperation({$0 * 0.15}),
        "18%" : Operations.unaryOperation({$0 * 0.18}),
        "20%" : Operations.unaryOperation({$0 * 0.20}),
        "AC" : Operations.allClear
    ]
    // Takes in the symbol button tapped by user. Searches through the operations Dictionary to find the symbol, and performs the operation with the associated value attached to it
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .allClear:
                accumulator = 0
            }
        }
    }
    // Sets the accumulator property to be equal to the operand that is tapped by the user
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    // Returns the accumulator to the controller
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    
}
