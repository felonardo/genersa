//
//  SavingsList.swift
//  genersa
//
//  Created by Joanda Febrian on 09/11/21.
//

import SwiftUI

struct SavingsList: View {
    
    @ObservedObject private var viewModel: SavingsListViewModel
    
//    init(savingRecords: [SavingRecord]) {
//        self.viewModel = SavingsListViewModel(savings: savingRecords)
//    }
    
    #warning("to be removed, only for dummy testing")
    init(savings: [DummySavingRecord]) {
        self.viewModel = SavingsListViewModel(savings: savings)
    }
    
    var body: some View {
        VStack {
            ForEach(viewModel.savings.prefix(3), id:\.date) { record in
                SavingHistoryComponent(month: record.date, amountSaved: record.amountSaved, totalAmount: record.goal)
                Divider()
            }
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
        SavingsList(savings: [
            DummySavingRecord(amountSaved: 1500000, goal: 2000000, date: Date()),
            DummySavingRecord(amountSaved: 2000000, goal: 2000000, date: Date().addingTimeInterval(-(.day * 30))),
            DummySavingRecord(amountSaved: 2000000, goal: 2000000, date: Date().addingTimeInterval(-(.day * 60))),
        ])
            .environmentObject(TripSettings(currency: Currency.allCurrencies.first!))
    }
}
