//
//  CalculatorView.swift
//  genersa
//
//  Created by Leo nardo on 07/11/21.
//


import SwiftUI
import HalfASheet

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
                VStack {
                    HStack{
                        Text(flattenTheExpression(exps: calExpression))
                            .frame(alignment: Alignment.bottomTrailing)
                            .foregroundColor(Color.blue)
                        Spacer()
                        Button(action: {
                            self.isPresented = false
                        }, label: { Text("Done")})
                    }
                    ForEach(rows, id: \.self) { row in
                        HStack(alignment: .top, spacing: 0) {
                            Spacer(minLength: 13)
                            ForEach(row, id: \.self) { column in
                                Button(action: {
                                    if column == "Delete" {
                                        if !self.noBeingEntered.isEmpty{
                                            print("test 0")
                                            self.noBeingEntered.removeLast()
                                            if !self.calExpression.isEmpty {
                                                self.calExpression.removeLast()
                                            }
                                            self.calExpression.append(self.noBeingEntered)
                                            if self.calExpression.count > 2 {
                                                if checkIfOperator(str: self.calExpression.last ?? "0"){
                                                    print("masuk")
                                                    self.calExpression.removeLast()
                                                } else if self.calExpression.last == "" {
                                                    print("masuk3")
                                                    self.calExpression.removeLast()
                                                }
                                                print("masuk2")
                                                print("cal:\(calExpression)")
                                                print("noenter:\(noBeingEntered)")
                                                self.finalValue = processExpression(exp: self.calExpression)
                                            }
                                        } else {
                                            if !self.calExpression.isEmpty{
                                                self.calExpression.removeLast()
                                                print("test 2")
                                            }
                                            if !self.calExpression.isEmpty{
                                                self.calExpression.removeLast()
                                                print("test 2")
                                            }
                                            self.finalValue = processExpression(exp: self.calExpression)
                                            //                                            self.finalValue =  self.calExpression.first ?? "0"
                                            print("test 4")
                                        }
                                        
                                        print("cal:\(calExpression)")
                                        print("noenter:\(noBeingEntered)")
                                        print("tes 0")
                                        return
                                    }
                                    else if checkIfOperator(str: column)  {
                                        if !self.calExpression.isEmpty && !checkIfOperator(str: self.calExpression.last ?? ""){
                                            self.calExpression.append(column)
                                            self.noBeingEntered = ""
                                            print("cal:\(calExpression)")
                                            print("noenter:\(noBeingEntered)")
                                            print("tes 1")
                                        } else if checkIfOperator(str: self.calExpression.last ?? ""){
                                            print("tes 1 alt")
                                        }
                                        print("cal:\(calExpression)")
                                        print("noenter:\(noBeingEntered)")
                                        print("tes 1 not")
                                    }
                                    else {
                                        self.noBeingEntered.append(column)
                                        
                                        if self.calExpression.count == 0 {
                                            self.calExpression.append(self.noBeingEntered)
                                            
                                            print("cal:\(calExpression)")
                                            print("noenter:\(noBeingEntered)")
                                            print("tes 2")
                                        }
                                        else {
                                            if !checkIfOperator(str: self.calExpression[self.calExpression.count-1]) {
                                                self.calExpression.remove(at: self.calExpression.count-1)
                                                
                                                print("cal:\(calExpression)")
                                                print("noenter:\(noBeingEntered)")
                                                print("tes 3")
                                            }
                                            
                                            self.calExpression.append(self.noBeingEntered)
                                            
                                            print("cal:\(calExpression)")
                                            print("noenter:\(noBeingEntered)")
                                            print("tes 4")
                                        }
                                    }
                                    
                                    if self.calExpression.count > 2 {
                                        self.finalValue = processExpression(exp: self.calExpression)
                                    } else {
                                        self.finalValue =  self.calExpression.first ?? "0"
                                    }
                                    
                                }, label: {
                                    Text(column)
                                        .frame(idealWidth: 100, maxWidth: .infinity, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                                }
                                )
                                    .foregroundColor(Color.blue)
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
            print("skipping the rest")
        }
    }
    
    return String(format: "%.1f", a!)
}


struct CalculatorComponent_Previews: PreviewProvider {
    @State static var isPresented = true
    @State static var finalValue = "0"
    
    static var previews: some View {
        
        VStack{
            //            FormField()
            Button(action: {self.isPresented = true}, label: {
                Text("show modal")
            })
            HalfASheet(isPresented: $isPresented, title: "") {
                CalculatorComponent(finalValue: $finalValue, isPresented: $isPresented)
            }
            .disableDragToDismiss
        }
        
    }
}
