//
//  DateTimePicker.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct DateTimePicker: View {
    
    @ObservedObject private var viewModel: DateTimePickerViewModel
    
    init(text: String, date: Binding<Date>) {
        viewModel = DateTimePickerViewModel(text: text, date: date)
    }
    
    #warning("iOS 15 Bug: Date Picker day names is missing! https://stackoverflow.com/questions/69417738/swiftui-days-name-is-missing-if-you-show-and-hide-datepicker")
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.text)
                Spacer()
                CustomButton(title: viewModel.date.wrappedValue.toString(withFormat: "MMM d, yyyy, HH:mm"), type: .secondary, fullWidth: false) {
                    viewModel.showPicker.toggle()
                }
            }
            if viewModel.showPicker {
                DatePicker("Date Time",
                           selection: viewModel.date,
                           displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.graphical)
            }
        }
    }
}

final class DateTimePickerViewModel: ObservableObject {
    
    @Published var text: String
    @Published var date: Binding<Date>
    @Published var showPicker: Bool = false
    
    init(text: String, date: Binding<Date>) {
        self.text = text
        self.date = date
    }
    
}

struct DateTimeFormPreview: View {
    @State var date: Date = Date()
    
    var body: some View {
        DateTimePicker(text: "Set Date", date: $date)
    }
}

struct DateTimePicker_Previews: PreviewProvider {
    static var previews: some View {
        DateTimeFormPreview()
    }
}
