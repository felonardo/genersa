//
//  CategorizeBudgetView.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 14/12/21.
//

import SwiftUI

struct CategorizeBudgetView: View {
    @State private var enableCatBudget = false
    
    var body: some View {
            VStack( spacing: 5) {
                Form {
                    Group{
                        Section(footer: Text("Categorize your budget to have a better focus on how you’ll spend money while travelling.")) {
                            Toggle("Enable Budget Categories", isOn: $enableCatBudget.animation()).foregroundColor(.two)
                        }
                    }.listRowBackground(Color.eleven)
                }
                if enableCatBudget {
                    HStack() {
                        Text("Categories").font(.headline)
                        Spacer()
                        Button("Add Budget", action: {
                            print("Button Tapped")
                        })
                    }.padding()
                    Form {
                        Group{
                            FormRowLinkView_2(firstText: "Accomodation", secondText: "Rp0")
                            FormRowLinkView_2(firstText: "Flight", secondText: "Rp0")
                            FormRowLinkView_2(firstText: "Meal", secondText: "Rp0")
                            FormRowLinkView_2(firstText: "Transport", secondText: "Rp0")
                        }
                        .foregroundColor(.three)
                        .listRowBackground(Color.eleven)
                    }
                    Spacer()
                    
                }
               
                
            }
            .navigationTitle("Categorize Budget")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white)
            .onAppear{
                UITableView.appearance().backgroundColor = .clear
            }
        }
    }

struct CategorizeBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        CategorizeBudgetView()
        }
    }
}
