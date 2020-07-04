//
//  ContentView.swift
//  EMI Calculator
//
//  Created by Ashish Kumar on 17/04/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingNextView = false
    @State private var loanAmountSliderValue: Double = 0
    @State private var interestRateSliderValue: Double = 0
    @State private var tenureSliderValue: Double = 0
    @State private var defaultTab = 0
    @State private var defaultTenureTab = 0
    @State var resultEMIValue = 0.0
    private var tenureTabs = ["Yr","Mo"]
    private var segmentedTabs  = ["Personal Loan","Home Loan","Vehicle Loan"]
    
    var calculatorLogic = CalculatorLogic()
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("calculate_background").resizable().edgesIgnoringSafeArea(.all)
                
                VStack{
                    
                    Picker("Hey this is a message", selection: $defaultTab) {
                        ForEach(0..<segmentedTabs.count) { (index) in
                            Text(self.segmentedTabs[index]).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal)
                    
                    Spacer()
                    
                    VStack {
                        HStack{
                            Text("Loan Amount:").fontWeight(.semibold)
                            Spacer()
                            Text("\(String(format: "%.1f", loanAmountSliderValue))L")
                        }.padding()
                        
                        HStack {
                            Text("1")
                            Slider(value: $loanAmountSliderValue, in: 1...100)
                            Text("100")
                        }.padding()
                    }
                    
                    VStack {
                        HStack{
                            Text("Interest Rate:").fontWeight(.semibold)
                            Spacer()
                            Text("\(String(format: "%.1f", interestRateSliderValue))%")
                        }.padding()
                        
                        HStack {
                            Text("1")
                            Slider(value: $interestRateSliderValue, in: 1...100)
                            Text("100")
                        }.padding()
                    }
                    
                    
                    VStack {
                        HStack{
                            Text("Loan Tenure:").fontWeight(.semibold)
                            Picker("", selection: $defaultTenureTab) {
                                ForEach(0..<tenureTabs.count) { tab in
                                    Text(self.tenureTabs[tab]).tag(tab)
                                }
                            }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal)
                            Text("\(String(format: "%.1f", tenureSliderValue.rounded()))")
                        }.padding()
                        
                        HStack {
                            Text("1")
                            if defaultTenureTab == 0{
                            Slider(value: $tenureSliderValue, in: 1...10)
                            Text("10")
                            }else{
                            Slider(value: $tenureSliderValue, in: 1...99)
                            Text("99")
                            }
                            
                        }.padding()
                    }
                    
                    HStack{
                        
                        Button(action: {
                            self.interestRateSliderValue = 0
                            self.tenureSliderValue = 0
                            self.loanAmountSliderValue = 0
                        }) {
                            Text("Reset")
                                .font(.system(size: 25))
                                .fontWeight(.heavy)
                                .foregroundColor(.blue)
                                .padding(.horizontal)
                        }
                        
                        
                        Button(action: {
                            self.resultEMIValue = self.calculatorLogic.calculate(loanAmount: self.loanAmountSliderValue.rounded(), interest: self.interestRateSliderValue.rounded(), tenure: self.tenureSliderValue.rounded())
                            print(self.resultEMIValue)
                            self.showingNextView.toggle()
                        }) {
                                Text("Calculate")
                                .font(.system(size: 25))
                                .fontWeight(.heavy)
                                .foregroundColor(.blue)
                                .padding(.horizontal)
                        }
                        .sheet(isPresented: $showingNextView) {
                            EMIDetailView(resultEMIValue: self.resultEMIValue, totalLoanAmount: (self.loanAmountSliderValue.rounded() * 100000) , totalTenure: self.tenureSliderValue.rounded())
                        }
                    }
                }
            }.navigationBarTitle("EMI Calculator")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
