//
//  CardShape.swift
//  GameOfSet
//
//  Created by Krzysztof Jankowski on 13/02/2021.
//

import SwiftUI

struct CardShape: Shape {
    
    let shape: Card.Shape
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        switch shape {
        case .diamond:
            path.addPath(Diamond().path(in: rect))
        case .oval:
            path.addPath(Capsule().path(in: rect))
        case .squiggle:
            path.addPath(Squiggle().path(in: rect))
        }
        return path
    }
}

struct CardShape_Previews: PreviewProvider {
    static var previews: some View {
        CardShape(shape: .diamond)
    }
}
