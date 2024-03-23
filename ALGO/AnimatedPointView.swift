//
//  AnimatedPointView.swift
//  ALGO
//
//  Created by ShuZik on 18.03.2024.
//

import SwiftUI

struct AnimatedPointView: View {
    var point: CGPoint
    @State var isNew: Bool
    @State private var scale: CGFloat = 0
    @State private var isPulsing: Bool = false
    @State private var color: Color = .pink

    let animation = Animation.easeInOut(duration: 0.75).repeatForever(autoreverses: true)
    let colorChangeAnimation = Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: false)

    var body: some View {
        Circle()
            .fill(isNew ? .pink : .black)
            .frame(width: 6, height: 6)
            .scaleEffect(scale)
            .position(point)
            .onAppear {
                withAnimation(.easeOut(duration: 0.25)) {
                    scale = 1
                }
                withAnimation(animation.delay(0.25)) {
                    scale = isPulsing ? randomCarloadValue() : randomCarloadValue()
                    isPulsing.toggle()
                }
                withAnimation(colorChangeAnimation.delay(0.25)) {
                    color = .black
                }
            }
    }

    func randomCarloadValue() -> CGFloat {
        CGFloat.random(in: 0.3...1.0)
    }
}



#Preview {
    AnimatedPointView(point: CGPoint(x: 100, y: 100), isNew: true)
        .previewLayout(.sizeThatFits)
        .padding()
}
