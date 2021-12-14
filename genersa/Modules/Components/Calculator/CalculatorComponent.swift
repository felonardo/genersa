//
//  CalculatorView.swift
//  genersa
//
//  Created by Leo nardo on 07/11/21.
//


import SwiftUI

struct CalculatorField: View {
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    
    @Binding var finalValue: String
    @Binding var isPresented: Bool
    
    var body: some View{
        VStack(alignment: .trailing, spacing: 4) {
            Text(finalValue.toCurrency(currency))
                .font(.title3)
            
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.isPresented = true
        }
    }
}

struct CalculatorComponent: View {
    
    let rows = [
        ["1", "2", "3", "+"],
        ["4", "5", "6", "−"],
        ["7", "8", "9", "÷"],
        [".", "0", "Delete", "×"]
    ]
    
    @State var noBeingEntered: String = ""
    @State var calExpression: [String] = []
    @Binding var finalValue: String
    @Binding var isPresented: Bool
    
    var body: some View {
        
        VStack {
            VStack {
                Spacer(minLength: 16)
                VStack(spacing: 0) {
                    HStack(alignment: .center){
                        Text(flattenTheExpression(exps: calExpression))
                            .font(.headline)
                            .frame(alignment: Alignment.bottomTrailing)
                            .foregroundColor(.three)
                        Spacer()
                        Button(action: {
                            self.isPresented = false
                        }, label: { Text("Done")
                                        .bold()
                        })
                    }
                    .padding(16)
                    ForEach(rows, id: \.self) { row in
                        HStack(alignment: .top, spacing: 0) {
                            Spacer(minLength: 13)
                            ForEach(row, id: \.self) { column in
                                Button(action: {
                                    if column == "Delete" {
                                        if !self.noBeingEntered.isEmpty{
                                            self.noBeingEntered.removeLast()
                                            if !self.calExpression.isEmpty {
                                                self.calExpression.removeLast()
                                            }
                                            self.calExpression.append(self.noBeingEntered)
                                            if self.calExpression.count > 2 {
                                                if checkIfOperator(str: self.calExpression.last ?? "0"){
                                                    self.calExpression.removeLast()
                                                } else if self.calExpression.last == "" {
                                                    self.calExpression.removeLast()
                                                }
                                                self.finalValue = processExpression(exp: self.calExpression)
                                            }
                                        } else {
                                            if !self.calExpression.isEmpty{
                                                self.calExpression.removeLast()
                                            }
                                            if !self.calExpression.isEmpty{
                                                self.calExpression.removeLast()
                                            }
                                            self.finalValue = processExpression(exp: self.calExpression)
                                        }
                                        return
                                    }
                                    else if checkIfOperator(str: column)  {
                                        if !self.calExpression.isEmpty && !checkIfOperator(str: self.calExpression.last ?? ""){
                                            self.calExpression.append(column)
                                            self.noBeingEntered = ""
                                        } else if checkIfOperator(str: self.calExpression.last ?? ""){
                                        }
                                    }
                                    else {
                                        self.noBeingEntered.append(column)
                                        
                                        if self.calExpression.count == 0 {
                                            self.calExpression.append(self.noBeingEntered)
                                        }
                                        else {
                                            if !checkIfOperator(str: self.calExpression[self.calExpression.count-1]) {
                                                self.calExpression.remove(at: self.calExpression.count-1)
                                            }
                                            self.calExpression.append(self.noBeingEntered)
                                        }
                                    }
                                    if self.calExpression.count > 2 {
                                        self.finalValue = processExpression(exp: self.calExpression)
                                    } else {
                                        self.finalValue =  self.calExpression.first ?? "0"
                                    }
                                    
                                }, label: {
                                    if column == "Delete" {
                                        Image(systemName: "delete.backward")
                                            .font(.title2)
                                            .frame(idealWidth: 100, maxWidth: .infinity, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                                    } else {
                                        Text(column)
                                            .font(.title2)
                                            .frame(idealWidth: 100, maxWidth: .infinity, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                                    }
                                }
                                )
                                    .foregroundColor(column.isNumeric ? .primary : .customPrimary)
                            }
                        }
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 414, maxHeight: .infinity, alignment: .topLeading)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

func checkIfOperator(str:String) -> Bool {
    
    if str == "÷" || str == "×" || str == "−" || str == "+"{
        return true
    }
    
    return false
    
}

func flattenTheExpression(exps: [String]) -> String {
    
    var calExp = ""
    for exp in exps {
        calExp.append(exp)
    }
    
    return calExp
    
}

func processExpression(exp:[String]) -> String {
    
    if exp.count < 3 {
        return exp.first ?? "0"
    }
    
    var a = Double(exp[0])  // Get the first no
    var c = Double("0.0")   // Init the second no
    let expSize = exp.count
    
    for i in (1...expSize-2) {
        
        c = Double(exp[i+1])
        
        switch exp[i] {
        case "+":
            a! += c!
        case "−":
            a! -= c!
        case "×":
            a! *= c!
        case "÷":
            a! /= c!
        default:
            break
        }
    }
    
    return String(format: "%.1f", a!)
}


struct CalculatorComponent_Previews: PreviewProvider {
    @State static var isPresented = true
    @State static var finalValue = "0"
    
    static var previews: some View {
        VStack{
            CalculatorField(finalValue: $finalValue, isPresented: $isPresented)
            HalfASheet(isPresented: $isPresented, title: "") {
                CalculatorComponent(finalValue: $finalValue, isPresented: $isPresented)
            }
        }
    }
}

extension String {

    var isNumeric : Bool {
        return NumberFormatter().number(from: self) != nil
    }

}

