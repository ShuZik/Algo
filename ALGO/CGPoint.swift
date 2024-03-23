//
//  CGPoint.swift
//  ALGO
//
//  Created by ShuZik on 18.03.2024.
//

import Foundation

extension CGPoint: Hashable {
    func distance(to point: CGPoint) -> CGFloat {
        sqrt((x - point.x) * (x - point.x) + (y - point.y) * (y - point.y))
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

