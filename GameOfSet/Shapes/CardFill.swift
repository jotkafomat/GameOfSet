//
//  CardFill.swift
//  GameOfSet
//
//  Created by Krzysztof Jankowski on 11/02/2021.
//

import SwiftUI

struct CardFill: Shape {
    
    let shading: Card.Shading
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        switch shading {
        case .solid:
            path.addRect(rect)
        case .striped:
            let stepWidth = rect.width / 32
            for step in stride(from: CGFloat.zero, through: rect.width, by: stepWidth) {
                let startingPoint = CGPoint(x: rect.minX + step, y: rect.minY)
                let size = CGSize(width: stepWidth / 3, height: rect.height)
                path.addRect(CGRect(origin: startingPoint, size: size))
            }
        case .open:
            break
        }
        return path
    }
}
struct CardFill_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ForEach(Card.Shading.allCases, id: \.self) {
                CardFill(shading: $0)
            }.frame(width: 100, height: 100, alignment: .center)
            .border(Color.black)
        }
    }
}
