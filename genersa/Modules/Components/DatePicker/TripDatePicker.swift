//
//  TripDatePicker.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct TripDatePicker: View {
    
    @StateObject private var viewModel = TripDatePickerViewModel()
    
    #warning("iOS 15 Bug: Date Picker day names is missing! https://stackoverflow.com/questions/69417738/swiftui-days-name-is-missing-if-you-show-and-hide-datepicker")
    
    var body: some View {
        VStack {
            HStack {
                CustomButton(title: viewModel.startDate.toString(withFormat: "d MMM yyyy"), type: .secondary, fullWidth: true) {
                    viewModel.showPicker = viewModel.showPicker == .start ? .none : .start
                }
                Image(systemName: "arrow.right")
                    .foregroundColor(.customPrimary)
                CustomButton(title: viewModel.endDate.toString(withFormat: "d MMM yyyy"), type: .secondary, fullWidth: true) {
                    viewModel.showPicker = viewModel.showPicker == .end ? .none : .end
                }
            }
            .onChange(of: viewModel.startDate, perform: { newValue in
                viewModel.endDate = viewModel.startDate.addingTimeInterval(viewModel.duration)
            })
            .onChange(of: viewModel.endDate, perform: { newValue in
                viewModel.duration = viewModel.endDate.timeIntervalSince1970 - viewModel.startDate.timeIntervalSince1970
            })
            switch viewModel.showPicker {
            case .none:
                EmptyView()
            case .start:
                DatePicker("Start Date",
                           selection: viewModel.$startDate,
                           displayedComponents: [.date])
                    .datePickerStyle(.graphical)
            case .end:
                DatePicker("End Date",
                           selection: viewModel.$endDate,
                           in: viewModel.startDate...,
                           displayedComponents: [.date])
                    .datePickerStyle(.graphical)
            }
        }
    }
}

struct TripDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        TripDatePicker()
    }
}
