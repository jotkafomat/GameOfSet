//
//  Squiggle.swift
//  GameOfSet
//
//  Created by Krzysztof Jankowski on 11/02/2021.
//

import SwiftUI

struct Squiggle: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.maxX,
                              y: rect.maxY * 0.18))
        path.addCurve(to: CGPoint(x: (rect.maxX * 1.0),
                                  y: (rect.maxY * 0.42)),
                      control1: CGPoint(x: (rect.maxX * 1.01),
                                        y: (rect.maxY * 0.23)),
                      control2: CGPoint(x: (rect.maxX * 1.02),
                                        y: (rect.maxY * 0.31)))
        path.addCurve(to: CGPoint(x: (rect.maxX * 0.74),
                                  y: (rect.maxY * 0.92)),
                      control1: CGPoint(x: (rect.maxX * 0.97),
                                        y: (rect.maxY * 0.64)),
                      control2: CGPoint(x: (rect.maxX * 0.87),
                                        y: (rect.maxY * 0.87)))
        path.addCurve(to: CGPoint(x: (rect.maxX * 0.62),
                                  y: (rect.maxY * 0.92)),
                      control1: CGPoint(x: (rect.maxX * 0.71),
                                        y: (rect.maxY * 0.93)),
                      control2: CGPoint(x: (rect.maxX * 0.67),
                                        y: (rect.maxY * 0.93)))
        path.addCurve(to: CGPoint(x: (rect.maxX * 0.45),
                                  y: (rect.maxY * 0.82)),
                      control1: CGPoint(x: (rect.maxX * 0.55),
                                        y: (rect.maxY * 0.9)),
                      control2: CGPoint(x: (rect.maxX * 0.52),
                                        y: (rect.maxY * 0.85)))
        path.addCurve(to: CGPoint(x: (rect.maxX * 0.24),
                                  y: (rect.maxY * 0.86)),
                      control1: CGPoint(x: (rect.maxX * 0.35),
                                        y: (rect.maxY * 0.78)),
                      control2: CGPoint(x: (rect.maxX * 0.27),
                                        y: (rect.maxY * 0.82)))
        path.addCurve(to: CGPoint(x: (rect.maxX * 0.14),
                                  y: (rect.maxY * 1.0)),
                      control1: CGPoint(x: (rect.maxX * 0.20),
                                        y: (rect.maxY * 0.91)),
                      control2: CGPoint(x: (rect.maxX * 0.18),
                                        y: (rect.maxY * 0.97)))
        path.addCurve(to: CGPoint(x: (rect.maxX * 0.07),
                                  y: (rect.maxY * 1.0)),
                      control1: CGPoint(x: (rect.maxX * 0.11),
                                        y: (rect.maxY * 1.02)),
                      control2: CGPoint(x: (rect.maxX * 0.08),
                                        y: (rect.maxY * 1.01)))
        path.addCurve(to: CGPoint(x: (rect.maxX * 0),
                                  y: (rect.maxY * 0.5)),
                      control1: CGPoint(x: (rect.maxX * 0),
                                        y: (rect.maxY * 0.94)),
                      control2: CGPoint(x: (rect.minX - rect.width * 0.02),
                                        y: (rect.maxY * 0.67)))
        path.addCurve(to: CGPoint(x: (rect.maxX * 0.16),
                                  y: (rect.maxY * 0.06)),
                      control1: CGPoint(x: (rect.maxX * 0.01),
                                        y: (rect.maxY * 0.39)),
                      control2: CGPoint(x: (rect.maxX * 0.05),
                                        y: (rect.maxY * 0.15)))
        path.addCurve(to: CGPoint(x: (rect.maxX * 0.34),
                                  y: (rect.maxY * 0.06)),
                      control1: CGPoint(x: (rect.maxX * 0.18),
                                        y: (rect.maxY * 0.04)),
                      control2: CGPoint(x: (rect.maxX * 0.26),
                                        y: (rect.maxY * 0.02)))
        path.addCurve(to: CGPoint(x: (rect.maxX * 0.55),
                                  y: (rect.maxY * 0.2)),
                      control1: CGPoint(x: (rect.maxX * 0.43),
                                        y: (rect.maxY * 0.10)),
                      control2: CGPoint(x: (rect.maxX * 0.47),
                                        y: (rect.maxY * 0.17)))
        path.addCurve(to: CGPoint(x: (rect.maxX * 0.71),
                                  y: (rect.maxY * 0.2)),
                      control1: CGPoint(x: (rect.maxX * 0.62),
                                        y: (rect.maxY * 0.22)),
                      control2: CGPoint(x: (rect.maxX * 0.68),
                                        y: (rect.maxY * 0.21)))
        path.addCurve(to: CGPoint(x: (rect.maxX * 0.93),
                                  y: (rect.maxY * 0)),
                      control1: CGPoint(x: (rect.maxX * 0.79),
                                        y: (rect.maxY * 0.16)),
                      control2: CGPoint(x: (rect.maxX * 0.86),
                                        y: (rect.minY - rect.width * 0.03)))
        path.addCurve(to: CGPoint(x: (rect.maxX * 1),
                                  y: (rect.maxY * 0.18)),
                      control1: CGPoint(x: (rect.maxX * 0.97),
                                        y: (rect.maxY * 0.02)),
                      control2: CGPoint(x: (rect.maxX * 0.99),
                                        y: (rect.maxY * 0.13)))
        return path
    }
}


struct Squiggle_Previews: PreviewProvider {
    static var previews: some View {
        Squiggle()
            .fill(Color.orange)
            .aspectRatio(3/2, contentMode: .fit)
            .padding()
    }
}

