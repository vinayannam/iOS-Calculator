//
//  ViewController.swift
//  calculatornew
//
//  Created by A.S.D.Vinay on 28/10/16.
//  Copyright © 2016 A.S.D.Vinay. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    
    
    private var userIsInTheMiddleOfTyping = false
    
    @IBOutlet private weak var display: UILabel!
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping{
            
            let testCurrentlyInDispaly = display.text!
            
            display.text = testCurrentlyInDispaly+digit
            
        }
            
        else
            
        {
            
            display.text = digit
            
        }
        
        userIsInTheMiddleOfTyping = true
        
    }
    
    private var displayValue : Double {
        
        get{
            
            return Double(display.text!)!
            
        }
        
        set{
            
            display.text = String(newValue)
            
        }
        
    }
    
    private var brain = calculatorBrain()
    
    var savedProgram: calculatorBrain.PropertyList?
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    @IBAction func restore() {
        if savedProgram != nil{
            brain.program = savedProgram!
            displayValue = brain.result 
        }
    }
    
    @IBAction private func performOpration(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping{
            
            brain.setOperand(operand: displayValue)
            
            userIsInTheMiddleOfTyping = false 
            
        }
        
        if let mathematicalSymbol = sender.currentTitle{
            
            brain.performOperation(symbol: mathematicalSymbol)
            
        }
        
        displayValue = brain.result
        
    }
    
}



