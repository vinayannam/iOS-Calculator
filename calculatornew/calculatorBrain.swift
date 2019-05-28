//
//  calculatorBrain.swift
//  calculatornew
//
//  Created by A.S.D.Vinay on 28/10/16.
//  Copyright © 2016 A.S.D.Vinay. All rights reserved.
//

import Foundation

class calculatorBrain{
    
    private var accumulator = 0.0
    private var internalProgram = [AnyObject]()
    
    func setOperand(operand:Double){
        
        accumulator = operand
        internalProgram.append(operand as AnyObject)
    }
    private var operations : Dictionary<String,Operation>=[
    "∏" : Operation.Constant(M_PI),
    "e" : Operation.Constant(M_E),
    "√" : Operation.UnaryOperation(sqrt),
    "cos" : Operation.UnaryOperation(cos),
    "×" : Operation.BinaryOperation({$0*$1}),
    "÷" : Operation.BinaryOperation({$0/$1}),
    "+" : Operation.BinaryOperation({$0+$1}),
    "-" : Operation.BinaryOperation({$0-$1}),
    "=" : Operation.Equals
    ]
   private enum Operation{
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double,Double)->Double)
        case Equals
    }
    
    private struct pendingBinaryOperationInfo {
        var binaryFunction:(Double,Double)->Double
        var firstOperand:Double
    }
    func performOperation(symbol:String){
        internalProgram.append(symbol as AnyObject)
        if let operation = operations[symbol]{
            switch operation{
            case.Constant(let associatedConstantValue):accumulator = associatedConstantValue
            case.UnaryOperation(let associatedFunctionValue):accumulator = associatedFunctionValue(accumulator)
            case.BinaryOperation(let associatedFunctionValue):
                executePendingOperation()
                pending = pendingBinaryOperationInfo(binaryFunction:associatedFunctionValue,firstOperand:accumulator)
            case.Equals:
                executePendingOperation()
            }
          }
        }
    private func executePendingOperation()
    {
    if pending != nil{
    accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
    pending = nil
    }
    }
    typealias PropertyList = AnyObject
    var program:PropertyList{
        get{
            return internalProgram as calculatorBrain.PropertyList
        }
        set{
            clear()
            if let arrayOps = newValue as? [AnyObject]{
                for op in arrayOps{
                    if let operand = op as? Double{
                        setOperand(operand: operand)
                    }else if let Operation = op as? String{
                        performOperation(symbol: Operation )
                        
                    }
                }
            }
            
        }
    }
    func clear(){
        accumulator = 0.0
        pending = nil
        internalProgram.removeAll()
        
    }
    private var pending:pendingBinaryOperationInfo?
    
    var result:Double{
        
        get{
            
            return accumulator
        }
        
    }
}
    



