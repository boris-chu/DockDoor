//
//  AnimatedGradientOverlay.swift
//  DockDoor
//
//  Created by Ethan Bills on 6/12/24.
//

import SwiftUI

struct AnimatedGradientOverlay: View {
    @State private var animate = false
    
    // Start with shuffled colors
    @State private var linearColors: [Color] = [.purple, .blue, .green, .yellow, .red, .purple].shuffled()
    @State private var angularColors: [Color] = [.red, .orange, .pink, .blue, .purple].shuffled()

    var body: some View {
        ZStack {
            // Linear Gradient
            LinearGradient(gradient: Gradient(colors: linearColors),
                           startPoint: animate ? .topLeading : .bottomTrailing,
                           endPoint: animate ? .bottomTrailing : .topLeading)
            .blendMode(.overlay)
            .blur(radius: 50)
            .animation(.linear(duration: 5.0).repeatForever(autoreverses: false), value: animate)

            // Angular Gradient
            AngularGradient(gradient: Gradient(colors: angularColors),
                           center: .center,
                           startAngle: .degrees(animate ? 0 : 360),
                           endAngle: .degrees(animate ? 360 : 0))
            .blendMode(.overlay)
            .opacity(0.3)
            .blur(radius: 50)
            .animation(.linear(duration: 7.0).repeatForever(autoreverses: false), value: animate)
        }
        .onAppear {
            self.animate = true
            randomizeColors(delay: 5.0) // Initial delay
        }
        .opacity(0.3)
    }

    private func randomizeColors(delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation(.linear(duration: 5.0)) {
                linearColors.shuffle()
                angularColors.shuffle()
            }
            randomizeColors(delay: 8.0)
        }
    }
}
