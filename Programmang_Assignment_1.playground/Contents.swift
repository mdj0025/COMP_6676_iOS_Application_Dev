import UIKit

func payment(loanAmount: Int, numPayments: Int, interestRate: Float) -> Float{
    var denominator : Float = 0.0
    for index in 1...numPayments
    {
        let summation : Float = pow(1.0 + interestRate, Float(index))
        denominator += 1.0/summation
    }
    let payment = Float(loanAmount)/denominator
    return payment
}

let example1 : String = "Payment for 72 month loan of $20,000, 4.4% APR, compounded monthly = "
let example2 : String = "Payment for 30 year loan of $150,000, 5% APR, one annual payment each year for 30 years = "

print(example1 + String(payment(loanAmount: 20000, numPayments: 72, interestRate: 0.044/12)))
print(example2 + String(payment(loanAmount: 150000, numPayments: 30, interestRate: 0.05)))
