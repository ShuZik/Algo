//
//  SamplePoint.swift
//  ALGO
//
//  Created by ShuZik on 18.03.2024.
//

import Foundation
import SwiftUI

struct SamplePoint: Identifiable {
    let id: UUID
    let point: CGPoint
    let color: Color

    init(point: CGPoint, color: Color = Color.random) {
        self.id = UUID()
        self.point = point
        self.color = color
    }
}

extension Color {
    static var random: Color {
        Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}



struct IdentifiablePoint: Identifiable {
    let id: UUID = UUID()
    let point: CGPoint
}
