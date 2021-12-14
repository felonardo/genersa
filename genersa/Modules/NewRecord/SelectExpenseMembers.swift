//
//  SelectExpenseMembers.swift
//  genersa
//
//  Created by Joanda Febrian on 14/12/21.
//

import SwiftUI

struct SelectExpenseMembers: View {
    
    @AppStorage("tripCurrency") var currency: String = Currency.allCurrencies.first!.identifier
    
    @FetchRequest(
        entity: Member.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Member.name, ascending: true)
        ]) var members: FetchedResults<Member>
    
    @State var isAddingMember: Bool = false
    
    enum SelectExpenseType {
        case payers, members
    }
    
    let type: SelectExpenseType
    let totalAmount: Double
    var name: String = ""
    
    var title: String {
        switch type {
        case .payers:
            return "Who paid?"
        case .members:
            return "Split with?"
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(members) { member in
                        HStack {
                            Circle()
                                .stroke(lineWidth: 2)
                                .foregroundColor(.customPrimary)
                                .frame(width: 28, height: 28)
                            VStack {
                                HStack {
                                    Text(member.name ?? "N/A")
                                    Spacer()
                                    Button {
                                        
                                    } label: {
                                        Text(member.amount.toCurrency(currency))
                                        Image(systemName: "pencil")
                                    }
                                }
                                Divider()
                            }
                        }
                    }
                    Button {
                        isAddingMember = true
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                                .frame(width: 28, height: 28)
                                .background(
                                    Circle()
                                        .stroke(lineWidth: 2)
                                        .foregroundColor(.customPrimary)
                                        .frame(width: 28, height: 28)
                                )
                            Text("Add Member")
                            Spacer()
                        }
                        .foregroundColor(.customPrimary)
                    }
                    .textFieldAlert(isPresented: $isAddingMember, title: "Add Member", text: title, placeholder: "Member Name") { name in
                        if let name = name {
                            MemberDataSource.shared.createMember(name: name)
                        }
                    }
                }
                .padding(8)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            //
                        } label: {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            //
                        } label: {
                            Text("Save")
                        }
                    }
                }
            }
        }
    }
}
