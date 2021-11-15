//
//  TripDatePicker.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct TripDatePicker: View {
    
    @ObservedObject private var viewModel: TripDatePickerViewModel
    
    init(startDate: Binding<Date>, endDate: Binding<Date>) {
        viewModel = TripDatePickerViewModel(startDate: startDate, endDate: endDate)
    }
    
    #warning("iOS 15 Bug: Date Picker day names is missing! https://stackoverflow.com/questions/69417738/swiftui-days-name-is-missing-if-you-show-and-hide-datepicker")
    
    var body: some View {
        VStack {
            HStack {
                CustomButton(title: viewModel.startDate.wrappedValue.toString(withFormat: "d MMM yyyy"), type: .secondary, fullWidth: true) {
                    viewModel.showPicker = viewModel.showPicker == .start ? .none : .start
                }
                Image(systemName: "arrow.right")
                    .foregroundColor(.customPrimary)
                CustomButton(title: viewModel.endDate.wrappedValue.toString(withFormat: "d MMM yyyy"), type: .secondary, fullWidth: true) {
                    viewModel.showPicker = viewModel.showPicker == .end ? .none : .end
                }
            }
            switch viewModel.showPicker {
            case .none:
                EmptyView()
            case .start:
                DatePicker("Start Date",
                           selection: viewModel.startDate,
                           displayedComponents: [.date])
                    .datePickerStyle(.graphical)
            case .end:
                DatePicker("End Date",
                           selection: viewModel.endDate,
                           in: viewModel.startDate.wrappedValue...,
                           displayedComponents: [.date])
                    .datePickerStyle(.graphical)
            }
        }
    }
}

struct TripDateFormPreview: View {
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    
    var body: some View {
        TripDatePicker(startDate: $startDate, endDate: $endDate)
    }
}

struct TripDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        TripDateFormPreview()
    }
}
