//
//  CircularProgressBar.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct CircularProgressBar<Content: View>: View {
    
    let bars: [Progress]
    let content: Content
    let size: CGFloat
    
    init(size: CGFloat, bars: [Progress], @ViewBuilder content: @escaping () -> Content) {
        self.size = size
        self.bars = bars
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            content
                .frame(width: size, height: size, alignment: .center)
                .clipShape(Circle())
            Circle()
                .stroke(lineWidth: size / 8)
                .foregroundColor(Color.gray.opacity(0.4))
            ForEach(bars, id: \.color) { bar in
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(bar.progress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: size / 8, lineCap: .round, lineJoin: .round))
                    .foregroundColor(bar.color)
                    .rotationEffect(Angle(degrees: 270.0))
            }
        }
        .frame(width: size + (size / 8), height: size + (size / 8), alignment: .center)
        .padding(8)
    }
}

struct Progress {
    let progress: Double
    let color: Color
}

struct CircularProgressPreview<Content: View>: View {
    
    let bars: [Progress]
    let content: Content
    let size: CGFloat
    
    init(size: CGFloat, bars: [Progress], @ViewBuilder content: @escaping () -> Content) {
        self.bars = bars
        self.size = size
        self.content = content()
    }
    
    var body: some View {
        CircularProgressBar(size: size, bars: bars) {
            content
        }
    }
}

struct CircularProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CircularProgressPreview(size: 48, bars: [
                Progress(progress: 0.8, color: Color.red)
            ]) {
                Text("\(Int(80.5))%")
                    .font(.caption)
            }
            CircularProgressPreview(size: 48, bars: [
                Progress(progress: 0.8, color: Color.red)
            ]) {
//                BudgetIcon(color: Color.green, icon: Image(systemName: "car.fill"), iconSize: 48)
                BudgetIcon(image: "car.fill", iconSize: 48)
            }
            CircularProgressPreview(size: 144, bars: [
                Progress(progress: 0.8, color: Color.red),
                Progress(progress: 0.3, color: Color.green)
            ]) {
                VStack {
                    Text("Current Balance")
                        .foregroundColor(.secondary)
                    Text("Rp1.020.000")
                        .bold()
                        .foregroundColor(.primary)
                }
            }
        }
    }
}
