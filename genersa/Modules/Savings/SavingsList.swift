//
//  SavingsList.swift
//  genersa
//
//  Created by Joanda Febrian on 09/11/21.
//

import SwiftUI

struct SavingsList: View {
    
    @ObservedObject private var viewModel: SavingsListViewModel
    let recents: Bool
    
//    init(savingRecords: [SavingRecord]) {
//        self.viewModel = SavingsListViewModel(savings: savingRecords)
//    }
    
    #warning("to be removed, only for dummy testing")
    init(savings: [DummySavingRecord], recents: Bool = false) {
        self.viewModel = SavingsListViewModel(savings: savings)
        self.recents = recents
    }
    
    var body: some View {
        if recents {
            VStack(spacing: 4) {
                ForEach(viewModel.savings, id:\.date) { record in
                    SavingHistoryComponent(month: record.date, amountSaved: record.amountSaved, totalAmount: record.goal)
                    Divider()
                        .padding(.leading, 64)
                        .padding(.trailing, -16)
                }
            }
        } else {
            ScrollView {
                LazyVStack(spacing: 4) {
                    ForEach(viewModel.savings, id:\.date) { record in
                        SavingHistoryComponent(month: record.date, amountSaved: record.amountSaved, totalAmount: record.goal)
                        Divider()
                            .padding(.leading, 64)
                            .padding(.trailing, -16)
                    }
                }
                .padding(16)
            }
            .navigationTitle("Savings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DummySavingRecord {
    let amountSaved: Double
    let goal: Double
    let date: Date
}

final class SavingsListViewModel: ObservableObject {
    
    @Published var savings: [DummySavingRecord]
    
    #warning("to be removed, only for dummy testing")
    init(savings: [DummySavingRecord]) {
        self.savings = savings
    }
}

struct SavingsList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SavingsList(savings: [
                DummySavingRecord(amountSaved: 1500000, goal: 2000000, date: Date()),
                DummySavingRecord(amountSaved: 2000000, goal: 2000000, date: Date().addingTimeInterval(-(.day * 30))),
                DummySavingRecord(amountSaved: 2000000, goal: 2000000, date: Date().addingTimeInterval(-(.day * 60))),
            ])
        }
        .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
    }
}
