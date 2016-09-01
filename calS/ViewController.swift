//
//  ViewController.swift
//  calS
//
//  Created by Theo WU on 12/07/2016.
//  Copyright © 2016 Theo WU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTypingANumber = false
    var displayValue: Double {
        get {
            return (display.text! as NSString).doubleValue
        }
        set {
            display.text = "\(newValue)"
        }
    }
    let calculator = CalculatorBrain()

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func enter() {
        calculator.pushOperand(displayValue)
        userIsInTheMiddleOfTypingANumber = false
    }
    
    @IBAction func reset() {
        display.text = "0"
        calculator.reset()
        userIsInTheMiddleOfTypingANumber = false
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        calculator.performOperation(operation)
        if let result = calculator.evaluate() {
            displayValue = result
        }
        enter()
    }
}

