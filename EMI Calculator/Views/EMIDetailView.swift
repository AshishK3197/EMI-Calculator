//
//  EMIDetailView.swift
//  EMI Calculator
//
//  Created by Ashish Kumar on 22/04/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct EMIDetailView: View {
    @Environment(\.presentationMode) private var presentationMode
    var resultEMIValue : Double?
    var totalLoanAmount : Double?
    var totalTenure : Double?
    
    var body: some View {
        ZStack{
            Image("calculate_background").resizable().edgesIgnoringSafeArea(.all)
            VStack{
                PieChartView(data: [(resultEMIValue! * totalTenure!).rounded() - totalLoanAmount!.rounded() ,totalLoanAmount! ], title: "BreakUp of Total Payment", style: Styles.pieChartStyleOne , dropShadow: true).padding(.all)
                
                HStack{
                    Text("Your Monthly EMI:").fontWeight(.medium)
                    Spacer()
                    Text((String(format: "%.2f", resultEMIValue!.rounded())))
                }.padding()
                
                HStack{
                    Text("Total Interest Payble: " ).fontWeight(.medium)
                    Spacer()
                    Text(String(format: "%.2f", (resultEMIValue! * totalTenure!).rounded() - totalLoanAmount!.rounded()))
                }.padding()
                
                HStack{
                    VStack{
                        Text("Total Payble Amount:" ).fontWeight(.medium)
                        Text("(Principal + Interest)").fontWeight(.medium)
                    }
                    Spacer()
                    Text(String(format: "%.2f", (resultEMIValue! * totalTenure!).rounded()))
                }.padding()
                
                Spacer()
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Text("Recalculate")
                    }.padding(10.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 2.0)
                    )
                }
            }
        }
    }
}

struct EMIDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EMIDetailView()
    }
}
