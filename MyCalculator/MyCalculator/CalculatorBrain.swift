//
//  CalculatorBrain.swift
//  MyCalculator
//
//  Created by Ahmet Engin Gökçe on 5.01.2022.
//

import Foundation

class CalculatorBrain {
    
    var accumulator: Double = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(Double.pi),
        "√" : Operation.UnaryOperation(sqrt),
        "x" : Operation.BinaryOperation({ op1, op2 in return op1 * op2}),
        "=" : Operation.Equals,
        "+" : Operation.BinaryOperation({ op1, op2 in return op1 + op2}),
        "-" : Operation.BinaryOperation({ op1, op2 in return op1 - op2}),
        "/" : Operation.BinaryOperation({ op1, op2 in return op1 / op2}),
        "AC": Operation.Clear,
        "e" : Operation.Constant(M_E),
        "%" : Operation.UnaryOperation({ $0 / 100 })
    ]
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        case Clear
    }
    
    var pending: PendingBinaryOperationsInfo?
    
    struct PendingBinaryOperationsInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private func setClear() {
        accumulator = 0.0
        pending = nil
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationsInfo(binaryFunction: function, firstOperand: accumulator)
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .Equals: executePendingBinaryOperation()
            case .Clear:
                setClear()
            }
        }
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
