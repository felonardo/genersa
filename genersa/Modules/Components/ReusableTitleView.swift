//
//  FormField.swift
//  genersa
//
//  Created by Leo nardo on 05/11/21.
//

import SwiftUI


struct FormField: View {
    
    @ObservedObject var field1 = TextBindingManager(limit: 28)
    @ObservedObject var field2 = TextBindingManager(limit: 28)
    
    @State var item = "Currency"
    @State var item2 = 0
    @State var errorState = false
    
    var currency = ["IDR", "USD", "JPN", "EUR"]
    var frequency = ["Daily", "Weekly", "Monthly"]
    
    var body: some View {
        NavigationView{
            VStack{
                ReusableTitleView(title: "Title", description: "This is a sample description that sits", errorState: $errorState){
                    TextFieldComponent(field: $field1.text, placeholder: "Placeholder", errorState: $errorState)
                }
            }
        }
    }
}

struct ReusableTitleView<Content: View>: View {
    
    let title: String
    let description: String
    let content: Content
    var warningDescription: Bool = false
    @Binding var errorState: Bool
    
    init(title: String, description: String, errorState: Binding<Bool>, warningDescription: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.description = description
        self._errorState = errorState
        self.warningDescription = warningDescription
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .bold()
                .font(.headline)
            content
            Text(warningDescription ? (errorState ? description : "") : description)
                .foregroundColor(errorState ? Color.red :Color.gray)
                .font(.footnote)
        }
    }
}

struct TextFieldComponent: View {
    
    @Binding var field: String
    let placeholder: String
    @Binding var errorState: Bool
    let isEditing: Bool
    
    init(field: Binding<String>, placeholder: String, errorState: Binding<Bool>, isEditing: Bool = false) {
        self._field = field
        self.placeholder = placeholder
        self._errorState = errorState
        self.isEditing = isEditing
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField(placeholder, text: $field)
                    .foregroundColor(errorState ? Color.red : Color.black)
                    .multilineTextAlignment(.leading)
                if isEditing {
                    Image(systemName: "pencil")
                        .font(.title2)
                        .foregroundColor(.customPrimary)
                        .padding(.horizontal, 16)
                }
            }
            .padding(.vertical, 8)
            Divider()
                .frame(height: 1)
                .foregroundColor(errorState ? .red : .gray)
        }
    }
}

struct PickerFieldView: View {
    
    
    @Binding var selectedItem: String
    var items: [String]
    
    var body: some View {
        Form {
            Picker(selectedItem, selection: $selectedItem) {
                ForEach(items, id: \.self) {
                    Text($0)
                }
            }
        }
        .padding(.horizontal, -36)
    }
}

struct SelectorFieldView: View {
    
    @Binding var selectedItem: Int
    var items: [String]
    
    var body: some View{
        ScrollView(.horizontal) {
            HStack (alignment: .center, spacing: 4){
                ForEach(0..<items.count, id: \.self) { item in
                    Button(action: {
                        self.selectedItem = item
                    }) {
                        Text("\(self.items[item])")
                            .padding(8)
                            .foregroundColor(self.selectedItem == item ? Color.white : Color.black)
                            .background(self.selectedItem == item ? Color.black : Color.gray.opacity(0.2))
                            .clipShape(Capsule())
                    }
                }
                }
            }
        }
    }




struct FormField_Previews: PreviewProvider {
    static var previews: some View {
        FormField()
    }
}
