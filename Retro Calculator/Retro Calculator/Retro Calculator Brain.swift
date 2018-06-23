//
//  Retro Calculator Brain.swift
//  Retro Calculator
//
//  Created by James Stafford on 2017-06-12.
//  Copyright © 2017 James Stafford-Coyte. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    
    private var accumulator: Double?
    
    enum Operations{
        case binaryOperations((Double, Double) -> Double)
        case equals
    }
    
    var operations: Dictionary<String, Operations> = [
        "-": Operations.binaryOperations({$0 - $1}),
        "/": Operations.binaryOperations({$0 / $1}),
        "*": Operations.binaryOperations({$0 * $1}),
        "+": Operations.binaryOperations({$0 + $1}),
        "=": Operations.equals
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .binaryOperations(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performBinaryOperation()
            }
        }
    }
    
    private mutating func performBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    var pendingBinaryOperation: PendingBinaryOperation?
    
    struct PendingBinaryOperation {
        var function: (Double, Double) -> Double
        var firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
        
    }
    
    mutating func setOperand(_ operand: Double) -> Double {
        accumulator = operand
        return operand
    }
        
        
    var result: Double? {
        return accumulator
    }
        
}
