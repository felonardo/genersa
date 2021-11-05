//
//  TextBinding.swift
//  genersa
//
//  Created by Leo nardo on 05/11/21.
//

import Foundation


class TextBindingManager: ObservableObject {
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count <= characterLimit {
                text = oldValue
            }
        }
    }
    let characterLimit: Int
    
    init(limit: Int = 5){
        characterLimit = limit
    }
}
