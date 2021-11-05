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
    @Binding var errorState: Bool
    
    init(title: String, description: String, errorState: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.description = description
        self._errorState = errorState
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .bold()
                .font(.title2)
            content
            Text(description)
                .foregroundColor(errorState ? Color.red :Color.gray)
                .font(.footnote)
        }.padding(8)
    }
}

struct TextFieldComponent: View {
    
    @Binding var field: String
    var placeholder: String
    @Binding var errorState: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField(placeholder, text: $field)
                .foregroundColor(checkError() ? Color.red : Color.black)
            Divider()
                .frame(height: 1)
                .padding(.horizontal, 30)
                .background(errorState ? Color.red :Color.black)
        }
    }
    
    func checkError() -> Bool {
//        if field.contains("@") {
//            errorState = true
//            return errorState
//        }
        errorState = false
        return errorState
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
