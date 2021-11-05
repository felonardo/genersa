//
//  CircularProgressBar.swift
//  genersa
//
//  Created by Joanda Febrian on 05/11/21.
//

import SwiftUI

struct CircularProgressBar<Content: View>: View {
    
    @Binding var progress: Double
    let content: Content
    let size: CGFloat
    
    init(size: CGFloat, progress: Binding<Double>, @ViewBuilder content: @escaping () -> Content) {
        self.size = size
        self._progress = progress
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            content
                .frame(width: size, height: size, alignment: .center)
                .clipShape(Circle())
            Circle()
                .stroke(lineWidth: size / 8)
                .foregroundColor(Color.gray)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: size / 8, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.black)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
        }
        .frame(width: size + (size / 8), height: size + (size / 8), alignment: .center)
        .padding(8)
    }
}

struct CircularProgressPreview: View {
    
    @State var progress: Double
    
    var body: some View {
        VStack {
            Button {
                withAnimation {
                    progress = Double.random(in: 0...1)
                }
            } label: {
                CircularProgressBar(size: 48, progress: $progress) {
                    VStack {
                        Text(String(format: "%.0f%%", progress*100.0))
                            .font(.caption)
                    }
                }
                .contentShape(Circle())
            }
            .buttonStyle(.plain)
            
            Button {
                withAnimation {
                    progress = Double.random(in: 0...1)
                }
            } label: {
                CircularProgressBar(size: 48, progress: $progress) {
                    VStack {
                        BudgetIcon(color: Color.red, icon: Image(systemName: "car.fill"), iconSize: 48)
                    }
                }
                .contentShape(Circle())
            }
            .buttonStyle(.plain)
            
            Button {
                withAnimation {
                    progress = Double.random(in: 0...1)
                }
            } label: {
                CircularProgressBar(size: 144, progress: $progress) {
                    VStack {
                        Text("Current Balance")
                            .foregroundColor(.secondary)
                        Text("Rp1.020.000")
                            .bold()
                            .foregroundColor(.primary)
                    }
                }
                .contentShape(Circle())
            }
            .buttonStyle(.plain)
        }
    }
}

struct CircularProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressPreview(progress: 0.8)
    }
}
