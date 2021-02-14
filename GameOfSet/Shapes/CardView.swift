//
//  CardView.swift
//  GameOfSet
//
//  Created by Krzysztof Jankowski on 13/02/2021.
//

import SwiftUI

struct CardView: View {
    
    let card: Card
    
    private var foregroundColor: Color {
        switch card.color {
        case .red:
            return Color.red
        case .green:
            return Color.green
        case .purple:
            return Color.purple
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(card.isSelected ? Color.blue : Color.black)
                .foregroundColor(.white)
                .padding()
            VStack(spacing: 4) {
                ForEach(0 ..< card.number.rawValue) { item in
                    ZStack {
                        CardFill(shading: card.shading)
                            .clipShape(CardShape(shape: card.shape))
                        CardShape(shape: card.shape)
                            .stroke()
                    }
                    
                    .foregroundColor(foregroundColor)
                    .aspectRatio(1.5, contentMode: .fit)
                    .padding(.horizontal)
                }
            }
            .padding()
        }
        .aspectRatio(2/3, contentMode: .fit)
        .scaleEffect(card.isMatched ? 1.1 : 0.9)
    }
}

struct CardView_Previews: PreviewProvider {
    
    static let card1 = Card(shape: .diamond, number: .one, color: .green, shading: .open, isSelected: true)
    static let card2 = Card(shape: .oval, number: .two, color: .purple, shading: .solid, isSelected: true, isMatched: true)
    static let card3 = Card(shape: .squiggle, number: .three, color: .red, shading: .striped)
    
    static var previews: some View {
        
        VStack{
            CardView(card: card1)
            CardView(card: card2)
            CardView(card: card3)
        }
    }
}
