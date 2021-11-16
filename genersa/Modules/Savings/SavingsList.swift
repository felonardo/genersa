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
    
    @FetchRequest(
        entity: SavingRecord.entity(),
        sortDescriptors: [
            
        ]) var savings: FetchedResults<SavingRecord>
    
    
//    init(savingRecords: [SavingRecord]) {
//        self.viewModel = SavingsListViewModel(savings: savingRecords)
//    }
    
    init(recents: Bool = false) {
        self.viewModel = SavingsListViewModel()
        self.recents = recents
    }
    
    var body: some View {
        if recents {
            VStack(spacing: 4) {
                ForEach(savings, id:\.date) { record in
                    SavingHistoryComponent(month: record.date!, amountSaved: record.amountSaved, totalAmount: record.goal)
                    Divider()
                        .padding(.leading, 64)
                        .padding(.trailing, -16)
                }
            }
        } else {
            ScrollView {
                LazyVStack(spacing: 4) {
                    ForEach(savings, id:\.date) { record in
                        SavingHistoryComponent(month: record.date!, amountSaved: record.amountSaved, totalAmount: record.goal)
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

final class SavingsListViewModel: ObservableObject {
    
//    @FetchRequest(
//        entity: SavingRecord.entity(),
//        sortDescriptors: [
//
//        ]) var savings: FetchedResults<SavingRecord>
//
}

struct SavingsList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SavingsList()
        }
    }
}
