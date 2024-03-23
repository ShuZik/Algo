//
//  PoissonDiscView2.swift
//  ALGO
//
//  Created by ShuZik on 18.03.2024.
//

import SwiftUI

//struct ContentView: View {
//    @StateObject private var viewModel = PointsViewModel()
//    let minimumDistance: CGFloat = 10
//
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack {
//                ForEach(viewModel.points, id: \.self) { point in
//                    AnimatedPointView(point: point)
//                }
//            }
//            .onAppear {
//                viewModel.addPointsAsync(areaSize: geometry.size, minimumDistance: minimumDistance)
//            }
//        }
//        .edgesIgnoringSafeArea(.all)
//    }
//}

struct ContentView: View {
    @StateObject private var viewModel = PointsViewModel()
    let minimumDistance: CGFloat = 10

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(viewModel.points) { identifiablePoint in
                    if viewModel.newPoints.contains(where: { $0.id == identifiablePoint.id }) {
                        AnimatedPointView(point: identifiablePoint.point, isNew: true)
                    } else {
                        AnimatedPointView(point: identifiablePoint.point, isNew: false)
                    }
                }
            }
            .onAppear {
                viewModel.addPointsAsync(areaSize: geometry.size, minimumDistance: minimumDistance)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}



#Preview {
    ContentView()
}

