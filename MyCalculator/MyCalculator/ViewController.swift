//
//  ViewController.swift
//  MyCalculator
//
//  Created by Ahmet Engin Gökçe on 5.01.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblResult: UILabel!
    
    var isTyping = false
    var brain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnDigitTapped(_ sender: UIButton) {
        let digit = sender.tag
        if isTyping {
            let resultInDisplay = lblResult.text!
            lblResult.text = resultInDisplay + String(digit)
        } else {
            lblResult.text = String(digit)
        }
        isTyping = true
    }
    
    var resultValue: Double {
        get {
            return Double(lblResult.text!)!
        }
        set {
            lblResult.text = String(newValue)
        }
    }
    
    @IBAction func btnMathOperationTapped(_ sender: UIButton) {
        if isTyping {
            brain.setOperand(operand: resultValue)
            isTyping = false
        }
        if let mathSymbol = sender.titleLabel?.text {
            brain.performOperation(symbol: mathSymbol)
        }
        resultValue = brain.result
    }
    
}

