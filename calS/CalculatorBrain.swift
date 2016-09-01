//
//  CalculatorBrain.swift
//  calS
//
//  Created by Theo WU on 14/07/2016.
//  Copyright © 2016 Theo WU. All rights reserved.
//

import Foundation

class CalculatorBrain {
    private enum Op {
        case Operand(Double)
        case BinaryOperation(String, (Double,Double)->Double)
        case UnaryOeration(String, Double->Double)
    }
    
    private var opStack = Array<Op>()
    private var knownOps = Dictionary<String,Op>()
    
    init(){
        knownOps["+"]=Op.BinaryOperation("+", +)
        knownOps["−"]=Op.BinaryOperation("−", {$1-$0})
        knownOps["×"]=Op.BinaryOperation("×", *)
        knownOps["÷"]=Op.BinaryOperation("÷", {+$1/$0})

    }
    
    private func evaluate(ops:Array<Op>) -> (result:Double?,remainingOps:Array<Op>){
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOeration(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let op1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let op2 = op2Evaluation.result {
                        return (operation(op1,op2), op2Evaluation.remainingOps)
                    }
                }
            }
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, _) = evaluate(opStack)
        return result
    }
    
    func pushOperand(operand:Double) {
        opStack.append(Op.Operand(operand))
        var test = opStack
        print(test.removeLast())
    }
    
    func performOperation(symbol:String){
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
    }
    
    func reset(){
        opStack = Array<Op>()
    }
}