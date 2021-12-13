//
//  MainCard.swift
//  genersa
//
//  Created by Joanda Febrian on 26/11/21.
//

import SwiftUI

struct MainCard: View {
    
    enum MainCardType {
        case budgets, expenses, savings
    }
    
    let type: MainCardType
    var progress: Double = 0.0
    let title: String
    let description: String
    var time: String = ""
    
    var body: some View {
        HStack {
            if type == .budgets || type == .savings {
                CircularProgressBar(size: 48, bars: [
                    Progress(progress: progress, color: .four)
                ]) {
                    Text("\(Int(progress*100))%")
                        .font(.caption)
                }
            }
            VStack {
                Text(title)
                Text(description)
                    .bold()
            }
            Spacer()
            if type == .expenses {
                VStack {
                    Text(time)
                    Spacer()
                }
            }
        }
    }
}
