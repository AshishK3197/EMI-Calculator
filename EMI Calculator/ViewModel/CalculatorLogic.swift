//
//  Calculator Logic.swift
//  EMI Calculator
//
//  Created by Ashish Kumar on 17/04/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import Foundation

struct CalculatorLogic {

        func calculate(loanAmount: Double , interest: Double , tenure: Double)->Double{
            let loanAmountRoundedValue = loanAmount.rounded()
            let inputLoanAmount = loanAmountRoundedValue * 100000

            let inputInterest = Double(String(format: "%.2f" ,(interest/12)))
            print(inputLoanAmount)
            print(inputInterest!)


            var calculatedEMI : Double = 0.0
            let calculatePower = pow(1 + (inputInterest!/100), tenure)
            calculatedEMI = (inputLoanAmount * (inputInterest!/100) * calculatePower)/(calculatePower - 1)

    //        EMI = [P x R x (1+R)^N]/[(1+R)^N-1]


            return calculatedEMI
        }

}



// .rounded() can be written more efficiently in set and get
