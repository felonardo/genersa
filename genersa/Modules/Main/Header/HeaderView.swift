//
//  HeaderView.swift
//  genersa
//
//  Created by Joanda Febrian on 04/11/21.
//

import SwiftUI

struct HeaderView: View {
    
    @ObservedObject private var viewModel: HeaderViewModel
    
    init(tripName: String, tripStartDate: Date, tripEndDate: Date) {
        self.viewModel = HeaderViewModel(tripName: tripName, tripStartDate: tripStartDate, tripEndDate: tripEndDate)
    }
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    TripName(name: viewModel.tripName)
                    TripLocationLabel(startDate: viewModel.tripStartDate, endDate: viewModel.tripEndDate)
                }
                Spacer()
                #warning("Destination buat button ke settings belom di set.")
                NavigationLink(destination: Text("Settings")) {
                    HeaderButton(imageName: "icon_settings")
                }
            }
        }
        .padding(.top, 16)
        .padding(32)
        .background(
            Rectangle()
                .cornerRadius(50, corners: [.bottomLeft, .bottomRight])
                .foregroundColor(.black.opacity(0.8))
        )
    }
}

struct TripName: View {
    
    let name: String
    
    var body: some View {
        Text(name)
            .font(.largeTitle.bold())
            .foregroundColor(.white)
    }
}

struct TripLocationLabel: View {
    
    let startDate: String
    let endDate: String
    
    init(startDate: Date, endDate: Date) {
        let formatter = DateFormatter.withFormat("d MMM yyyy")
        self.startDate = formatter.string(from: startDate)
        self.endDate = formatter.string(from: endDate)
    }
    
    var body: some View {
        HStack {
            Image(systemName: "airplane")
            Text("\(startDate) - \(endDate)")
        }
        .font(.caption)
        .foregroundColor(.white)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HeaderView(tripName: "Bali 2021", tripStartDate: Date(), tripEndDate: Date().addingTimeInterval(7 * .day))
        }
    }
}
