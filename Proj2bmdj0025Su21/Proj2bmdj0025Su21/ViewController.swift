//
//  ViewController.swift
//  Proj2bmdj0025Su21
//
//  Created by Michael Johnson on 6/8/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loan_amount_txt: UITextField!
    @IBOutlet weak var payment_periods_txt: UITextField!
    @IBOutlet weak var interest_rate_txt: UITextField!
    @IBOutlet weak var payment_amount_label: UILabel!
    @IBOutlet weak var payment_amount_value_label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculate_button_action(_ sender: Any) {
        let loanAmount: Float = Float(loan_amount_txt.text!)!
        let numPayments: Int = Int(payment_periods_txt.text!)!
        let interestRate: Float = Float(interest_rate_txt.text!)!
        let amount = payment(loanAmount: loanAmount, numPayments: numPayments, interestRate: interestRate)
        payment_amount_value_label.text = String(amount)
    }
    
    func payment(loanAmount: Float, numPayments: Int, interestRate: Float) -> Float{
        var denominator : Float = 0.0
        for index in 1...numPayments
        {
            let summation : Float = pow(1.0 + interestRate, Float(index))
            denominator += 1.0/summation
        }
        let payment = loanAmount/denominator
        return payment
    }
}

