//
//  PointsViewModel.swift
//  ALGO
//
//  Created by ShuZik on 18.03.2024.
//

import SwiftUI

@MainActor
class PointsViewModel: ObservableObject {
    @Published var points: [IdentifiablePoint] = []
    @Published var newPoints: [IdentifiablePoint] = [] // Для хранения новых точек
    
    func addPointsAsync(areaSize: CGSize, minimumDistance: CGFloat, sampleSize: Int = 30) {
        Task {
            let generatedPoints = generatePoissonPoints(areaSize: areaSize, minimumDistance: minimumDistance, sampleSize: sampleSize)
            
            await addNewPoints(points: generatedPoints)
        }
    }
    
    private func addNewPoints(points: [CGPoint]) async {
        for point in points {
            let identifiablePoint = IdentifiablePoint(point: point)
            try? await Task.sleep(for: .milliseconds(5)) // 5 миллисекунд
            DispatchQueue.main.async {
                self.points.append(identifiablePoint) // Добавляем в общий список
                self.newPoints.append(identifiablePoint) // Добавляем в список новых точек
            }
            try? await Task.sleep(for: .milliseconds(10)) // Пауза, чтобы избежать одновременного добавления всех точек
            DispatchQueue.main.async {
                self.newPoints.removeAll { $0.id == identifiablePoint.id } // Удаляем из списка новых после добавления
            }
        }
    }

    private func generatePoissonPoints(areaSize: CGSize, minimumDistance: CGFloat, sampleSize: Int = 30) -> [CGPoint] {
        var samplePoints: [CGPoint] = []
        var activeList: [CGPoint] = []
        
        let initialPoint = CGPoint(x: areaSize.width / 2, y: areaSize.height / 2)
        samplePoints.append(initialPoint)
        activeList.append(initialPoint)
        
        while !activeList.isEmpty {
            let pointIndex = Int.random(in: 0..<activeList.count)
            let basePoint = activeList[pointIndex]
            
            var found = false
            for _ in 0..<sampleSize {
                let angle = Double.random(in: 0..<(2 * .pi))
                let radius = CGFloat.random(in: minimumDistance..<(2 * minimumDistance))
                let newPoint = CGPoint(x: basePoint.x + CGFloat(cos(angle)) * radius, y: basePoint.y + CGFloat(sin(angle)) * radius)
                
                let isFarEnough = samplePoints.allSatisfy { $0.distance(to: newPoint) >= minimumDistance }
                let isInBounds = newPoint.x >= 0 && newPoint.y >= 0 && newPoint.x <= areaSize.width && newPoint.y <= areaSize.height
                
                if isFarEnough && isInBounds {
                    samplePoints.append(newPoint)
                    activeList.append(newPoint)
                    found = true
                    break
                }
            }
            
            if !found {
                activeList.remove(at: pointIndex)
            }
        }
        
        return samplePoints
    }
}

